//
//  AKServerManager.h
//  BuoyApp
//
//  Created by Andrii on 3/16/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^AKLocationsList)(CGFloat progress, NSDictionary *response, NSError *error);
typedef void(^AKBouyInfo)(NSDictionary *response, NSError *error);
typedef void(^AKTidalGeneralInfo)(NSDictionary *response, NSError *error);
typedef void(^AKTidalTidesData)(NSDictionary *response, NSError *error);
typedef void(^AKMoonPhases)(NSDictionary *response, NSError *error);

@interface AKServerManager : NSObject

+ (AKServerManager *)sharedManager;

- (void)getBuoysListWith:(AKLocationsList)result;
- (void)getBuoyInfoFor:(int32_t)locationID withResponse:(AKBouyInfo)result;
- (void)getTidalGeneralInfoFor:(int32_t)locationID withResponse:(AKTidalGeneralInfo)result;
- (void)getTidalTidesDataFor:(int32_t)locationID withResponse:(AKTidalTidesData)result;
- (void)getMoonPhasesFor:(int32_t)locationID andOnDate:(NSDate *)date withResponse:(AKMoonPhases)result;

@end
