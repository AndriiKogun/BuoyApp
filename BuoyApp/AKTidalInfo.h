//
//  AKTidalInfo.h
//  BuoyApp
//
//  Created by Andrii on 3/23/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKObject.h"

@interface AKTidalInfo : AKObject

@property (strong, nonatomic) NSString *currentDate;
@property (strong, nonatomic) NSString *currentDateJson;
@property (strong, nonatomic) NSString *currentDateText;
@property (strong, nonatomic) NSString *locationId;
@property (strong, nonatomic) NSString *tideApiId;

@property (strong, nonatomic) NSString *tideCoordinate;
@property (strong, nonatomic) NSString *tideId;
@property (strong, nonatomic) NSString *tideLatitude;
@property (strong, nonatomic) NSString *tideLongitude;
@property (strong, nonatomic) NSString *tideName;

@end
