//
//  SliderCell.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SliderView.h"

@interface SliderCell : BaseTableViewCell

+ (SliderCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;

@property (weak, nonatomic) IBOutlet SliderView *sliderView;

@end
