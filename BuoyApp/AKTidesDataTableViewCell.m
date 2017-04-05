//
//  AKTidesDataTableViewCell.m
//  BuoyApp
//
//  Created by Andrii on 3/28/17.
//  Copyright © 2017 Andrii. All rights reserved.
//

#import "AKTidesDataTableViewCell.h"

#import "AKTidesData.h"

@implementation AKTidesDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Create a gradient to apply to the bottom portion of the graph
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    
    // Apply the gradient to the bottom portion of the graph
    self.myGraph.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    
    // Enable and disable various graph properties and axis displays
    self.myGraph.enableTouchReport = YES;
    self.myGraph.enablePopUpReport = YES;
    self.myGraph.enableYAxisLabel = YES;
    self.myGraph.autoScaleYAxis = YES;
    self.myGraph.alwaysDisplayDots = NO;
    self.myGraph.enableReferenceXAxisLines = YES;
    self.myGraph.enableReferenceYAxisLines = YES;
    self.myGraph.enableReferenceAxisFrame = YES;
    
    // Draw an average line
    self.myGraph.averageLine.enableAverageLine = YES;
    self.myGraph.averageLine.alpha = 0.6;
    self.myGraph.averageLine.color = [UIColor darkGrayColor];
    self.myGraph.averageLine.width = 2.5;
    self.myGraph.averageLine.dashPattern = @[@(2),@(2)];
    
    // Set the graph's animation style to draw, fade, or none
    self.myGraph.animationGraphStyle = BEMLineAnimationDraw;
    self.myGraph.animationGraphEntranceTime = 0.6;
    // Dash the y reference lines
    self.myGraph.lineDashPatternForReferenceYAxisLines = @[@(2),@(2)];
    
    // Show the y axis values with this format string
    self.myGraph.formatStringForValues = @"%.1f";
}

- (void)setTideDatas:(NSArray *)tideDatas {
    _tideDatas = tideDatas;
    
    [self.myGraph reloadGraph];
}

- (NSString *)labelForDateAtIndex:(NSInteger)index {
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"yyyy-MM-dd"];
    
    if (index == 0) {
        return @"";
        
    } else {
        NSDate *date = nil;
        AKTidesData *tidesData = [self.tideDatas objectAtIndex:index];
        
        date =  [df1 dateFromString:tidesData.dateJson];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"dd.MM";
        NSString *label = [df stringFromDate:date];
        
        return label;
    }
}

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return self.tideDatas.count;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    AKTidesData *tidesData = [self.tideDatas objectAtIndex:index];
    return tidesData.value;
}

#pragma mark - BEMSimpleLineGraphDelegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 3;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    NSString *lable = [self labelForDateAtIndex:index];
    return lable ? lable : @" ";
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    AKTidesData *tidesData = [self.tideDatas objectAtIndex:index];
    self.dateLabel.text = [NSString stringWithFormat:@"in %@ at %@",tidesData.dateJson, tidesData.dateTime];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    [self setDefaultValueToDateLabel];
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
    [self setDefaultValueToDateLabel];
}

- (void)setDefaultValueToDateLabel {
    NSString *firstDate = [[self.tideDatas firstObject] dateJson];
    NSString *lastDate = [[self.tideDatas lastObject] dateJson];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@", firstDate, lastDate];;
}


@end
