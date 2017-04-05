//
//  AKDetailTableViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/23/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKDetailTableViewController.h"
#import "AKServerManager.h"

#import "SVProgressHUD.h"

@interface AKDetailTableViewController ()

@end

@implementation AKDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showAnimated = YES;
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD show];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textAlignment = NSTextAlignmentCenter;
    header.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    header.textLabel.textColor = [UIColor whiteColor];
    header.contentView.backgroundColor = [UIColor darkGrayColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}




@end
