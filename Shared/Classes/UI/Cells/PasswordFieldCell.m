//
//  PasswordFieldCell.m
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "PasswordFieldCell.h"


const CGFloat pwdFieldCellTopMargin = 10;
const CGFloat pwdFieldCellBottomMargin = 10;
const CGFloat pwdFieldCellLeftMargin = 40;
const CGFloat pwdFieldCellRightMargin = 40;


@interface PasswordFieldCell() <UITextFieldDelegate>
@end


@implementation PasswordFieldCell

+ (PasswordFieldCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName
{
    static NSString *CellIdentifier = @"PasswordFieldCell";
    PasswordFieldCell *cell = (PasswordFieldCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[PasswordFieldCell class]])
            {
                cell = (PasswordFieldCell *)currentObject;
                break;
            }
        }
    }

    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) updateCell
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.passwordField.backgroundColor = [UIColor clearColor];

    self.passwordField.textField.delegate = self;
    self.passwordField.textField.keyboardType = self.keyboardType;
    self.passwordField.textField.returnKeyType = self.returnKeyType;
    
    self.passwordField.textField.text = [self.dictionary objectForKey:self.key];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect_pwdField = self.passwordField.frame;

    rect_pwdField.origin.x = pwdFieldCellLeftMargin;
    rect_pwdField.origin.y = pwdFieldCellTopMargin;
    rect_pwdField.size.width = self.frame.size.width - (pwdFieldCellLeftMargin + pwdFieldCellRightMargin);
    rect_pwdField.size.height = self.frame.size.height - (pwdFieldCellTopMargin + pwdFieldCellBottomMargin);

    self.passwordField.frame = rect_pwdField;

    [self.passwordField layoutUI];
}


#pragma mark - TextField Delegates

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.dictionary setValue:textField.text forKey:self.key];
    id<TextEntryDelegate> delegate = self.textEntryDelegate;
    if (delegate != nil)
    {
        [delegate textFieldShouldEndEditing:textField forIndexPath:self.indexPath inCell:self];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    id<TextEntryDelegate> delegate = self.textEntryDelegate;
    if (delegate != nil)
    {
        [delegate textFieldShouldReturn:textField forIndexPath:self.indexPath inCell:self];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self.dictionary setValue:textField.text forKey:self.key];
    return YES;
}

@end
