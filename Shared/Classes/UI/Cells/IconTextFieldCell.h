//
//  IconTextFieldCell.h
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTextEntryCell.h"
#import "IconTextField.h"

@interface IconTextFieldCell : BaseTextEntryCell

+ (IconTextFieldCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;

@property (weak, nonatomic) IBOutlet IconTextField *iconTextField;

@end
