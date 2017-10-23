//
//  DriverInfoCell.h
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DriverInfoView.h"

@interface DriverInfoCell : BaseTableViewCell

+ (DriverInfoCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;
@property (strong, nonatomic) DriverInfoView *driverInfoView;

@end
