//
//  ReportLineCell.h
//  ReddyIce
//
//  Created by Gagan on 18/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ReportLineCell.h"
#import "Utilities.h"
#import "Globals.h"

@implementation ReportLineCell

+ (ReportLineCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;
{
    static NSString *CellIdentifier = @"ReportLineCell";
    ReportLineCell *cell = (ReportLineCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[ReportLineCell class]])
            {
                cell = (ReportLineCell *)currentObject;
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

- (void) addLine:(ReportLineView *)line
{
    [self.contentView addSubview:line];
    line.frame = self.contentView.bounds;
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

//Add methods for v4 Style version//
- (void) initWithDividers:(CGFloat *)dividers count:(NSUInteger)count
{
    [self setBackgroundColor:[UIColor clearColor]];
    if(_reportLineView == nil)
    {
        _reportLineView = [[ReportLineView alloc] initWithDividers:dividers count:count];
        [self.contentView addSubview:_reportLineView];
        _reportLineView.backgroundColor = [UIColor clearColor];
    }
    _reportLineView.top = self.top;
    _reportLineView.down = self.down;
    _reportLineView.side = self.side;

}

- (BaseView *) viewUnderLine
{
    if (_viewUnderLine == nil)
    {
        _viewUnderLine = [[BaseView alloc] initWithFrame:CGRectMake(self.reportLineView.contentInsets.left, self.frame.size.height - seperatorHeight_1px, self.reportLineView.contentWidth, seperatorHeight_1px)];
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
    
    CGRect rect_reportLine = self.reportLineView.frame;
    rect_reportLine.origin.x = self.reportLineView.contentInsets.left;
    rect_reportLine.origin.y = self.reportLineView.contentInsets.top;
    rect_reportLine.size.width = self.contentView.frame.size.width - (self.reportLineView.contentInsets.left + self.reportLineView.contentInsets.right);
    rect_reportLine.size.height = self.contentView.frame.size.height - (self.reportLineView.contentInsets.top + self.reportLineView.contentInsets.bottom);
    self.reportLineView.frame = rect_reportLine;
    
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
