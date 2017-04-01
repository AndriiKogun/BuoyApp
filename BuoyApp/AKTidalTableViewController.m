//
//  AKTidalTableViewController.m
//  BuoyApp
//
//  Created by Andrii on 3/22/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTidalTableViewController.h"
#import "AKServerManager.h"

#import "AKTidesDataTableViewCell.h"
#import "AKTableViewCell.h"

#import "AKTidalInfo.h"

@interface AKTidalTableViewController ()

@property (strong, nonatomic) AKTidalInfo *tidalInfo;
@property (strong, nonatomic) NSArray *tideDatas;


@end

@implementation AKTidalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

    });
    [self getTidalTidesDataFromServer];

    [self getTidalInfoFromServer];
    
    if (self.visibleOn == (AKVisibleOnTides | AKVisibleOnMoonPhases)) {
        [self getMoonPhasesFromServer];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSURLSessionDataTask *)getTidalTidesDataFromServer {
    return [[AKServerManager sharedManager] getTidalTidesDataFor:self.locationID withResponse:^(NSArray *tideDatas, NSError *error) {
        
        if (tideDatas) {
            self.tideDatas = tideDatas;
        }
        [SVProgressHUD dismiss];
    }];
}

- (NSURLSessionDataTask *)getTidalInfoFromServer {
    return [[AKServerManager sharedManager] getTidalGeneralInfoFor:self.locationID withResponse:^(AKTidalInfo *tidalInfo, NSError *error) {
        if (tidalInfo) {
            self.tidalInfo = tidalInfo;
            self.title = self.tidalInfo.tideName;
            [SVProgressHUD dismiss];
        }
    }];
}

- (NSURLSessionDataTask *)getMoonPhasesFromServer {
    return [[AKServerManager sharedManager] getMoonPhasesFor:self.locationID andOnDate:@"2017-03-30" withResponse:^(NSDictionary *response, NSError *error) {
        /*
        2017-03-30------ 35737
        2017-03-30T12:55:00
        2017-03-30 12:55:00
         */
        NSLog(@"%@",response);

    }];
}




#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
        
    } else if (section == 1) {
        return self.tidalInfo.itemNames.count;
        
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    if (self.tidalInfo && self.tideDatas) {
        return 2;
    }
    
    if (self.tideDatas) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *identifier = @"AKTidesDataTableViewCell";
        AKTidesDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.tideDatas = self.tideDatas;
        NSLog(@"hello");
        return cell;
        
    } else {
        static NSString *identifier = @"AKTableViewCell";
        AKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AKTableViewCell" owner:self options: nil] firstObject];
        }
        
        cell.userInteractionEnabled = false;
        cell.titleLabel.text = [self.tidalInfo.itemNames objectAtIndex:indexPath.row];
        cell.valueLabel.text = [self.tidalInfo.itemValues objectAtIndex:indexPath.row];
        
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Tidal Tides Data";
        
    } else if (section == 1) {
        return @"Tidal General Info";
        
    } else {
        return 0;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 240;
        
    } else {
        return 50;
    }
}



@end
