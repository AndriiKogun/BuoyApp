//
//  AKCoreDataViewController.h
//  BuoyApp
//
//  Created by Andrii on 3/16/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>



@interface AKCoreDataViewController : UITableViewController < NSFetchedResultsControllerDelegate >

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

//@property (strong, nonatomic) UITableView *tableView;

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object;

@end
