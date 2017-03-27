//
//  AKMasterTableViewController.h
//  BuoyApp
//
//  Created by Andrii on 3/17/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKCoreDataViewController.h"

typedef NS_ENUM(NSInteger, AKType){
    AKTypeBuoys,
    AKTypeMarineForecast,
    AKTypeRadars,
    AKTypeSeaSurfaceTemperature,
    AKTypeTides,
    AKTypeWavewatch,
    AKTypeWeatherForecast,
    AKTypeCount = 7
};

@interface AKMasterTableViewController : AKCoreDataViewController < NSFetchedResultsControllerDelegate >

@property (assign, nonatomic) AKType type;

@end
