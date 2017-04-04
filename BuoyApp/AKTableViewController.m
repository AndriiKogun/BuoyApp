//
//  AKTableViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/27/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTableViewController.h"
#import "AKPlaceholderViewController.h"

#import "SVProgressHUD.h"
#import "Reachability.h"

#import "UIViewController+LGSideMenuController.h"
#import "UIColor+AKMyCollors.h"

@interface AKTableViewController ()

@property (strong, nonatomic) Reachability *reachability;
@property (assign, nonatomic) NetworkStatus networkStatus;

@end

@implementation AKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setRingNoTextRadius:20];
    [SVProgressHUD setRingThickness:4];
    [SVProgressHUD setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    self.reachability = reachability;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dismissProgressHUDandRefreshing {
    [SVProgressHUD dismiss];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (void)reload:(id)sender {
    
}

- (BOOL)isNetworkAvailable {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus currentStatus = [reachability currentReachabilityStatus];
    
    if (currentStatus != NotReachable) {
        return YES;
        
    } else {
        return NO;
    }
}

- (void)showNetworkAlert {
    [SVProgressHUD dismiss];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissProgressHUDandRefreshing];
    }];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network unavailable" message:@"Please check your internet connection or try again later" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showPlaceholderViewController {
    AKPlaceholderViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AKPlaceholderViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Notification

- (void)reachabilityChanged:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (void)progressHUDDWillAppear:(NSNotification *)notification {
    self.sideMenuController.leftViewSwipeGestureEnabled = false;
}

- (void)progressHUDDidDisappear:(NSNotification *)notification {
    self.sideMenuController.leftViewSwipeGestureEnabled = true;
}

- (void)openLeftView:(UIBarButtonItem *)sender {
    [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.showAnimated) {
        self.tableView.hidden = YES;
        
        [UIView transitionWithView:self.view
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.tableView.hidden = NO;
                            
                        } completion:^(BOOL finished) {
                            self.showAnimated = NO;
                        }];
    }
}



@end
