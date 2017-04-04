//
//  AKServerManager.m
//  BuoyApp
//
//  Created by Andrii on 3/16/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKServerManager.h"
#import "AKCoreDataManager.h"

#import "AFHTTPSessionManager.h"

#import "AKBuoyInfo.h"
#import "AKTidalInfo.h"
#import "AKTidesData.h"
#import "AKMoonPhases.h"

static NSString * const akLocalBuoyWebServerBaseUrlString = @"http://localbuoywebserver.staturedev.com/api/MobileApi/";

@interface AKServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end


@implementation AKServerManager

#pragma mark - AKServerManager singleton

+ (AKServerManager *)sharedManager {
    static AKServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AKServerManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *url = [[NSURL alloc] initWithString:akLocalBuoyWebServerBaseUrlString];
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    return self;
}

#pragma mark - GET methods

- (NSURLSessionDataTask *)getItemsListWith:(void (^)(CGFloat, NSDictionary *, NSError *))result {

    return [self.manager GET:@"GetLocationList" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        CGFloat total = downloadProgress.totalUnitCount;
        CGFloat compl = downloadProgress.completedUnitCount;
        CGFloat percents = (compl / total);
        result(percents, nil, nil);
        
    }  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSArray *returnValue = [responseObject objectForKey:@"ReturnValue"];
        NSDictionary *response = [returnValue firstObject];
        [[AKCoreDataManager sharedManager] createObjectFromServerWith:response isFinished:^(bool status) {
            result(1, response, nil);
        }];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(0, nil, error);
    }];
}

- (NSURLSessionDataTask *)getBuoyInfoFor:(NSInteger)locationID withResponse:(void (^)(AKBuoyInfo *, NSError *))result {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:locationID], @"locationId", nil];
    
    return [self.manager GET:@"GetBouyInfo" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *returnValue = [responseObject objectForKey:@"ReturnValue"];
        AKBuoyInfo *bouyInfo = [[AKBuoyInfo alloc] initWithResponse:returnValue];
        result(bouyInfo, nil);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil, error);
    }];
}

- (NSURLSessionDataTask *)getTidalGeneralInfoFor:(NSInteger)locationID withResponse:(void (^)(AKTidalInfo *, NSError *))result {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:locationID], @"locationId", nil];
    
    return [self.manager GET:@"GetTidalGeneralInfo" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *returnValue = [responseObject objectForKey:@"ReturnValue"];
        AKTidalInfo *tidesInfo = [[AKTidalInfo alloc] initWithResponse:returnValue];
        result(tidesInfo, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil, error);
    }];
}

- (NSURLSessionDataTask *)getTidalTidesDataFor:(NSInteger)locationID withResponse:(void (^)(NSArray *, NSError *))result {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:locationID], @"locationId", nil];
    
    return [self.manager GET:@"GetTidalTidesData" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *returnValue = [responseObject objectForKey:@"ReturnValue"];
        NSArray *items = [returnValue objectForKey:@"TideDatas"];
        NSMutableArray *tideDatas = [NSMutableArray array];
        
        for (NSDictionary *data in items) {
            AKTidesData *tideData = [[AKTidesData alloc] initWithResponse:data];
            [tideDatas addObject:tideData];
        }
        
        result(tideDatas, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil, error);
    }];
}

- (NSURLSessionDataTask *)getMoonPhasesFor:(NSInteger)locationID andOnDate:(NSString *)date withResponse:(void (^)(AKMoonPhases *, NSError *))result {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:locationID], @"locationId", date, @"onDate", nil];
    
    return [self.manager GET:@"GetMoonPhases" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        NSDictionary *returnValue = [responseObject objectForKey:@"ReturnValue"];
        AKMoonPhases *moonPhases = [[AKMoonPhases alloc] initWithResponse:returnValue];
        result(moonPhases, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil, error);
    }];
}








@end
