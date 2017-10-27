//
//  ItemCell.m
//  ReddyIce
//
//  Created by Gagan on 15/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

+ (ItemCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName
{
    static NSString *CellIdentifier = @"ItemCell";
    ItemCell *cell = (ItemCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[ItemCell class]])
            {
                cell = (ItemCell *)currentObject;
                break;
            }
        }
    }
    
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) updateCell
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.itemView.backgroundColor = [UIColor clearColor];
    
    [self.itemView updateUI];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.itemView layoutUI];
}

@end
