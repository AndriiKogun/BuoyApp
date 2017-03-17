//
//  AKServerManager.m
//  test
//
//  Created by Andrii on 3/16/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKServerManager.h"
#import "AFHTTPSessionManager.h"

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

- (void)getBuoysListWith:(AKLocationsList)result {

    [self.manager GET:@"GetLocationList" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        CGFloat total = downloadProgress.totalUnitCount;
        CGFloat compl = downloadProgress.completedUnitCount;
        CGFloat percents = (compl / total);
        NSLog(@"Progress: %f",percents);
        
    }  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *returnValue = [responseObject objectForKey:@"ReturnValue"];
        NSDictionary *response = [returnValue firstObject];
        result(response, nil);
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil, error);
    }];
}

- (void)getBuoyInfoFor:(int32_t)locationID withResponse:(AKBouyInfo)result {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:locationID], @"locationId", nil];
    
    [self.manager GET:@"GetBouyInfo" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil, error);
    }];
}

- (void)getTidalGeneralInfoFor:(int32_t)locationID withResponse:(AKTidalGeneralInfo)result {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:locationID], @"locationId", nil];
    
    [self.manager GET:@"GetTidalGeneralInfo" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil, error);
    }];
}

- (void)getTidalTidesDataFor:(int32_t)locationID withResponse:(AKTidalTidesData)result {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:locationID], @"locationId", nil];
    
    [self.manager GET:@"GetTidalTidesData" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil, error);
    }];
}

- (void)getMoonPhasesFor:(int32_t)locationID andOnDate:(NSDate *)date withResponse:(AKMoonPhases)result {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:locationID], @"locationId", date, @"onDate", nil];
    
    [self.manager GET:@"GetBouyInfo" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(nil, error);
    }];
}








@end
