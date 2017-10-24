//
//  GridPanelView.m
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "GridPanelView.h"
#import "GridPanelCell.h"

const CGFloat gridPanelInterSpacing = 0.0f;

@interface GridPanelView() <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) NSMutableDictionary* cacheDataSource;

@end


@implementation GridPanelView

- (id) initWithFrame:(CGRect)frame
       numberOfGrids:(NSUInteger)grids
     scrollDirection:(UICollectionViewScrollDirection)direction
            gridData:(blk_gridData)data
          gridAction:(blk_gridAction)action
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        _numberOfGrids = grids;
        _scrollDirection = direction;
        _gridDataCallback = data;
        _gridActionCallback = action;
    }
    return self;
}

- (void) reloadGrid
{
    [self.cacheDataSource removeAllObjects];
    [self.collectionView reloadData];
}

#pragma mark - Cachking

- (NSMutableDictionary *)cacheDataSource
{
    if (_cacheDataSource == nil)
    {
        _cacheDataSource = [NSMutableDictionary new];
    }
    return _cacheDataSource;
}

- (void) setCacheObject:(GridPanelObject *)object forIndexPath:(NSIndexPath *)indexPath
{
    if ((object == nil) || (indexPath == nil))
    {
        return;
    }
    NSString* key = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    [self.cacheDataSource setValue:object forKey:key];
}

- (GridPanelObject *) cacheObjectForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == nil)
    {
        return nil;
    }
    
    NSString* key = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    GridPanelObject * object = [self.cacheDataSource valueForKey:key];
    if (object == nil)
    {
        object = self.gridDataCallback(indexPath.row);
        [self setCacheObject:object forIndexPath:indexPath];
    }
    return object;
}


#pragma mark - UI Methods

- (UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = self.scrollDirection;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.pagingEnabled = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[GridPanelCell class] forCellWithReuseIdentifier:[GridPanelCell reuseIdentifier]];
        _collectionView.contentInset = UIEdgeInsetsZero;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberOfGrids;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridPanelCell* cell = [GridPanelCell dequeueFrom:collectionView withReuseIdentifier:[GridPanelCell reuseIdentifier] forIndexpath:indexPath];
    if (self.gridDataCallback != nil)
    {
        GridPanelObject* object = [self cacheObjectForIndexPath:indexPath];
        [cell loadWithObject:object];
    }
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridPanelObject* object = [self cacheObjectForIndexPath:indexPath];
    if ((self.gridActionCallback != nil) && (object != nil))
    {
        self.gridActionCallback(object, indexPath.row);
    }
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridPanelObject* object = [self cacheObjectForIndexPath:indexPath];
    CGSize retVal = object.gridSize;
    return retVal;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat retVal = gridPanelInterSpacing;
    return retVal;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat retVal = 0.f;
    return retVal;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

@end
