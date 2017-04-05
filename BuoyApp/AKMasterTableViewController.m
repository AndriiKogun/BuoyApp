//
//  AKMasterTableViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/17/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKMasterTableViewController.h"
#import "AKBuoyModel+CoreDataClass.h"
#import "AKBuoyInfoTableViewController.h"
#import "AKTidalTableViewController.h"
#import "AKTableRepresentation.h"

#import "AKServerManager.h"
#import "AKCoreDataManager.h"

#import "SVProgressHUD.h"
#import "AKUtilis.h"
#import "LGSideMenuController.h"

#import "UIRefreshControl+AFNetworking.h"

typedef NS_ENUM(NSInteger, AKState) {
    AKStateHiden,
    AKStateVisible,
};

typedef NS_ENUM(NSInteger, AKItemType) {
    AKItemTypeRoot,
    AKItemTypeChildItems,
    AKItemTypeDetail,
};

@interface AKMasterTableViewController ()

@end

@implementation AKMasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.parentID) {
        NSArray *titles = [AKTableRepresentation tableRepresentation] [@"titles"];
        NSArray *parentIDs = [AKTableRepresentation tableRepresentation] [@"parentIDs"];
        self.showAnimated = YES;
        self.parentID = [[parentIDs firstObject] intValue];
        self.title = [titles firstObject];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.fetchedResultsController = nil;
    
    [self firstTableLoad]; // for test on simulator
}

- (void)reachabilityChanged:(NSNotification *)notification {
    [super reachabilityChanged:notification];
    
    [self firstTableLoad];
}

- (void)firstTableLoad {
    if (!loadedDataFromServer() && [self isNetworkAvailable]) {
        [self getDataFromServer];
    }
}

- (void)reload:(id)sender {
    if ([self isNetworkAvailable]) {
        NSURLSessionDataTask *task = [[AKServerManager sharedManager] getItemsListWith:^(CGFloat progress, NSDictionary *response, NSError *error) {
            if (response) {
                self.fetchedResultsController = nil;
                [self.tableView reloadData];
            }
        }];
        [self.refreshControl setRefreshingWithStateOfTask:task];
        
    } else {
        [self showNetworkAlert];
    }
}

- (void)getDataFromServer {
    NSURLSessionDataTask *task = [[AKServerManager sharedManager] getItemsListWith:^(CGFloat progress, NSDictionary *response, NSError *error) {
        [SVProgressHUD showProgress:progress status:[NSString stringWithFormat:@"Loading...\n%.0f%%", progress * 100]];
        
        if (response) {
            self.fetchedResultsController = nil;
            [self dismissProgressHUDandRefreshing];
            loadFinished();
        }
    }];
    [self.refreshControl setRefreshingWithStateOfTask:task];
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[AKCoreDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}

#pragma mark - NSFetchedResultsController

@synthesize fetchedResultsController = _fetchedResultsController;

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AKBuoyModel" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parentId == %d",self.parentID];
    [fetchRequest setPredicate:predicate];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    self.fetchedResultsController = aFetchedResultsController;

    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {

        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _fetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];

    AKBuoyModel *buoy = (AKBuoyModel *)object;
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    cell.textLabel.text = buoy.name;
    cell.backgroundColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AKBuoyModel *buoy = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    if (buoy.itemType == AKItemTypeChildItems) {
        AKMasterTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AKMasterTableViewController"];
        vc.parentID = buoy.locationId;
        vc.title = buoy.name;
        
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
    } else if (buoy.itemType == AKItemTypeDetail) {
        
        if (buoy.visibleOnBuoys == AKStateVisible) {
            AKBuoyInfoTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AKBuoyInfoTableViewController"];
            vc.visibleOn = AKVisibleOnBuoys;
            vc.locationID = buoy.locationId;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if (buoy.visibleOnTides == AKStateVisible) {
            
            if (buoy.visibleOnMoonPhases == AKStateVisible) {
                AKTidalTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AKTidalTableViewController"];
                vc.visibleOn = AKVisibleOnTides | AKVisibleOnMoonPhases;
                vc.locationID = buoy.locationId;
                
                [self.navigationController pushViewController:vc animated:YES];

            } else {
                AKTidalTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AKTidalTableViewController"];
                vc.visibleOn = AKVisibleOnTides;
                vc.locationID = buoy.locationId;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        } else {
            [self showPlaceholderViewController];
            return;
        }
    }
}



@end
