//
//  AKMasterTableViewController.h
//  BuoyApp
//
//  Created by Andrii on 3/17/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKCoreDataViewController.h"

@interface AKMasterTableViewController : AKCoreDataViewController < NSFetchedResultsControllerDelegate >

@property (assign ,nonatomic) int parentID;
@property (strong, nonatomic) NSString *tableTitle;

@end
