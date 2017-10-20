//
//  TicketLineItemCell.h
//  ReddyIce
//
//  Created by Gagan on 18/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TicketLineItemView.h"

@interface TicketLineItemCell : BaseTableViewCell

+ (TicketLineItemCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;
@property (weak, nonatomic) IBOutlet TicketLineItemView *lineItemView;

@end
