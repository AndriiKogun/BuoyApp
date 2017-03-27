//
//  AKLeftViewController.h
//  BuoyApp
//
//  Created by Andrii on 3/25/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKLeftViewController.h"
#import "AKMasterTableViewController.h"

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return AKTypeCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"AKMenuTableViewCell";
    
    AKMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    UIImage *image = nil;
    NSString *text = nil;
    
    switch (indexPath.row) {
        case AKTypeBuoys:
            image = [UIImage imageNamed:@"Buoys-Small"];
            text = @"Buoys";
            break;
        case AKTypeMarineForecast:
            image = [UIImage imageNamed:@"MarineForecast-Small"];
            text = @"Marine Forecast";
            break;
        case AKTypeRadars:
            image = [UIImage imageNamed:@"Radar-Small"];
            text = @"Radars";
            break;
        case AKTypeSeaSurfaceTemperature:
            image = [UIImage imageNamed:@"SeaTemperature-Small"];
            text = @"Sea Surface Temperature";
            break;
        case AKTypeTides:
            image = [UIImage imageNamed:@"Tides-Small"];
            text = @"Tides";
            break;
        case AKTypeWavewatch:
            image = [UIImage imageNamed:@"Wavewatch-Small"];
            text = @"Wavewatch";
            break;
        case AKTypeWeatherForecast:
            image = [UIImage imageNamed:@"WeatherForecast-Small"];
            text = @"Weather Forecast";

            break;
        default:
            break;
    }
    cell.menuImageView.image = image;
    cell.menuLabel.text = text;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKMasterTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AKMasterTableViewController"];
    vc.type = indexPath.row;
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:vc];
    
    LGSideMenuController *sideMenuController = (LGSideMenuController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    
    sideMenuController.rootViewController = nc;
    [sideMenuController hideLeftViewAnimated:YES completionHandler:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


@end
