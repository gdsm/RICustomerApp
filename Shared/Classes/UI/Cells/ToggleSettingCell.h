//
//  ToggleSettingCell.h
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ToggleSettingView.h"

@interface ToggleSettingCell : BaseTableViewCell

+ (ToggleSettingCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;

@property (strong, nonatomic) ToggleSettingView *toggleSettingView;

@end
