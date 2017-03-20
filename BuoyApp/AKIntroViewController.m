//
//  AKIntroViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/19/17.
//  Copyright © 2017 Andrii. All rights reserved.
//


#import "AKIntroViewController.h"

#import <EAIntroView/EAIntroView.h>

#import "AKMasterTableViewController.h"
#import "AKServerManager.h"

static NSString * const sampleDescription1 = @"Detail information from buoys all around the world.";
static NSString * const sampleDescription2 = @"Acurate and detail marine forecast (storms, cyclones, etс).";
static NSString * const sampleDescription3 = @"Detail radars information for all states.";
static NSString * const sampleDescription4 = @"Precise sea surface temperature for many regions";
static NSString * const sampleDescription5 = @"Detail information about tides for many regions.";
static NSString * const sampleDescription6 = @"Detail information about waves.";
static NSString * const sampleDescription7 = @"Accurate Weather Forecasts for many places around the World.";

@interface AKIntroViewController () <EAIntroDelegate>

@property (strong, nonatomic) UIView *rootView;
@property (strong, nonatomic) EAIntroView *intro;

@end

@implementation AKIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // using self.navigationController.view - to display EAIntroView above navigation bar
    self.rootView = self.view;
    [self showIntroWithSeparatePagesInitAndPageCallback];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Demo

- (void)showIntroWithSeparatePagesInitAndPageCallback {
    
    EAIntroPage *page1 = [self pageWithTitle:@"Buoys"
                                 description:sampleDescription1
                                  titleImage:@"buoy"];
    

    EAIntroPage *page2 = [self pageWithTitle:@"Marine Forecast"
                                 description:sampleDescription2
                                  titleImage:@"marineForecast"];

    EAIntroPage *page3 = [self pageWithTitle:@"Radars"
                                 description:sampleDescription3
                                  titleImage:@"radar"];

    EAIntroPage *page4 = [self pageWithTitle:@"Sea Surface Temperature"
                                description:sampleDescription4
                                 titleImage:@"seaTemperature"];

    EAIntroPage *page5 = [self pageWithTitle:@"Tides"
                                 description:sampleDescription4
                                  titleImage:@"tides"];

    EAIntroPage *page6 = [self pageWithTitle:@"Wavewatch"
                                 description:sampleDescription4
                                  titleImage:@"wavewatch"];

    EAIntroPage *page7 = [self pageWithTitle:@"Weather Forecast"
                                 description:sampleDescription4
                                  titleImage:@"weatherForecast"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.rootView.bounds];
    
    page7.onPageDidAppear = ^{
        [self addGetStartedButtonTo:intro];
    };
    
    intro.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [intro.titleView setBounds:CGRectMake(0, 0, 300, 100)];
    
    intro.pageControlY = 90.f;
    intro.titleViewY = 20;
    intro.skipButton = nil;
    intro.tapToNext = YES;
    intro.swipeToExit = NO;
    
    [intro setDelegate:self];
    [intro setPages:@[page1,page2,page3,page4, page5, page6, page7]];
    [intro showInView:self.rootView animateDuration:0];
}

- (EAIntroPage *)pageWithTitle:(NSString *)title description:(NSString *)description titleImage:(NSString *)name {
    EAIntroPage *page = [EAIntroPage page];
    page.title = title;
    page.desc = description;
    page.bgImage = [UIImage imageNamed:@"buoyBackground"];
    page.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    page.titleIconPositionY = 150;
    [page.titleIconView setBounds:CGRectMake(0, 0, 200, 200)];

    return page;
}

- (void)addGetStartedButtonTo:(EAIntroView *)intro {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 50, CGRectGetWidth(self.view.bounds), 50)];
    [btn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
    [btn setTitle:@"GET STARTED" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(getStarted:) forControlEvents:UIControlEventTouchUpInside];
    
    [intro addSubview:btn];
}

- (void)getStarted:(UIButton *)sender {
//    [[AKServerManager sharedManager] getBuoysListWith:^(CGFloat progress, NSDictionary *response, NSError *error) {
//        NSLog(@"%f.2",progress);
//        if (response) {
//            [self.intro hideWithFadeOutDuration:0.3];
//            AKStartTableViewController *vc = [[AKStartTableViewController alloc] initWithStyle:UITableViewStylePlain];
//            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
//            [self presentViewController:nc animated:NO completion:nil];
//            
//        }
//    }];
    
    
    [self.intro hideWithFadeOutDuration:0.3];
    AKMasterTableViewController *vc = [[AKMasterTableViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:NO completion:nil];
}



@end
