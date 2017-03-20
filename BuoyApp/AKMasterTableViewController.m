//
//  AKMasterTableViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/17/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKMasterTableViewController.h"
#import "AKBuoyModel+CoreDataClass.h"
#import "AKServerManager.h"

#import "M13ProgressHUD.h"
#import "M13ProgressViewRing.h"

static int rootID = -1;

@interface AKMasterTableViewController ()

@property (weak, nonatomic) M13ProgressHUD *HUD;

@end

@implementation AKMasterTableViewController

- (void)loadView {
    [super loadView];

    if (!self.parentID) {
        self.parentID = rootID;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.tableTitle;
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(test)];
//    self.navigationItem.rightBarButtonItem = item;
    
    M13ProgressHUD *HUD = [[M13ProgressHUD alloc] initWithProgressView:[[M13ProgressViewRing alloc] init]];
    HUD = [[M13ProgressHUD alloc] initWithProgressView:[[M13ProgressViewRing alloc] init]];
    HUD.progressViewSize = CGSizeMake(60.0, 60.0);
    HUD.animationPoint = CGPointMake(CGRectGetMaxX(self.view.bounds) / 2, CGRectGetMaxY(self.view.bounds) / 2);
    HUD.primaryColor = [UIColor whiteColor];
    HUD.secondaryColor = [UIColor clearColor];
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [window addSubview:HUD];
    
    self.HUD = HUD;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getBuoysFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getBuoysFromServer {
    if (self.fetchedResultsController.fetchedObjects.count == 0) {
        self.HUD.status = @"Loading";
        [self.HUD show:YES];
        
        [[AKServerManager sharedManager] getBuoysListWith:^(CGFloat progress, NSDictionary *response, NSError *error) {
            [self animateProgress:progress];
            
            if (response) {
                self.fetchedResultsController = nil;
            }
        }];
    }
}

#pragma mark - ProgressHUD animation

- (void)animateProgress:(CGFloat)progress {
    [self.HUD setProgress:progress animated:YES];
    if (progress >= 1) {
        [self performSelector:@selector(setComplete) withObject:nil afterDelay:self.HUD.animationDuration + .1];
    }
}

- (void)setOne
{
    [self.HUD setProgress:1.0 animated:YES];
    [self performSelector:@selector(setComplete) withObject:nil afterDelay:self.HUD.animationDuration + .1];
}

- (void)setComplete
{
    [self.HUD performAction:M13ProgressViewActionSuccess animated:YES];
    [self performSelector:@selector(reset) withObject:nil afterDelay:1.5];
}

- (void)reset
{
    [self.HUD hide:YES];
    [self.HUD performAction:M13ProgressViewActionNone animated:NO];
    [self.tableView reloadData];

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

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object {
    AKBuoyModel *buoy = (AKBuoyModel *)object;
    cell.textLabel.text = buoy.name;
    cell.detailTextLabel.text = nil;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AKBuoyModel *buoy = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    NSLog(@"VisibleOnBuoys: %zd, ItemType: %zd",buoy.visibleOnBuoys, buoy.itemType);
    NSLog(@"ParentID: %zd, locationID: %zd",buoy.parentId, buoy.locationId);
    
    if (buoy.itemType == 1 || buoy.parentId == rootID) {
        AKMasterTableViewController * vc = [[AKMasterTableViewController alloc]initWithStyle:UITableViewStylePlain];
        vc.parentID = buoy.locationId;
        vc.tableTitle = buoy.name;
        [self.navigationController pushViewController:vc animated:YES];

    } else if (buoy.visibleOnBuoys == 1 && buoy.itemType == 2) {
        
    }

}



@end
