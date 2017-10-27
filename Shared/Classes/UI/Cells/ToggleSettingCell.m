//
//  ToggleSettingCell.m
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ToggleSettingCell.h"

@implementation ToggleSettingCell

+ (ToggleSettingCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName
{
    static NSString *CellIdentifier = @"ToggleSettingCell";
    ToggleSettingCell *cell = (ToggleSettingCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[ToggleSettingCell class]])
            {
                cell = (ToggleSettingCell *)currentObject;
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
    self.toggleSettingView.backgroundColor = [UIColor clearColor];
    [self.toggleSettingView updateUI];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (ToggleSettingView *)toggleSettingView
{
    if (_toggleSettingView == nil)
    {
        _toggleSettingView = [ToggleSettingView instance];
        _toggleSettingView.frame = self.bounds;
        _toggleSettingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_toggleSettingView];
    }
    return _toggleSettingView;
}

@end
