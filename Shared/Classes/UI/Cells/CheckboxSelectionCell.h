//
//  CheckboxSelectionCell.h
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CheckBox.h"
#import "BaseLabel.h"

@interface CheckboxSelectionCell : BaseTableViewCell

+ (CheckboxSelectionCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;

@property (weak, nonatomic) IBOutlet CheckBox *checkbox;
@property (weak, nonatomic) IBOutlet BaseLabel *lblTitle;

@end
