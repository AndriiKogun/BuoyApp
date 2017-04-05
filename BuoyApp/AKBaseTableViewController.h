//
//  AKBaseTableViewController.h
//  BuoyApp
//
//  Created by Andrii on 3/27/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AKBaseTableViewController : UITableViewController

@property (assign, nonatomic) BOOL showAnimated;

- (void)reload:(id)sender;
- (void)showPlaceholderViewController;
- (void)dismissProgressHUDandRefreshing;

- (void)showNetworkAlert;
- (BOOL)isNetworkAvailable;

- (void)reachabilityChanged:(NSNotification *)notification;

@end
