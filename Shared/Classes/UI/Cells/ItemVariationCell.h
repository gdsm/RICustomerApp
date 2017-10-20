//
//  ItemVariationCell.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ItemVariationView.h"

@interface ItemVariationCell : BaseTableViewCell

+ (ItemVariationCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;

@property (weak, nonatomic) IBOutlet ItemVariationView *itemVariationView;

@end
