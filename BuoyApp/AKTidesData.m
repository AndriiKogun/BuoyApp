
//
//  AKTidesData.m
//  BuoyApp
//
//  Created by Andrii on 3/28/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTidesData.h"

@implementation AKTidesData

- (instancetype)initWithResponse:(NSDictionary *)response
{
    self = [super init];
    if (self) {

        self.dateJson = [response objectForKey:@"DateJson"];
        self.dateTime = [response objectForKey:@"DateTime"];
        self.dateTimeJson = [response objectForKey:@"DateTimeJson"];
        self.dayName = [response objectForKey:@"DayName"];
        self.fullDateTime = [response objectForKey:@"FullDateTime"];

        self.day = [[response objectForKey:@"Day"] integerValue];
        self.value = [[response objectForKey:@"Value"] doubleValue];
    }
    
    return self;
}

@end
