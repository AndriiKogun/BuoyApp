//
//  AKLeftViewController.h
//  BuoyApp
//
//  Created by Andrii on 3/25/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKLeftViewController.h"
#import "AKMasterTableViewController.h"
#import "AKTableRepresentation.h"

#import "UIViewController+LGSideMenuController.h"

#import "AKMenuTableViewCell.h"


@interface AKLeftViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AKLeftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath
                                animated:YES
                            scrollPosition:UITableViewScrollPositionNone];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[AKTableRepresentation tableRepresentation] [@"titles"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"AKMenuTableViewCell";
    
    AKMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSArray *images = [AKTableRepresentation tableRepresentation] [@"images"];
    NSArray *titles = [AKTableRepresentation tableRepresentation] [@"titles"];
    
    cell.menuImageView.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
    cell.menuLabel.text = [titles objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKMasterTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AKMasterTableViewController"];
    
    NSArray *parentIDs = [AKTableRepresentation tableRepresentation] [@"parentIDs"];
    NSArray *titles = [AKTableRepresentation tableRepresentation] [@"titles"];
    NSArray *colors = [AKTableRepresentation tableRepresentation] [@"colors"];

    vc.parentID = [[parentIDs objectAtIndex:indexPath.row] intValue];
    vc.title = [titles objectAtIndex:indexPath.row];

    [[UINavigationBar appearance] setBarTintColor:[colors objectAtIndex:indexPath.row]];
    
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
    
    LGSideMenuController *sideMenuController = (LGSideMenuController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    
    sideMenuController.rootViewController = nc;
    [sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


@end
