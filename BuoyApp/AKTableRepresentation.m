//
//  AKTableRepresentation.m
//  BuoyApp
//
//  Created by Andrii on 3/30/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTableRepresentation.h"
#import "UIColor+AKMyCollors.h"

@implementation AKTableRepresentation

+ (NSDictionary*)tableRepresentation {

    return @{@"titles":     @[@"Buoys",
                              @"Marine Forecast",
                              @"Radars",
                              @"Sea Surface Temperature",
                         
                              @"Tides",
                              @"Wavewatch",
                              @"Weather Forecast"],
             @"parentIDs":   @[@(34655),
                              @(40454),
                              @(45585),
                              @(41121),
                         
                              @(50319),
                              @(41147),
                              @(37062)],
             @"images":     @[@"Buoys-Small",
                              @"MarineForecast-Small",
                              @"Radar-Small",
                              @"SeaTemperature-Small",
                         
                              @"Tides-Small",
                              @"Wavewatch-Small",
                              @"WeatherForecast-Small"],
             @"colors":     @[[UIColor buoyCollor],
                              [UIColor marineForecastCollor],
                              [UIColor radarCollor],
                              [UIColor seaTemperatureCollor],
                              
                              [UIColor tidesCollor],
                              [UIColor wavewatchCollor],
                              [UIColor weatherForecastCollor]]
                     };
}



@end

