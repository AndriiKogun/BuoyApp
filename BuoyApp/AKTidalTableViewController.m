//
//  AKTidalTableViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/22/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTidalTableViewController.h"
#import "AKServerManager.h"

#import "AKTidesDataTableViewCell.h"
#import "AKTableViewCell.h"

#import "AKTidalInfo.h"
#import "AKMoonPhases.h"

@interface AKTidalTableViewController ()

@property (strong, nonatomic) AKMoonPhases *moonPhases;
@property (strong, nonatomic) AKTidalInfo *tidalInfo;
@property (strong, nonatomic) NSArray *tideDatas;

@property (strong, nonatomic) NSString *currentDate;
@property (strong, nonatomic) dispatch_group_t group;

@property (assign, nonatomic) NSInteger sectionsCount;

@end

@implementation AKTidalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDataFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)resetTableView {
    self.sectionsCount = 0;
    self.moonPhases = nil;
    self.tidalInfo = nil;
    self.tideDatas = nil;
}

- (NSString *)currentDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:[NSDate date]];
}

- (void)reachabilityChanged:(NSNotification *)notification {
    [super reachabilityChanged:notification];
    
    if ([self isNetworkAvailable]) {
       [self getDataFromServer];
    }
}

- (void)reload:(id)sender {
    [self getDataFromServer];
}

- (void)getDataFromServer {
    if ([self isNetworkAvailable]) {
        self.group = dispatch_group_create();
        
        [self resetTableView];
        [self getTidalTidesDataFromServer];
        [self getTidalInfoFromServer];
        
        if (self.visibleOn == (AKVisibleOnTides | AKVisibleOnMoonPhases)) {
            [self getMoonPhasesFromServer];
        }
        
        dispatch_group_notify(self.group , dispatch_get_main_queue(), ^{
            self.title = self.tidalInfo.tideName;
            [self dismissProgressHUDandRefreshing];
        });
        
    } else {
        [self showNetworkAlert];
    }
}

- (NSURLSessionDataTask *)getTidalTidesDataFromServer {
    dispatch_group_enter(self.group);

    return [[AKServerManager sharedManager] getTidalTidesDataFor:self.locationID withResponse:^(NSArray *tideDatas, NSError *error) {
        
        if (tideDatas) {
            self.tideDatas = tideDatas;
            self.sectionsCount ++;
        }
        
        dispatch_group_leave(self.group);
    }];
}

- (NSURLSessionDataTask *)getTidalInfoFromServer {
    dispatch_group_enter(self.group);

    return [[AKServerManager sharedManager] getTidalGeneralInfoFor:self.locationID withResponse:^(AKTidalInfo *tidalInfo, NSError *error) {
        
        if (tidalInfo) {
            self.tidalInfo = tidalInfo;
            self.sectionsCount ++;
        }
        
        dispatch_group_leave(self.group);
    }];
}

- (NSURLSessionDataTask *)getMoonPhasesFromServer {
    dispatch_group_enter(self.group);

    return [[AKServerManager sharedManager] getMoonPhasesFor:self.locationID andOnDate:self.currentDate withResponse:^(AKMoonPhases *moonPhases, NSError *error) {

        if (moonPhases) {
            self.moonPhases = moonPhases;
            self.sectionsCount ++;
        }
        
        dispatch_group_leave(self.group);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
        
    } else if (section == 1) {
        return self.tidalInfo.itemNames.count;
        
    } else {
        NSInteger count = self.moonPhases.moonInfos.count + self.moonPhases.itemNames.count;
        
        return count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *identifier = @"AKTidesDataTableViewCell";
        AKTidesDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        return cell;
        
    } else {
        static NSString *identifier = @"AKTableViewCell";
        AKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
       
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Tidal Tides Data";
        
    } else if (section == 1) {
        return @"Tidal General Info";
        
    } else  {
        return @"Moon Phases";
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 240;
        
    } else {
        return 69;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        AKTidesDataTableViewCell *myCell = (AKTidesDataTableViewCell *)cell;
        
        if (!myCell.tideDatas) {
            myCell.tideDatas = self.tideDatas;
        }
        
    } else {
        AKTableViewCell *myCell = (AKTableViewCell *)cell;
        myCell.userInteractionEnabled = false;

        if (indexPath.section == 1) {
            myCell.titleLabel.text = [self.tidalInfo.itemNames objectAtIndex:indexPath.row];
            myCell.valueLabel.text = [self.tidalInfo.itemValues objectAtIndex:indexPath.row];
            
        } else {
            if (indexPath.row < self.moonPhases.moonInfos.count) {
                AKMoonInfos *moonInfos = [self.moonPhases.moonInfos objectAtIndex:indexPath.row];
                myCell.titleLabel.text =  moonInfos.name;
                myCell.valueLabel.text = moonInfos.time;
                
            } else {
                myCell.titleLabel.text = [self.moonPhases.itemNames objectAtIndex:indexPath.row - self.moonPhases.moonInfos.count];;
                myCell.valueLabel.text = [self.moonPhases.itemValues objectAtIndex:indexPath.row - self.moonPhases.moonInfos.count];
            }
        }
    }
}



@end
