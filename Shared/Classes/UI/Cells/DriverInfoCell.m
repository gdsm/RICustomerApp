//
//  DriverInfoCell.m
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "DriverInfoCell.h"

@implementation DriverInfoCell

+ (DriverInfoCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;
{
    static NSString *CellIdentifier = @"DriverInfoCell";
    DriverInfoCell *cell = (DriverInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[DriverInfoCell class]])
            {
                cell = (DriverInfoCell *)currentObject;
                break;
            }
        }
    }
    
    return cell;
}

- (void) updateCell
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.driverInfoView.backgroundColor = [UIColor clearColor];
    
    [self.driverInfoView updateUI];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (DriverInfoView *) driverInfoView
{
    if (_driverInfoView == nil)
    {
        _driverInfoView = [DriverInfoView instance];
        _driverInfoView.frame = self.bounds;
        _driverInfoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_driverInfoView];
    }
    return _driverInfoView;
}

@end
