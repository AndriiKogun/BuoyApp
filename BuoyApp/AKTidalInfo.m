//
//  AKTidalInfo.m
//  BuoyApp
//
//  Created by Andrii on 3/23/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTidalInfo.h"

@implementation AKTidalInfo

- (instancetype)initWithResponse:(NSDictionary *)response
{
    self = [super init];
    if (self) {

        NSMutableArray *itemNames =  [NSMutableArray array];
        NSMutableArray *itemValues =  [NSMutableArray array];
        NSDictionary *items = [self fillUpItemsNames:itemNames andItemsValues:itemValues withResponse:response];
        
        self.currentDate = [items objectForKey:@"CurrentDate"];
        self.currentDateJson = [items objectForKey:@"CurrentDateJson"];
        self.currentDateText = [items objectForKey:@"CurrentDateText"];
        self.locationId = [items objectForKey:@"LocationId"];
        self.tideApiId = [items objectForKey:@"TideApiId"];
        
        self.tideCoordinate = [items objectForKey:@"TideCoordinate"];
        self.tideId = [items objectForKey:@"TideId"];
        self.tideLatitude = [items objectForKey:@"TideLatitude"];
        self.tideLongitude = [items objectForKey:@"TideLongitude"];
        self.tideName = [items objectForKey:@"TideName"];
        
        self.itemNames = itemNames;
        self.itemValues = itemValues;
    }
    return self;
}

@end
