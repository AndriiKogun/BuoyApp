//
//  AKCoreDataViewController.h
//  BuoyApp
//
//  Created by Andrii on 3/16/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTableViewController.h"
#import <CoreData/CoreData.h>

@interface AKCoreDataViewController : AKTableViewController < NSFetchedResultsControllerDelegate >

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object;

@end
