//
//  AKBuoyModel+CoreDataProperties.h
//  BuoyApp
//
//  Created by Andrii on 3/17/17.
//  Copyright © 2017 Andrii. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "AKBuoyModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AKBuoyModel (CoreDataProperties)

+ (NSFetchRequest<AKBuoyModel *> *)fetchRequest;

@property (nonatomic) int16_t filterType;
@property (nonatomic) BOOL inactiveInUI;
@property (nonatomic) int16_t itemType;
@property (nonatomic) int16_t level;
@property (nonatomic) int32_t locationId;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t parentId;
@property (nonatomic) BOOL visibleOnBuoys;
@property (nonatomic) BOOL visibleOnMarineForecast;
@property (nonatomic) BOOL visibleOnMoonPhases;
@property (nonatomic) BOOL visibleOnRadar;
@property (nonatomic) BOOL visibleOnSeaSurfaceTemp;
@property (nonatomic) BOOL visibleOnTides;
@property (nonatomic) BOOL visibleOnWavewatch;
@property (nonatomic) BOOL visibleOnWeatherForecast;

@end

NS_ASSUME_NONNULL_END
