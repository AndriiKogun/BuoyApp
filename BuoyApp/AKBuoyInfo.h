//
//  AKBuoyInfo.h
//  BuoyApp
//
//  Created by Andrii on 3/21/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKObject.h"
#import <UIKit/UIKit.h>

@interface AKBuoyInfo : AKObject

@property (strong, nonatomic) NSString *airTempC;
@property (strong, nonatomic) NSString *buoyId;
@property (strong, nonatomic) NSString *coordinate;
@property (strong, nonatomic) NSString *dateTimeLatestReading;
@property (strong, nonatomic) NSString *dateTimeLatestReadingForDisplay;

@property (strong, nonatomic) NSString *H2OTempC;
@property (strong, nonatomic) NSString *locationId;
@property (strong, nonatomic) NSString *marineForecast;
@property (strong, nonatomic) NSString *marineForecastToday;
@property (strong, nonatomic) NSString *meanWaveDirection;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *stationId;
@property (strong, nonatomic) NSString *swellCondition;
@property (strong, nonatomic) NSString *swellDirection;
@property (strong, nonatomic) NSString *swellDirectionDeg;

@property (strong, nonatomic) NSString *swellHeight;
@property (strong, nonatomic) NSString *swellPeriod;
@property (strong, nonatomic) NSString *waveHeight;
@property (strong, nonatomic) NSString *wavePeriod;
@property (strong, nonatomic) NSString *weatherForecast;

@property (strong, nonatomic) NSString *weatherForecastLocationName;
@property (strong, nonatomic) NSString *windDirection;
@property (strong, nonatomic) NSString *windDirectionPercent;
@property (strong, nonatomic) NSString *windGust;
@property (strong, nonatomic) NSString *windSpeed;

@end

