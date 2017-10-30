//
//  ReportLineTemplateCell.m
//  ReddyIce
//
//  Created by Gagan on 30/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ReportLineTemplateCell.h"
#import "Globals.h"

@implementation ReportLineTemplateCell

+ (ReportLineTemplateCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;
{
    static NSString *CellIdentifier = @"ReportLineTemplateCell";
    ReportLineTemplateCell *cell = (ReportLineTemplateCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[ReportLineTemplateCell class]])
            {
                cell = (ReportLineTemplateCell *)currentObject;
                break;
            }
        }
    }
    
    return cell;
}
- (void)updateCell
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void) addLine:(ReportLineTemplateCell *)line
{
    [self.contentView addSubview:line];
    line.frame = self.contentView.bounds;
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void) initWithDividers:(CGFloat *)dividers
                  count:(NSUInteger)count
       callbackTemplate:(blk_initTemplateView)callbackInit
         layoutTemplate:(blk_layoutTemplateView)callbackLayout
{
    [self setBackgroundColor:[UIColor clearColor]];
    if(_reportLineTemplate == nil)
    {
        _reportLineTemplate = [[ReportLineTemplate alloc] initWithDividers:dividers count:count callbackTemplate:callbackInit layoutTemplate:callbackLayout];
        [self.contentView addSubview:_reportLineTemplate];
        _reportLineTemplate.backgroundColor = [UIColor clearColor];
    }
}

- (BaseView *) viewUnderLine
{
    if (_viewUnderLine == nil)
    {
        _viewUnderLine = [[BaseView alloc] initWithFrame:CGRectMake(self.reportLineTemplate.contentInsets.left, self.frame.size.height - seperatorHeight_1px, self.reportLineTemplate.contentWidth, seperatorHeight_1px)];
        _viewUnderLine.hidden = YES;
        _viewUnderLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _viewUnderLine.backgroundColor = [Globals shared].themingAssistant.defaultSeperatorColor;
        
        [self.contentView addSubview:_viewUnderLine];
    }
    return _viewUnderLine;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect_reportLine = self.reportLineTemplate.frame;
    rect_reportLine.origin.x = self.reportLineTemplate.contentInsets.left;
    rect_reportLine.origin.y = self.reportLineTemplate.contentInsets.top;
    rect_reportLine.size.width = self.contentView.frame.size.width - (self.reportLineTemplate.contentInsets.left + self.reportLineTemplate.contentInsets.right);
    rect_reportLine.size.height = self.contentView.frame.size.height - (self.reportLineTemplate.contentInsets.top + self.reportLineTemplate.contentInsets.bottom);
    self.reportLineTemplate.frame = rect_reportLine;
    
    if ((_viewUnderLine != nil) && (_viewUnderLine.hidden == NO))
    {
        CGRect rect_viewUnderline = self.viewUnderLine.frame;
        rect_viewUnderline.origin.x = rect_reportLine.origin.x;
        rect_viewUnderline.origin.y = self.contentView.frame.size.height - (rect_viewUnderline.size.height);
        rect_viewUnderline.size.width = rect_reportLine.size.width;
        self.viewUnderLine.frame = rect_viewUnderline;
    }
}

@end
