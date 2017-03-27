//
//  AKObject.h
//  BuoyApp
//
//  Created by Andrii on 3/23/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKObject : NSObject

@property (strong, nonatomic) NSArray *itemNames;
@property (strong, nonatomic) NSArray *itemValues;

- (instancetype)initWithResponse:(NSDictionary *)response;
- (NSDictionary *)fillUpItemsNames:(NSMutableArray *)names andItemsValues:(NSMutableArray *)values withResponse:(NSDictionary *)response;

@end
