//
//  BaseTableViewCell.h
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

+ (BaseTableViewCell *) blankCell;

- (void) updateCell;
- (void) layoutCell;
@property (nonatomic, strong) NSIndexPath* indexPath;

@end
