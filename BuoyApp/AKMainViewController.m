//
//  AKMainViewController.m
//  HomeTask_44-45_Client_Server_APIs_Part_2,3
//
//  Created by Andrii on 10/28/16.
//  Copyright © 2016 Andrii. All rights reserved.
//

#import "AKMainViewController.h"
#import "AKLeftViewController.h"

@interface AKMainViewController ()

@property (strong, nonatomic) AKLeftViewController *leftViewController;
@property (assign, nonatomic) NSUInteger type;

@end

@implementation AKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.swipeGestureArea = LGSideMenuSwipeGestureAreaFull;
    self.rightViewSwipeGestureEnabled = NO;
    self.rootViewCoverColorForLeftView = [UIColor clearColor];
    self.leftViewStatusBarVisibleOptions = LGSideMenuStatusBarVisibleOnAll;
  
    AKLeftViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AKLeftViewController"];
    
    self.leftViewController = vc;
    
    [self setLeftViewEnabledWithWidth:260.f
                    presentationStyle:LGSideMenuPresentationStyleSlideAbove
                 alwaysVisibleOptions:LGSideMenuAlwaysVisibleOnNone];
    
    [self.leftView addSubview:self.leftViewController.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)leftViewWillLayoutSubviewsWithSize:(CGSize)size {
    [super leftViewWillLayoutSubviewsWithSize:size];
    
    if (![UIApplication sharedApplication].isStatusBarHidden && (_type == 2 || _type == 3)) {
        self.leftViewController.view.frame = CGRectMake(0.f , 20.f, size.width, size.height - 20.f);

    } else {
        self.leftViewController.view.frame = CGRectMake(0.f , 0.f, size.width, size.height);
    }
}



@end
