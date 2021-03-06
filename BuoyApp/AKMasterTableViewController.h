//
//  AKMasterTableViewController.h
//  BuoyApp
//
//  Created by Andrii on 3/17/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKBaseTableViewController.h"
#import <CoreData/CoreData.h>

@interface AKMasterTableViewController : AKBaseTableViewController < NSFetchedResultsControllerDelegate >

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (assign ,nonatomic) int parentID;

@end
