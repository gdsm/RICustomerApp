//
//  CategoryDetailCell.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CategoryDetailCell.h"

@implementation CategoryDetailCell

+ (CategoryDetailCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName
{
    static NSString *CellIdentifier = @"CategoryDetailCell";
    CategoryDetailCell *cell = (CategoryDetailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[CategoryDetailCell class]])
            {
                cell = (CategoryDetailCell *)currentObject;
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
    self.categoryDetailView.backgroundColor = [UIColor clearColor];
    
    [self.categoryDetailView updateUI];
}

- (void)setCategory:(NSString *)category
{
    self.categoryDetailView.lblCategory.text = category;
}

- (void)setDetail:(NSString *)detail
{
    self.categoryDetailView.lblDetail.text = detail;
}

@end
