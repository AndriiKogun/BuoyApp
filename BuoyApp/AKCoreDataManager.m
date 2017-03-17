//
//  AKCoreDataManager.m
//  BuoyApp
//
//  Created by Andrii on 3/17/17.
//  Copyright © 2016 Andrii. All rights reserved.
//

#import "AKCoreDataManager.h"
#import "AKServerManager.h"
#import "AKBuoyModel+CoreDataClass.h"

@interface AKCoreDataManager ()

@property (assign, nonatomic) double currentTime;

@end

@implementation AKCoreDataManager

+ (AKCoreDataManager *)sharedManager {
    static AKCoreDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AKCoreDataManager alloc] init];
    });
    return manager;
}

- (void)getBuoysFromServer {
    [[AKServerManager sharedManager] getBuoysListWith:^(NSDictionary *response, NSError *error) {
        self.currentTime = CACurrentMediaTime();
        [self addBuoys:response];
        [self saveContext];
        
        NSLog(@"Time ---------------- %f", CACurrentMediaTime() - self.currentTime);
    }];
}

- (void)addBuoys:(NSDictionary *)buoys {
    id responseItems = [buoys objectForKey:@"Items"];
    if ([responseItems isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)responseItems) {
            [self setBuoyWith:item];
            [self addBuoys:item];
        }
    } else {
        [self setBuoyWith:buoys];
    }
}

- (void)setBuoyWith:(NSDictionary *)item {
    AKBuoyModel *buoy = [NSEntityDescription insertNewObjectForEntityForName:@"AKBuoyModel"
                                                      inManagedObjectContext:self.managedObjectContext];
    
    buoy.filterType = [[item objectForKey:@"FilterType"] integerValue];
    buoy.inactiveInUI = [[item objectForKey:@"InactiveInUI"] boolValue];
    buoy.itemType = [[item objectForKey:@"ItemType"] integerValue];
    buoy.level = [[item objectForKey:@"Level"] integerValue];
    buoy.locationId = [[item objectForKey:@"LocationId"] intValue];
    buoy.name = [item objectForKey:@"Name"];
    buoy.parentId = [[item objectForKey:@"ParentId"] intValue];
    
    buoy.visibleOnBuoys = [[item objectForKey:@"VisibleOnBuoys"] integerValue];
    buoy.visibleOnMarineForecast = [[item objectForKey:@"VisibleOnMarineForecast"] integerValue];
    buoy.visibleOnMoonPhases = [[item objectForKey:@"VisibleOnMoonPhases"] integerValue];
    buoy.visibleOnRadar = [[item objectForKey:@"VisibleOnRadar"] integerValue];
    buoy.visibleOnSeaSurfaceTemp = [[item objectForKey:@"VisibleOnSeaSurfaceTemp"] integerValue];
    buoy.visibleOnTides = [[item objectForKey:@"VisibleOnTides"] integerValue];
    buoy.visibleOnWavewatch= [[item objectForKey:@"VisibleOnWavewatch"] integerValue];
    buoy.visibleOnWeatherForecast = [[item objectForKey:@"VisibleOnWeatherForecast"] integerValue];
}

- (void)deleteAllObjects {
    NSArray *array = [self allObjects];
    
    for (id object in array) {
        [self.managedObjectContext deleteObject:object];
    }
    [self saveContext];
}

- (NSArray *)allObjects {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"AKBuoyModel"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    NSError *requestError = nil;
    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@",[requestError localizedDescription]);
    }
    return resultArray;
}

- (void)printArray:(NSArray *)array {
    
    for (AKBuoyModel *buoyModel in array) {
        NSLog(@"%@",buoyModel);
    }
    NSLog(@"%zd", array.count);
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = self.persistentContainer.viewContext;
    }
    return _managedObjectContext;
}

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"BuoyApp"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


@end
