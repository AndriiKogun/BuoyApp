//
//  AKMoonPhases.h
//  BuoyApp
//
//  Created by Andrii on 4/1/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKObject.h"

@interface AKMoonInfos : AKObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *time;

@end

@interface AKMoonPhases : AKObject

@property (strong, nonatomic) NSArray *moonInfos;

@property (strong, nonatomic) NSString *firstQuarter;
@property (strong, nonatomic) NSString *fullMoon;
@property (strong, nonatomic) NSString *lastQuarter;
@property (strong, nonatomic) NSString *isNewMoon;

@property (strong, nonatomic) NSString *sunrise;
@property (strong, nonatomic) NSString *sunset;

@end
