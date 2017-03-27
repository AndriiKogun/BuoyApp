//
//  AKBuoyInfoTableViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/22/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKBuoyInfoTableViewController.h"
#import "AKServerManager.h"

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
    // Dispose of any resources that can be recreated.
}

- (void)getBuoyInfoFromServer {
    [SVProgressHUD show];
    [[AKServerManager sharedManager] getBuoyInfoFor:self.locationID withResponse:^(AKBuoyInfo *buoyInfo, NSError *error) {
        self.buoyInfo = buoyInfo;
        self.title = self.buoyInfo.name;
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.buoyInfo.itemNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }

    cell.textLabel.numberOfLines = 0;
    
    NSString *value = [self.buoyInfo.itemValues objectAtIndex:indexPath.section];
    cell.textLabel.text = value;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.buoyInfo.itemNames objectAtIndex:section];
}


@end
