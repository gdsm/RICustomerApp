//
//  SliderCell.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "SliderCell.h"
#import "Globals.h"

@implementation SliderCell

+ (SliderCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName
{
    static NSString *CellIdentifier = @"SliderCell";
    SliderCell *cell = (SliderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[SliderCell class]])
            {
                cell = (SliderCell *)currentObject;
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
    self.sliderView.backgroundColor = [UIColor clearColor];

    self.sliderView.thumbColor = [Globals shared].themingAssistant.qtySliderThumbColor;
    self.sliderView.leftBarColor = [Globals shared].themingAssistant.qtySliderLeftTrackColor;
    [self.sliderView updateUI];
}

@end
