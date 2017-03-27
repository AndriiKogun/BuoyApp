//
//  AKCoreDataManager.h
//  BuoyApp
//
//  Created by Andrii on 3/17/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AKCoreDataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (AKCoreDataManager *)sharedManager;

- (NSArray *)allObjects;

- (void)createObjectFromServerWith:(NSDictionary *)response isFinished:(void(^)(bool status))finished;
- (void)deleteAllObjects;
- (void)printArray:(NSArray *)array;
- (void)saveContext;

@end
