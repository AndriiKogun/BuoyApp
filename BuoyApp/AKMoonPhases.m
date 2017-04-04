//
//  AKMoonPhases.m
//  BuoyApp
//
//  Created by Andrii on 4/1/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKMoonPhases.h"

@implementation AKMoonInfos

- (instancetype)initWithResponse:(NSDictionary *)response {

    self = [super init];
    if (self) {
        self.name = [response objectForKey:@"Name"];
        self.time = [response objectForKey:@"Time"];

    }
    return self;
}

@end


@implementation AKMoonPhases

- (instancetype)initWithResponse:(NSDictionary *)response {
    
    self = [super init];
    if (self) {
        NSMutableArray *tempArray = [NSMutableArray array];
        NSArray *moonInfos = [response objectForKey:@"MoonInfos"];
        
        for (NSDictionary *dic in moonInfos ) {
            AKMoonInfos *moonInfos = [[AKMoonInfos alloc] initWithResponse:dic];
            [tempArray addObject:moonInfos];
        }
        
        self.moonInfos = tempArray;
        
        NSDictionary *phases = [response objectForKey:@"Phases"];
        NSDictionary *sunInfos = [response objectForKey:@"SunInfos"];
        
        NSMutableDictionary *response = [NSMutableDictionary dictionary];
        [response addEntriesFromDictionary:phases];
        [response addEntriesFromDictionary:sunInfos];

        self.firstQuarter = [phases objectForKey:@"FirstQuarter"];
        self.fullMoon = [phases objectForKey:@"FullMoon"];
        self.lastQuarter = [phases objectForKey:@"LastQuarter"];
        self.isNewMoon = [phases objectForKey:@"NewMoon"];
        
        self.sunrise = [sunInfos objectForKey:@"Sunrise"];
        self.sunset = [sunInfos objectForKey:@"Sunset"];
        
        NSMutableArray *itemNames =  [NSMutableArray array];
        NSMutableArray *itemValues =  [NSMutableArray array];
        [self fillUpItemsNames:itemNames andItemsValues:itemValues withResponse:response];
        
        self.itemNames = itemNames;
        self.itemValues = itemValues;

    }
    return self;
}

@end

