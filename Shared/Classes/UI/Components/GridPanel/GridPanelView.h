//
//  GridPanelView.h
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "GridPanelObject.h"


typedef GridPanelObject* (^blk_gridData)(NSInteger row);
typedef void (^blk_gridAction)(GridPanelObject *object, NSUInteger index);


@interface GridPanelView : BaseView

- (id) initWithFrame:(CGRect)frame
       numberOfGrids:(NSUInteger)grids
     scrollDirection:(UICollectionViewScrollDirection)direction
            gridData:(blk_gridData)data
          gridAction:(blk_gridAction)action;

- (void) reloadGrid;

@property (nonatomic, readonly) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic, readonly) NSUInteger numberOfGrids;

@property (nonatomic, strong) blk_gridData gridDataCallback;
@property (nonatomic, strong) blk_gridAction gridActionCallback;

@end
