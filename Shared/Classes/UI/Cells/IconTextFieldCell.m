//
//  IconTextFieldCell.m
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "IconTextFieldCell.h"

@implementation IconTextFieldCell

+ (IconTextFieldCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName
{
    static NSString *CellIdentifier = @"IconTextFieldCell";
    IconTextFieldCell *cell = (IconTextFieldCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[IconTextFieldCell class]])
            {
                cell = (IconTextFieldCell *)currentObject;
                break;
            }
        }
    }
    
    return cell;
}

- (void) updateCell
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.iconTextField.backgroundColor = [UIColor clearColor];
    
    [self.iconTextField updateUI];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.iconTextField.frame;
    rect.origin.x = self.iconTextField.contentInsets.left;
    rect.origin.y = self.iconTextField.contentInsets.top;
    rect.size.width = self.contentView.frame.size.width - (self.iconTextField.contentInsets.left + self.iconTextField.contentInsets.right);
    rect.size.height = self.contentView.frame.size.height - (self.iconTextField.contentInsets.top + self.iconTextField.contentInsets.bottom);
    self.iconTextField.frame = rect;

    [self.iconTextField layoutUI];
}

@end
