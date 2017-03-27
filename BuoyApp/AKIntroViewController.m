//
//  AKIntroViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/19/17.
//  Copyright © 2017 Andrii. All rights reserved.
//


#import "AKIntroViewController.h"

#import <EAIntroView/EAIntroView.h>

#import "AKMainViewController.h"
#import "AKMasterTableViewController.h"
#import "AKServerManager.h"

static NSString * const buoysDescription = @"Detail information from buoys all around the world.";
static NSString * const marineForecastDescription = @"Acurate and detail marine forecast (storms, cyclones, etс).";
static NSString * const radarDescription = @"Detail radars information for all states.";
static NSString * const seaTemperatureDescription = @"Precise sea surface temperature for many regions";
static NSString * const tidesDescription = @"Detail information about tides for many regions.";
static NSString * const wavewatchDescription = @"Detail information about waves.";
static NSString * const weatherForecastDescription = @"Accurate Weather Forecasts for many places around the World.";

@interface AKIntroViewController () <EAIntroDelegate>

@property (strong, nonatomic) EAIntroView *intro;

@end

@implementation AKIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showIntroWithSeparatePagesInitAndPageCallback];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Demo

- (void)showIntroWithSeparatePagesInitAndPageCallback {
    
    EAIntroPage *page1 = [self pageWithTitle:@"Buoys"
                                 description:buoysDescription
                                  titleImage:@"Buoys"];

    EAIntroPage *page2 = [self pageWithTitle:@"Marine Forecast"
                                 description:marineForecastDescription
                                  titleImage:@"MarineForecast"];

    EAIntroPage *page3 = [self pageWithTitle:@"Radars"
                                 description:radarDescription
                                  titleImage:@"Radar"];

    EAIntroPage *page4 = [self pageWithTitle:@"Sea Surface Temperature"
                                description:seaTemperatureDescription
                                 titleImage:@"SeaTemperature"];

    EAIntroPage *page5 = [self pageWithTitle:@"Tides"
                                 description:tidesDescription
                                  titleImage:@"Tides"];

    EAIntroPage *page6 = [self pageWithTitle:@"Wavewatch"
                                 description:wavewatchDescription
                                  titleImage:@"Wavewatch"];

    EAIntroPage *page7 = [self pageWithTitle:@"Weather Forecast"
                                 description:weatherForecastDescription
                                  titleImage:@"WeatherForecast"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds];
    
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
    [intro showInView:self.view animateDuration:0];
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
    [self.intro hideWithFadeOutDuration:0.3];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];

    AKMasterTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"AKMasterTableViewController"];
    vc.type = AKTypeBuoys;
    
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:vc];
    
    AKMainViewController *mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"AKMainViewController"];
    
    mainViewController.rootViewController = navigationController;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = mainViewController;
}



@end
