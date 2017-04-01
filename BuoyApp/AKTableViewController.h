//
//  AKTableViewController.h
//  BuoyApp
//
//  Created by Andrii on 3/27/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "UIColor+AKMyCollors.h"

@interface AKTableViewController : UITableViewController

- (void)reload:(id)sender;
- (void)showPlaceholderViewController;

@end
