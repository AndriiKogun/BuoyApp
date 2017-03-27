//
//  AKServerManager.h
//  BuoyApp
//
//  Created by Andrii on 3/16/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AKBuoyInfo, AKTidalInfo;

@interface AKServerManager : NSObject

+ (AKServerManager *)sharedManager;

- (void)getItemsListWith:(void(^)(CGFloat progress, NSDictionary *response, NSError *error))result;
- (void)getBuoyInfoFor:(NSInteger)locationID withResponse:(void(^)(AKBuoyInfo *buoyInfo, NSError *error))result;
- (void)getTidalGeneralInfoFor:(NSInteger)locationID withResponse:(void(^)(AKTidalInfo *tidalInfo, NSError *error))result;
- (void)getTidalTidesDataFor:(NSInteger)locationID withResponse:(void(^)(NSDictionary *response, NSError *error))result;
- (void)getMoonPhasesFor:(NSInteger)locationID andOnDate:(NSDate *)date withResponse:(void(^)(NSDictionary *response, NSError *error))result;

@end
