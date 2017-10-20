//
//  ItemCell.h
//  ReddyIce
//
//  Created by Gagan on 15/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ItemView.h"

@interface ItemCell : BaseTableViewCell

+ (ItemCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;

@property (weak, nonatomic) IBOutlet ItemView *itemView;

@end
