//
//  AKTidesDataTableViewCell.h
//  BuoyApp
//
//  Created by Andrii on 3/28/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMSimpleLineGraphView.h"

@interface AKTidesDataTableViewCell : UITableViewCell <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *myGraph;

@property (strong, nonatomic) NSArray *tideDatas;

@end
