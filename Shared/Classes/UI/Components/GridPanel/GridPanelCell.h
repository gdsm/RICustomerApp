//
//  GridPanelCell.h
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridPanelObject.h"

@interface GridPanelCell : UICollectionViewCell

+ (GridPanelCell *) dequeueFrom:(UICollectionView *)collectionview withReuseIdentifier:(NSString *)identifier forIndexpath:(NSIndexPath *)indexpath;
+ (NSString *) reuseIdentifier;
- (void) loadWithObject:(GridPanelObject*)object;

@end
