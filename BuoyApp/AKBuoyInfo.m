//
//  AKBuoyInfo.m
//  BuoyApp
//
//  Created by Andrii on 3/21/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKBuoyInfo.h"

@implementation AKBuoyInfo

- (instancetype)initWithResponse:(NSDictionary *)response
{
    self = [super init];
    if (self) {
        
        NSMutableArray *itemNames =  [NSMutableArray array];
        NSMutableArray *itemValues =  [NSMutableArray array];
        NSDictionary *items = [self fillUpItemsNames:itemNames andItemsValues:itemValues withResponse:response];
        
        self.airTempC = [items objectForKey:@"AirTempC"];
        self.buoyId = [items objectForKey:@"BuoyId"];
        self.coordinate = [items objectForKey:@"Coordinate"];
        self.dateTimeLatestReading = [items objectForKey:@"DateTimeLatestReading"];
        self.dateTimeLatestReadingForDisplay = [items objectForKey:@"DateTimeLatestReadingForDisplay"];
        
        self.H2OTempC = [items objectForKey:@"H2OTemp"];
        self.locationId = [items objectForKey:@"LocationId"];
        self.marineForecast = [items objectForKey:@"MarineForecast"];
        self.marineForecastToday = [items objectForKey:@"MarineForecastToday"];
        self.meanWaveDirection = [items objectForKey:@"MeanWaveDirection"];
        
        self.name = [items objectForKey:@"Name"];
        self.stationId = [items objectForKey:@"StationId"];
        self.swellCondition = [items objectForKey:@"SwellCondition"];
        self.swellDirection = [items objectForKey:@"SwellDirection"];
        self.swellDirectionDeg = [items objectForKey:@"SwellDirectionDeg"];
        
        self.swellHeight = [items objectForKey:@"SwellHeight"];
        self.swellPeriod = [items objectForKey:@"SwellPeriod"];
        self.waveHeight = [items objectForKey:@"WaveHeight"];
        self.wavePeriod = [items objectForKey:@"WavePeriod"];
        self.weatherForecast = [items objectForKey:@"WeatherForecast"];
        
        self.weatherForecastLocationName = [items objectForKey:@"WeatherForecastLocationName"];
        self.windDirection = [items objectForKey:@"WindDirection"];
        self.windDirectionPercent = [items objectForKey:@"WindDirectionPercent"];
        self.windGust = [items objectForKey:@"WindGust"];
        self.windSpeed = [items objectForKey:@"WindSpeed"];
        
        self.itemNames = itemNames;
        self.itemValues = itemValues;
    }
    
    return self;
}




@end
