//
//  TitleCell.m
//  ReddyIce
//
//  Created by Gagan on 12/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "TitleCell.h"
#import "Globals.h"

@implementation TitleCell

+ (TitleCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName
{
    static NSString *CellIdentifier = @"TitleCell";
    TitleCell *cell = (TitleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[TitleCell class]])
            {
                cell = (TitleCell *)currentObject;
                break;
            }
        }
    }
    
    return cell;
}

- (void)awakeFromNib
{
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
    
    self.btnInfo.titleLabel.font = [Globals shared].defaultIconFont;
    self.btnInfo.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btnInfo setTitleColor:[Globals shared].themingAssistant.defaultIconColor forState:UIControlStateNormal];
}

@end
