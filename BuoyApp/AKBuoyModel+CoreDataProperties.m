//
//  AKBuoyModel+CoreDataProperties.m
//  BuoyApp
//
//  Created by Andrii on 3/17/17.
//  Copyright © 2017 Andrii. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "AKBuoyModel+CoreDataProperties.h"

@implementation AKBuoyModel (CoreDataProperties)

+ (NSFetchRequest<AKBuoyModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AKBuoyModel"];
}

@dynamic filterType;
@dynamic inactiveInUI;
@dynamic itemType;
@dynamic level;
@dynamic locationId;
@dynamic name;
@dynamic parentId;
@dynamic visibleOnBuoys;
@dynamic visibleOnMarineForecast;
@dynamic visibleOnMoonPhases;
@dynamic visibleOnRadar;
@dynamic visibleOnSeaSurfaceTemp;
@dynamic visibleOnTides;
@dynamic visibleOnWavewatch;
@dynamic visibleOnWeatherForecast;

@end
