//
//  TitleCell.h
//  ReddyIce
//
//  Created by Gagan on 12/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface TitleCell : BaseTableViewCell

+ (TitleCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;

@property (weak, nonatomic) IBOutlet UIView *viewLeftLine;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo;
@property (weak, nonatomic) IBOutlet UIView *viewSeperator;

@end
