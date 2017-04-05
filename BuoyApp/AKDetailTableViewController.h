//
//  AKDetailTableViewController.h
//  BuoyApp
//
//  Created by Andrii on 3/23/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKBaseTableViewController.h"

typedef NS_ENUM(NSInteger, AKVisibleOn){
    AKVisibleOnBuoys                = 1 << 0,
    AKVisibleOnMarineForecast       = 1 << 1,
    AKVisibleOnMoonPhases           = 1 << 2,
    AKVisibleOnRadar                = 1 << 3,
    AKVisibleOnSeaSurfaceTemp       = 1 << 4,
    AKVisibleOnTides                = 1 << 5,
    AKVisibleOnWavewatch            = 1 << 6,
    AKVisibleOnWeatherForecast      = 1 << 7
};


@interface AKDetailTableViewController : AKBaseTableViewController

@property (assign, nonatomic) AKVisibleOn visibleOn;
@property (assign, nonatomic) NSInteger locationID;

@end
