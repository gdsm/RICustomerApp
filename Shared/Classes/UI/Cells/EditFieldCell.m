//
//  PasswordFieldCell.m
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "EditFieldCell.h"


@interface EditFieldCell() <UITextFieldDelegate>
@end


@implementation EditFieldCell

+ (EditFieldCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName
{
    static NSString *CellIdentifier = @"EditFieldCell";
    EditFieldCell *cell = (EditFieldCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[EditFieldCell class]])
            {
                cell = (EditFieldCell *)currentObject;
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
    self.editField.backgroundColor = [UIColor clearColor];

    self.editField.textField.delegate = self;
    self.editField.textField.keyboardType = self.keyboardType;
    self.editField.textField.returnKeyType = self.returnKeyType;
    
    self.editField.textField.text = [self.dictionary objectForKey:self.key];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self.editField layoutUI];
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
