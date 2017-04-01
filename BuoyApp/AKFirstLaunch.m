//
//  AKFirstLaunch.m
//  BuoyApp
//
//  Created by Andrii on 3/27/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKFirstLaunch.h"
#import "AKIntroViewController.h"
#import "AKMasterTableViewController.h"
#import "AKMainViewController.h"

@implementation AKFirstLaunch

+ (void)firstLaunch {
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    if (!showIntro()) {
        AKIntroViewController *vc = [[AKIntroViewController alloc] init];
        window.rootViewController = vc;
        
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        AKMasterTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"AKMasterTableViewController"];
        
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:vc];
        
        AKMainViewController *mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"AKMainViewController"];
        
        mainViewController.rootViewController = navigationController;
        window.rootViewController = mainViewController;
    }
}

@end
