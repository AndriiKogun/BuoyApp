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

/*
2017-04-04 17:24:59.074614 BuoyApp[920:190138] {
    ErrorMessage = "";
    ResultCode = 0;
    ResultCodeName = Success;
    ReturnValue =     {
        MoonInfos =         (
                             {
                                 Name = Moonrise;
                                 Note = "";
                                 Time = "08:50";
                             },
                             {
                                 Name = "Moon transit";
                                 Note = "";
                                 Time = "15:22";
                             },
                             {
                                 Name = Moonset;
                                 Note = "";
                                 Time = "21:58";
                             }
                             );
        Phases =         {
            FirstQuarter = "APR. 03";
            FullMoon = "APR. 11";
            LastQuarter = "APR. 19";
            NewMoon = "MAR. 28";
        };
        SunInfos =         {
            Sunrise = "2017-03-30T06:46:00Z";
            Sunset = "2017-03-30T19:07:00Z";
        };
    };
}
*/
