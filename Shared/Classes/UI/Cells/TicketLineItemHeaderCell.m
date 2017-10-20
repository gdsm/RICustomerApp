//
//  TicketLineItemHeaderCell.m
//  ReddyIce
//
//  Created by Gagan on 18/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "TicketLineItemHeaderCell.h"

@implementation TicketLineItemHeaderCell

+ (TicketLineItemHeaderCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName
{
    static NSString *CellIdentifier = @"TicketLineItemHeaderCell";
    TicketLineItemHeaderCell *cell = (TicketLineItemHeaderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[TicketLineItemHeaderCell class]])
            {
                cell = (TicketLineItemHeaderCell *)currentObject;
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
    self.lineItemHeaderView.backgroundColor = [UIColor clearColor];
    
    [self.lineItemHeaderView updateUI];
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
    [self.lineItemHeaderView layoutUI];
}

@end
