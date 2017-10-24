//
//  DeliveryHistoryCell.h
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HistoryView.h"

@interface HistoryCell : BaseTableViewCell

+ (HistoryCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;
@property (weak, nonatomic) IBOutlet HistoryView *historyView;

@end
