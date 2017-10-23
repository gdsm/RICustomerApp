//
//  ReportLineCell.h
//  ReddyIce
//
//  Created by Gagan on 18/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ReportLineView.h"

@interface ReportLineCell : BaseTableViewCell

+ (ReportLineCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;

- (void) addLine:(ReportLineView *)line;

/**
 * @brief Add methods for v4 Style version. It creates report line cell view with rounded corners and border.
 * @param dividers :-  Width Ratio size of cellbackground component.
 * @param count :- A value that identifies no of labels in cellbackground.
 * @method - (void) initWithDividers:(CGFloat *)dividers count:(NSUInteger)count
 */
- (void) initWithDividers:(CGFloat *)dividers count:(NSUInteger)count;

@property(nonatomic) BOOL top,down,side; //Indicate which side border has been added

/* The cellbackground is used for design cell structure */
@property (nonatomic, strong) ReportLineView *reportLineView;

@property (nonatomic) UIEdgeInsets cellBackgroundInsets;

@property BOOL canHighlighted;

@end
