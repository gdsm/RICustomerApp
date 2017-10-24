//
//  GridPanelCell.m
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "GridPanelCell.h"
#import "CategoryDetailButton.h"

@interface GridPanelCell()
@property (nonatomic, strong) CategoryDetailButton* categoryDetailButton;
@property (nonatomic, strong) GridPanelObject* object;
@property (nonatomic, weak) CategoryDetailView* categoryDetailView;
@end

@implementation GridPanelCell

+ (GridPanelCell *) dequeueFrom:(UICollectionView *)collectionview withReuseIdentifier:(NSString *)identifier forIndexpath:(NSIndexPath *)indexpath
{
    GridPanelCell *retCell = nil;
    if (identifier == nil)
    {
        identifier = [GridPanelCell reuseIdentifier];
    }
    
    retCell = [collectionview dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexpath];
    
    if (retCell == nil)
    {
        retCell = [[GridPanelCell alloc] init];
    }
    
    retCell.backgroundColor = [UIColor clearColor];
    retCell.contentView.backgroundColor = [UIColor clearColor];
    
    return retCell;
}

+ (NSString *) reuseIdentifier
{
    NSString *retVal = NSStringFromClass([GridPanelCell class]);
    return retVal;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (!self.object.buttonObject)
    {
        self.categoryDetailView.lblCategory.highlighted = highlighted;
        self.categoryDetailView.lblDetail.highlighted = highlighted;
    }
}

- (void) loadWithObject:(GridPanelObject*)object
{
    self.object = object;
    
    self.categoryDetailView.category = object.title;
    self.categoryDetailView.detail = object.detail;
    
    UIView* view;
    if (object.buttonObject)
    {
        [self.contentView addSubview:self.categoryDetailButton];
        self.categoryDetailButton.bgNormalColor = object.normalColor;
        self.categoryDetailButton.bgHighlightedColor = object.highlightedColor;
        view = self.categoryDetailButton;
    }
    else
    {
        [self.contentView addSubview:self.categoryDetailView];
        view = self.categoryDetailView;
    }
    
    view.layer.borderWidth = object.borderWidth;
    view.layer.cornerRadius = object.cornerRadius;
    view.layer.borderColor = object.borderColor.CGColor;

    self.categoryDetailView.lblCategory.textColor = object.textColor;
    self.categoryDetailView.lblDetail.textColor = object.textColor;

    self.categoryDetailView.lblCategory.textAlignment = object.titleAlignment;
    self.categoryDetailView.lblDetail.textAlignment = object.detailAlignment;
    self.categoryDetailView.dividerRatio = object.titleDetailDividerRatio;
}

- (CategoryDetailView *)categoryDetailView
{
    if (_categoryDetailView == nil)
    {
        _categoryDetailView = self.categoryDetailButton.categoryDetailView;
    }
    return _categoryDetailView;
}

- (CategoryDetailButton *)categoryDetailButton
{
    if (_categoryDetailButton == nil)
    {
        _categoryDetailButton = [CategoryDetailButton instanceWithFrame:self.bounds];
    }
    return _categoryDetailButton;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIView* view;

    if (self.object.buttonObject)
    {
        view = self.categoryDetailButton;
    }
    else
    {
        view = self.categoryDetailView;
    }

    CGRect rect_view = view.frame;
    rect_view.origin.x = self.object.contentInset.left;
    rect_view.origin.y = self.object.contentInset.top;
    rect_view.size.width = self.object.contentSize.width;
    rect_view.size.height = self.object.contentSize.height;
    view.frame = rect_view;

    [self.categoryDetailView layoutUI];
}


@end
