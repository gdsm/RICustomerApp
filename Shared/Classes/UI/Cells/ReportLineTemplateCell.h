//
//  ReportLineTemplateCell.h
//  ReddyIce
//
//  Created by Gagan on 30/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ReportLineTemplate.h"

@interface ReportLineTemplateCell : BaseTableViewCell

+ (ReportLineTemplateCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;

- (void) addLine:(ReportLineTemplate *)line;

/**
 * @brief Add methods for v4 Style version. It creates report line cell view with rounded corners and border.
 * @param dividers :-  Width Ratio size of cellbackground component.
 * @param count :- A value that identifies no of labels in cellbackground.
 * @method - (void) initWithDividers:(CGFloat *)dividers count:(NSUInteger)count
 */
- (void) initWithDividers:(CGFloat *)dividers
                  count:(NSUInteger)count
       callbackTemplate:(blk_initTemplateView)callbackInit
         layoutTemplate:(blk_layoutTemplateView)callbackLayout;

/* The cellbackground is used for design cell structure */
@property (nonatomic, strong) ReportLineTemplate *reportLineTemplate;

@property (nonatomic, strong) BaseView* viewUnderLine;

@end
