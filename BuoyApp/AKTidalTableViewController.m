//
//  AKTidalTableViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/22/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTidalTableViewController.h"
#import "AKServerManager.h"

#import "AKTidalInfo.h"

@interface AKTidalTableViewController ()

@property (strong, nonatomic) AKTidalInfo *tidalInfo;

@end

@implementation AKTidalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getTidalInfoFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (void)getTidalInfoFromServer {
    [[AKServerManager sharedManager] getTidalGeneralInfoFor:self.locationID withResponse:^(AKTidalInfo *tidalInfo, NSError *error) {
        NSLog(@"%@",tidalInfo);
        self.tidalInfo = tidalInfo;
        self.title = self.tidalInfo.tideName;
        
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tidalInfo.itemNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.textLabel.numberOfLines = 0;
    
    NSString *value = [self.tidalInfo.itemValues objectAtIndex:indexPath.section];
    cell.textLabel.text = value;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.tidalInfo.itemNames objectAtIndex:section];
}


@end
