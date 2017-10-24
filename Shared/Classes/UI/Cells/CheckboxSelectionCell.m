//
//  CheckboxSelectionCell.m
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CheckboxSelectionCell.h"

@implementation CheckboxSelectionCell

+ (CheckboxSelectionCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;
{
    static NSString *CellIdentifier = @"CheckboxSelectionCell";
    CheckboxSelectionCell *cell = (CheckboxSelectionCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[CheckboxSelectionCell class]])
            {
                cell = (CheckboxSelectionCell *)currentObject;
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
    [self.lblTitle defaultStyling];
    [self.checkbox updateUI];
    self.checkbox.layer.cornerRadius = self.checkbox.frame.size.height * 0.5;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
