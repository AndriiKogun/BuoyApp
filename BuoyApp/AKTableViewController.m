//
//  AKTableViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/27/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTableViewController.h"
#import "AKPlaceholderViewController.h"


#import "UIViewController+LGSideMenuController.h"

@interface AKTableViewController ()

@end

@implementation AKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setRingNoTextRadius:20];
    [SVProgressHUD setRingThickness:4];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setForegroundColor:[UIColor myBlueCollor]];

    [SVProgressHUD setContainerView: self.navigationController.view];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40)];
    [self.refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    [self.tableView.tableHeaderView addSubview:self.refreshControl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(progressHUDDidDisappear:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(progressHUDDWillAppear:)
                                                 name:SVProgressHUDWillAppearNotification
                                               object:nil];
    
    if (self.navigationController.viewControllers.count == 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Menu"] style:UIBarButtonItemStylePlain target:self action:@selector(openLeftView:)];
    }
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void) reload:(id)sender {
}

- (void)showPlaceholderViewController {
    AKPlaceholderViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AKPlaceholderViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)progressHUDDWillAppear:(NSNotification *)notification {
    self.sideMenuController.leftViewSwipeGestureEnabled = false;
}

- (void)progressHUDDidDisappear:(NSNotification *)notification {
    self.sideMenuController.leftViewSwipeGestureEnabled = true;
    [self.tableView reloadData];
}

- (void)openLeftView:(UIBarButtonItem *)sender {
    [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


@end
