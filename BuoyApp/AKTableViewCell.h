//
//  AKTableViewCell.h
//  BuoyApp
//
//  Created by Andrii on 3/31/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIView *myView;

+ (CGFloat) heightForText:(NSString*) text;

@end
