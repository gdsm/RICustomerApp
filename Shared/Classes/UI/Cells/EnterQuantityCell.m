//
//  EnterQuantityCell.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "EnterQuantityCell.h"

@implementation EnterQuantityCell

+ (EnterQuantityCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName
{
    static NSString *CellIdentifier = @"EnterQuantityCell";
    EnterQuantityCell *cell = (EnterQuantityCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[EnterQuantityCell class]])
            {
                cell = (EnterQuantityCell *)currentObject;
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
    self.enterQtyView.backgroundColor = [UIColor clearColor];
    
    [self.enterQtyView updateUI];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.enterQtyView layoutUI];
}

@end
