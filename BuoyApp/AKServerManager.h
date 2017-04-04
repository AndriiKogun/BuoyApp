//
//  AKServerManager.h
//  BuoyApp
//
//  Created by Andrii on 3/16/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AKBuoyInfo, AKTidalInfo, AKMoonPhases;

@interface AKServerManager : NSObject

+ (AKServerManager *)sharedManager;

- (NSURLSessionDataTask *)getItemsListWith:(void(^)(CGFloat progress, NSDictionary *response, NSError *error))result;

- (NSURLSessionDataTask *)getBuoyInfoFor:(NSInteger)locationID withResponse:(void(^)(AKBuoyInfo *buoyInfo, NSError *error))result;

- (NSURLSessionDataTask *)getTidalGeneralInfoFor:(NSInteger)locationID withResponse:(void(^)(AKTidalInfo *tidalInfo, NSError *error))result;

- (NSURLSessionDataTask *)getTidalTidesDataFor:(NSInteger)locationID withResponse:(void(^)(NSArray *tideDatas, NSError *error))result;

- (NSURLSessionDataTask *)getMoonPhasesFor:(NSInteger)locationID andOnDate:(NSString *)date withResponse:(void(^)(AKMoonPhases *moonPhases, NSError *error))result;

@end
