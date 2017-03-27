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
#import "AKBuoyInfoTableViewController.h"
#import "AKTidalTableViewController.h"

#import "AKUtilis.h"

#import "LGSideMenuController.h"
#import "UIViewController+LGSideMenuController.h"

typedef NS_ENUM(NSInteger, AKState) {
    AKStateHiden,
    AKStateVisible,
};

typedef NS_ENUM(NSInteger, AKItemType) {
    AKItemTypeRoot,
    AKItemTypeChildItems,
    AKSateTypeDetail,
};

static int const buoysID = 34655;
static int const marineForecastID = 40454;
static int const radarID = 45585;
static int const seaTemperatureID = 41121;
static int const tidesID = 50319;
static int const wavewatchID = 41147;
static int const weatherForecastID = 37062;

@interface AKMasterTableViewController ()

@property (assign ,nonatomic) int parentID;

@end

@implementation AKMasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    introFinished();
 
    if (!loadedDataFromServer()) {
        [self getDataFromServer];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(progressHUDDidDisappear:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
    
    if (self.navigationController.viewControllers.count == 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Menu"] style:UIBarButtonItemStylePlain target:self action:@selector(openLeftView:)];
    }
}

-(void)setType:(AKType)type {
    _type = type;
    
        switch (type) {
            case AKTypeBuoys:
                self.parentID = buoysID;
                self.title = @"Buoys";
                break;
            case AKTypeMarineForecast:
                self.parentID = marineForecastID;
                self.title = @"Marine Forecast";
                break;
            case AKTypeRadars:
                self.parentID = radarID;
                self.title = @"Radars";
                break;
            case AKTypeSeaSurfaceTemperature:
                self.parentID = seaTemperatureID;
                self.title = @"Sea Surface Temperature";
                break;
            case AKTypeTides:
                self.parentID = tidesID;
                self.title = @"Tides";
                break;
            case AKTypeWavewatch:
                self.parentID = wavewatchID;
                self.title = @"Wavewatch";
                break;
            case AKTypeWeatherForecast:
                self.parentID = weatherForecastID;
                self.title = @"Weather Forecast";
                break;
            default:
                break;
        };
}

- (void)openLeftView:(UIBarButtonItem *)sender {
    [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}

- (void)getDataFromServer {
    [SVProgressHUD showProgress:0 status:@""];
    [[AKServerManager sharedManager] getItemsListWith:^(CGFloat progress, NSDictionary *response, NSError *error) {
        [SVProgressHUD showProgress:progress status:@""];
        
        if (response) {
//            self.fetchedResultsController = nil;
            [SVProgressHUD dismiss];
            loadFinished();
        }
    }];
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
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AKBuoyModel *buoy = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    NSLog(@"VisibleOnTides: %zd, ItemType: %zd",buoy.visibleOnTides, buoy.itemType);
    NSLog(@"ParentID: %zd, locationID: %zd",buoy.parentId, buoy.locationId);
    
    if (buoy.itemType == AKItemTypeChildItems) {
        AKMasterTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AKMasterTableViewController"];
        vc.parentID = buoy.locationId;
        [self.navigationController pushViewController:vc animated:YES];

    } else if (buoy.visibleOnBuoys == AKStateVisible && buoy.itemType == AKSateTypeDetail) {
        AKBuoyInfoTableViewController *vc = [[AKBuoyInfoTableViewController alloc] initWithStyle:UITableViewStylePlain];
        vc.locationID = buoy.locationId;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (buoy.visibleOnTides == AKStateVisible && buoy.itemType == AKSateTypeDetail) {
        AKTidalTableViewController *vc = [[AKTidalTableViewController alloc] initWithStyle:UITableViewStylePlain];
        vc.locationID = buoy.locationId;
        [self.navigationController pushViewController:vc animated:YES];

        [[AKServerManager sharedManager] getTidalTidesDataFor:buoy.locationId withResponse:^(NSDictionary *response, NSError *error) {
            
        }];
        
    } else if (buoy.visibleOnMoonPhases == AKStateVisible && buoy.itemType == AKSateTypeDetail) {
        [[AKServerManager sharedManager] getMoonPhasesFor:buoy.locationId andOnDate:[NSDate date] withResponse:^(NSDictionary *response, NSError *error) {
            
        }];
    }
}



@end
