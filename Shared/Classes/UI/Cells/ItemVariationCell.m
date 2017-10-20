//
//  ItemVariationCell.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ItemVariationCell.h"

@implementation ItemVariationCell

+ (ItemVariationCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName
{
    static NSString *CellIdentifier = @"ItemVariationCell";
    ItemVariationCell *cell = (ItemVariationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[ItemVariationCell class]])
            {
                cell = (ItemVariationCell *)currentObject;
                break;
            }
        }
    }
    
    return cell;
}

- (void)awakeFromNib {
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
    self.itemVariationView.backgroundColor = [UIColor clearColor];
    
    [self.itemVariationView updateUI];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.itemVariationView layoutUI];
}

@end
