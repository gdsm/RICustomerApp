//
//  CategoryDetailCell.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CategoryDetailView.h"

extern const CGFloat CatDetCell_Default_Height;

@interface CategoryDetailCell : BaseTableViewCell

+ (CategoryDetailCell *) dequeueFrom:(UITableView *)tableView loadFromNib:(NSString *)nibName;

@property (weak, nonatomic) IBOutlet CategoryDetailView *categoryDetailView;
@property (nonatomic, weak) NSString* category;
@property (nonatomic, weak) NSString* detail;

@end
