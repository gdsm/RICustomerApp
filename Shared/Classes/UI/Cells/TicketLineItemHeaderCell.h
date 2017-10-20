//
//  TicketLineItemHeaderCell.h
//  ReddyIce
//
//  Created by Gagan on 18/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TicketLineItemHeaderView.h"

@interface TicketLineItemHeaderCell : BaseTableViewCell

+ (TicketLineItemHeaderCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;
@property (weak, nonatomic) IBOutlet TicketLineItemHeaderView *lineItemHeaderView;

@end
