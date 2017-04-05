//
//  AKTableViewCell.m
//  BuoyApp
//
//  Created by Andrii on 3/31/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTableViewCell.h"

@implementation AKTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (CGFloat) heightForText:(NSString*) text {
    
    CGFloat offset = 6.0;
    UIFont* font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    
    NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraph setAlignment:NSTextAlignmentCenter];
    
    NSDictionary* attributes =
    [NSDictionary dictionaryWithObjectsAndKeys:
     font, NSFontAttributeName,
     paragraph, NSParagraphStyleAttributeName, nil];

    CGRect rect = [text boundingRectWithSize:CGSizeMake(320 - 2 * offset, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    
    return MAX(69, CGRectGetHeight(rect) + 2 * offset + 25);
}

@end
