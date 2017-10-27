//
//  ReportLineCell.m
//  Silver
//
//  Created by Dustin on 2/27/14.
//
//

#import "ReportLineCell.h"
#import "Utilities.h"

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

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect_reportLine = self.reportLineView.frame;
    rect_reportLine.origin.x = self.reportLineView.contentInsets.left;
    rect_reportLine.origin.y = self.reportLineView.contentInsets.top;
    rect_reportLine.size.width = self.contentView.frame.size.width - (self.reportLineView.contentInsets.left + self.reportLineView.contentInsets.right);
    rect_reportLine.size.height = self.contentView.frame.size.height - (self.reportLineView.contentInsets.top + self.reportLineView.contentInsets.bottom);
    self.reportLineView.frame = rect_reportLine;
}

@end
