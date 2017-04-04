//
//  AKBuoyInfoTableViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/22/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKBuoyInfoTableViewController.h"
#import "AKServerManager.h"

#import "UIRefreshControl+AFNetworking.h"

#import "AKTableViewCell.h"

#import "AKBuoyInfo.h"

@interface AKBuoyInfoTableViewController ()

@property (strong, nonatomic) AKBuoyInfo *buoyInfo;
@end

@implementation AKBuoyInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getBuoyInfoFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reachabilityChanged:(NSNotification *)notification {
    [super reachabilityChanged:notification];

    if ([self isNetworkAvailable]) {
        [self getBuoyInfoFromServer];
    }
}

- (void)reload:(id)sender {
    [self getBuoyInfoFromServer];
}

- (void)getBuoyInfoFromServer {
    if ([self isNetworkAvailable]) {
        [[AKServerManager sharedManager] getBuoyInfoFor:self.locationID withResponse:^(AKBuoyInfo *buoyInfo, NSError *error) {
            if (buoyInfo) {
                self.buoyInfo = buoyInfo;
                self.title = self.buoyInfo.name;
                
                [self dismissProgressHUDandRefreshing];
            }
        }];
        
    } else {
        [self showNetworkAlert];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.buoyInfo.itemNames) {
        return 1;
        
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.buoyInfo.itemNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"AKTableViewCell";
    AKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AKTableViewCell" owner:self options: nil] firstObject];
    }
    
        cell.userInteractionEnabled = false;
        cell.titleLabel.text = [self.buoyInfo.itemNames objectAtIndex:indexPath.row];
        cell.valueLabel.text = [self.buoyInfo.itemValues objectAtIndex:indexPath.row];
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Buoy Info";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *value = [self.buoyInfo.itemValues objectAtIndex:indexPath.row];
    return [AKTableViewCell heightForText:value];
}

@end
