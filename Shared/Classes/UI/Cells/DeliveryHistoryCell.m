//
//  DeliveryHistoryCell.m
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "DeliveryHistoryCell.h"

@implementation DeliveryHistoryCell

+ (DeliveryHistoryCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;
{
    static NSString *CellIdentifier = @"DeliveryHistoryCell";
    DeliveryHistoryCell *cell = (DeliveryHistoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[DeliveryHistoryCell class]])
            {
                cell = (DeliveryHistoryCell *)currentObject;
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
    self.deliveryHistoryView.backgroundColor = [UIColor clearColor];
    
    [self.deliveryHistoryView updateUI];
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
    [self.deliveryHistoryView layoutUI];
}

@end
