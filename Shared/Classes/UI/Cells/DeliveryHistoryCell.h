//
//  DeliveryHistoryCell.h
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DeliveryHistoryView.h"

@interface DeliveryHistoryCell : BaseTableViewCell

+ (DeliveryHistoryCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;
@property (weak, nonatomic) IBOutlet DeliveryHistoryView *deliveryHistoryView;

@end
