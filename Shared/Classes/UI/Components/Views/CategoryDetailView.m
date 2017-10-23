//
//  CategoryDetailView.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CategoryDetailView.h"
#import "Globals.h"

@implementation CategoryDetailView

- (void)updateUI
{
    _dividerRatio = 0.5;
    
    [self addSubview:self.lblCategory];
    [self addSubview:self.lblDetail];

    [self addSubview:self.imgvCategory];
    [self addSubview:self.imgvDetail];

    [self addSubview:self.viewUnderLine];
}

- (void) setCategory:(NSString *)category
{
    _category = category;
    self.lblCategory.text = category;
    
    self.imgvCategory.hidden = YES;
    self.lblCategory.hidden = NO;
}

- (void) setDetail:(NSString *)detail
{
    _detail = detail;
    self.lblDetail.text = detail;
    
    self.imgvDetail.hidden = YES;
    self.lblDetail.hidden = NO;
}

- (void) setImgCategory:(NSString *)imgCategory
{
    _imgCategory = imgCategory;
    self.imgvCategory.image = [UIImage imageNamed:imgCategory];
    
    self.imgvCategory.hidden = NO;
    self.lblCategory.hidden = YES;
}

- (void) setImgDetail:(NSString *)imgDetail
{
    _imgDetail = imgDetail;
    self.imgvDetail.image = [UIImage imageNamed:imgDetail];

    self.imgvDetail.hidden = NO;
    self.lblDetail.hidden = YES;
}

- (void) layoutUI
{
    CGRect rect_category = CGRectZero;
    CGRect rect_detail = CGRectZero;
    
    rect_category.origin.x = self.contentInsets.left;
    rect_category.origin.y = self.contentInsets.top;
    rect_category.size.width = self.contentWidth * self.dividerRatio;
    rect_category.size.height = self.contentHeight;
    
    rect_detail.origin.x = rect_category.origin.x + rect_category.size.width;
    rect_detail.origin.y = self.contentInsets.top;
    rect_detail.size.width = self.contentWidth * (1 - self.dividerRatio);
    rect_detail.size.height = self.contentHeight;
    
    if (self.lblCategory.hidden == false)
    {
        self.lblCategory.frame = rect_category;
    }
    if (self.imgvCategory.hidden == false)
    {
        self.imgvCategory.frame = rect_category;
    }
    if (self.lblDetail.hidden == false)
    {
        self.lblDetail.frame = rect_detail;
    }
    if (self.imgvDetail.hidden == false)
    {
        self.imgvDetail.frame = rect_detail;
    }
}

- (BaseLabel *) lblCategory
{
    if (_lblCategory == nil)
    {
        CGFloat w = self.contentWidth * 0.5;
        CGRect rect = CGRectMake(self.contentInsets.left, self.contentInsets.top, w, self.contentHeight);
        _lblCategory = [[BaseLabel alloc] initWithFrame:rect];
        _lblCategory.font = [Globals shared].defaultInfoFont;
        _lblCategory.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        _lblCategory.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblCategory.backgroundColor = [UIColor clearColor];
        _lblCategory.numberOfLines = 0;
        _lblCategory.textAlignment = NSTextAlignmentLeft;
        _lblCategory.text = @"Category";
        _lblCategory.adjustsFontSizeToFitWidth = YES;
    }
    return _lblCategory;
}

- (BaseLabel *) lblDetail
{
    if (_lblDetail == nil)
    {
        CGFloat w = self.contentWidth * 0.5;
        CGRect rect = CGRectMake(self.contentInsets.left + w, self.contentInsets.top, w, self.contentHeight);
        _lblDetail = [[BaseLabel alloc] initWithFrame:rect];
        _lblDetail.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        _lblDetail.font = [Globals shared].defaultInfoFont;
        _lblDetail.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblDetail.backgroundColor = [UIColor clearColor];
        _lblDetail.numberOfLines = 0;
        _lblDetail.textAlignment = NSTextAlignmentRight;
        _lblDetail.text = @"Detail";
        _lblDetail.adjustsFontSizeToFitWidth = YES;
    }
    return _lblDetail;
}

- (UIImageView *) imgvDetail
{
    if (_imgvDetail == nil)
    {
        CGFloat w = self.contentWidth * 0.5;
        CGRect rect = CGRectMake(self.contentInsets.left + w, self.contentInsets.top, w, self.contentHeight);
        _imgvDetail = [[UIImageView alloc] initWithFrame:rect];
        _imgvDetail.backgroundColor = [UIColor clearColor];
        _imgvDetail.contentMode = UIViewContentModeScaleAspectFit;
        _imgvDetail.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    }
    return _imgvDetail;
}

- (UIImageView *) imgvCategory
{
    if (_imgvCategory == nil)
    {
        CGFloat w = self.contentWidth * 0.5;
        CGRect rect = CGRectMake(self.contentInsets.left + w, self.contentInsets.top, w, self.contentHeight);
        _imgvCategory = [[UIImageView alloc] initWithFrame:rect];
        _imgvCategory.backgroundColor = [UIColor clearColor];
        _imgvCategory.contentMode = UIViewContentModeScaleAspectFit;
        _imgvCategory.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    }
    return _imgvCategory;
}

- (BaseView *) viewUnderLine
{
    if (_viewUnderLine == nil)
    {
        _viewUnderLine = [[BaseView alloc] initWithFrame:CGRectMake(self.contentInsets.left, self.frame.size.height - seperatorHeight_1px, self.contentWidth, seperatorHeight_1px)];
        _viewUnderLine.hidden = YES;
        _viewUnderLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _viewUnderLine.backgroundColor = [Globals shared].themingAssistant.itemCartQtyTitleColor;
    }
    return _viewUnderLine;
}

@end
