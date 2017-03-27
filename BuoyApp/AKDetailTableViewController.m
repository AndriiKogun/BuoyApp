//
//  AKDetailTableViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/23/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKDetailTableViewController.h"

@interface AKDetailTableViewController ()

@end

@implementation AKDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    
    [SVProgressHUD setRingThickness:4];
    [SVProgressHUD setRingNoTextRadius:18];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setContainerView: self.navigationController.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(progressHUDDidDisappear:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)progressHUDDidDisappear:(NSNotification *)notification {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    header.textLabel.textColor = [UIColor whiteColor];
    view.tintColor = [UIColor darkGrayColor];
}


@end
