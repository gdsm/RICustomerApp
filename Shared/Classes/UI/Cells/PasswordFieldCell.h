//
//  PasswordFieldCell.h
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTextEntryCell.h"
#import "PasswordField.h"

@interface PasswordFieldCell : BaseTextEntryCell

+ (PasswordFieldCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;

@property (weak, nonatomic) IBOutlet PasswordField *passwordField;

@end
