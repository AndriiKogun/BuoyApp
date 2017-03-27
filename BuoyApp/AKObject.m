//
//  AKObject.m
//  BuoyApp
//
//  Created by Andrii on 3/23/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKObject.h"

@implementation AKObject

- (instancetype)initWithResponse:(NSDictionary *)response
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSDictionary *)fillUpItemsNames:(NSMutableArray *)names andItemsValues:(NSMutableArray *)values withResponse:(NSMutableDictionary *)response {
    
    NSMutableDictionary *items = [NSMutableDictionary dictionary];
    
    NSArray *sortedkeys = [response.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    for (NSString *key in sortedkeys) {
        id object = [response objectForKey:key];
        
        if (![object isEqual:[NSNull null]] && ![object isEqual:@""]) {
            
            [names addObject:key];
            [items setObject:object forKey:key];
            
            if ([object isKindOfClass:[NSNumber class]]) {
                
                NSNumber *number = (NSNumber *)object;
                [values addObject:number.stringValue];
                [items setObject:number.stringValue forKey:key];
            } else {
                
                NSString *string = (NSString *)object;
                
                if (string.length > 200) {
                    string = @"Tap To See More";
                }
                
                [values addObject:string];
                [items setObject:string forKey:key];
            }
        }
    }
    return items;
}

@end
