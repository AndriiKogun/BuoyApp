//
//  AKCoreDataViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/16/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKCoreDataViewController.h"
#import "AKCoreDataManager.h"



#import "AKUtilis.h"

@interface AKCoreDataViewController () 


@end

@implementation AKCoreDataViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    saveIntroAppearance(YES);
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)iconChanged:(id)sender
//{
//    if (_iconControl.selectedSegmentIndex == 0) {
//        [self.HUD performAction:M13ProgressViewActionNone animated:YES];
//    } else if (_iconControl.selectedSegmentIndex == 1) {
//        [self.HUD performAction:M13ProgressViewActionSuccess animated:YES];
//    } else if (_iconControl.selectedSegmentIndex == 2) {
//        [HUD performAction:M13ProgressViewActionFailure animated:YES];
//    }
//}
//
//- (void)blurChanged:(id)sender
//{
//    [HUD setApplyBlurToBackground:_blurSwitch.on];
//}
//
//- (void)statusPositionChanged:(id)sender
//{
//    if (_statusPositionControl.selectedSegmentIndex == 0) {
//        [HUD setStatusPosition:M13ProgressHUDStatusPositionBelowProgress];
//    } else if (_statusPositionControl.selectedSegmentIndex == 1) {
//        [HUD setStatusPosition:M13ProgressHUDStatusPositionAboveProgress];
//    } else if (_statusPositionControl.selectedSegmentIndex == 2) {
//        [HUD setStatusPosition:M13ProgressHUDStatusPositionLeftOfProgress];
//    } else if (_statusPositionControl.selectedSegmentIndex == 3) {
//        [HUD setStatusPosition:M13ProgressHUDStatusPositionRightOfProgress];
//    }
//}
//
//- (void)maskTypeChanged:(id)sender
//{
//    if (_maskTypeControl.selectedSegmentIndex == 0) {
//        [HUD setMaskType:M13ProgressHUDMaskTypeNone];
//    } else if (_maskTypeControl.selectedSegmentIndex == 1) {
//        [HUD setMaskType:M13ProgressHUDMaskTypeSolidColor];
//    } else if (_maskTypeControl.selectedSegmentIndex == 2) {
//        [HUD setMaskType:M13ProgressHUDMaskTypeGradient];
//    } else if (_maskTypeControl.selectedSegmentIndex == 3) {
//        [HUD setMaskType:M13ProgressHUDMaskTypeIOS7Blur];
//    }
//}
//
//- (void)superviewChanged:(id)sender
//{
//    if (_superviewControl.selectedSegmentIndex == 0) {
//        [HUD removeFromSuperview];
//        UIWindow *window = ((AppDelegate *)[UIApplication safeM13SharedApplication].delegate).window;
//        [window addSubview:HUD];
//    } else {
//        [HUD removeFromSuperview];
//        [_imageView addSubview:HUD];
//    }
//    
//}
















- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[AKCoreDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:object];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {

            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object {
    
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    return nil;
}    



@end
