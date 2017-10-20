//
//  CrauselCell.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CrauselView.h"

@interface CrauselCell : BaseTableViewCell

+ (CrauselCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;

@property (weak, nonatomic) IBOutlet CrauselView *crauselView;

@end
