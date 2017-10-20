//
//  EnterQuantityCell.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "EnterQuantityView.h"

@interface EnterQuantityCell : BaseTableViewCell

+ (EnterQuantityCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;

@property (weak, nonatomic) IBOutlet EnterQuantityView *enterQtyView;

@end
