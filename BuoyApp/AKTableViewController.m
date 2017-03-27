//
//  AKTableViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/27/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTableViewController.h"

#import "SVProgressHUD.h"

@interface AKTableViewController ()

@end

@implementation AKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setRingRadius:22];
    [SVProgressHUD setRingThickness:4];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setContainerView: self.navigationController.view];
    

    //self.refreshControl = [UIRefreshControl alloc] initWithFrame:
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor darkGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)progressHUDDidDisappear:(NSNotification *)notification {
    
    [self.tableView reloadData];
}


@end
