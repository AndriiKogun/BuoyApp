//
//  AKTidesData.h
//  BuoyApp
//
//  Created by Andrii on 3/28/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKObject.h"


@interface AKTidesData : AKObject

@property (strong, nonatomic) NSString *dateJson;
@property (strong, nonatomic) NSString *dateTime;
@property (strong, nonatomic) NSString *dateTimeJson;
@property (strong, nonatomic) NSString *dayName;
@property (strong, nonatomic) NSString *fullDateTime;

@property (assign, nonatomic) NSInteger day;
@property (assign, nonatomic) double value;

@end
