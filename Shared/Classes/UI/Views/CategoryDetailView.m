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
    [self addSubview:self.lblCategory];
    [self addSubview:self.lblDetail];
}

- (UILabel *) lblCategory
{
    if (_lblCategory == nil)
    {
        CGFloat w = self.contentWidth * 0.5;
        CGRect rect = CGRectMake(self.contentInsets.left, self.contentInsets.top, w, self.contentHeight);
        _lblCategory = [[UILabel alloc] initWithFrame:rect];
        _lblCategory.font = [Globals shared].defaultInfoFont;
        _lblCategory.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        _lblCategory.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblCategory.backgroundColor = [UIColor clearColor];
        _lblCategory.textAlignment = NSTextAlignmentLeft;
        _lblCategory.text = @"Category";
        _lblCategory.adjustsFontSizeToFitWidth = YES;
    }
    return _lblCategory;
}

- (UILabel *) lblDetail
{
    if (_lblDetail == nil)
    {
        CGFloat w = self.contentWidth * 0.5;
        CGRect rect = CGRectMake(self.contentInsets.left + w, self.contentInsets.top, w, self.contentHeight);
        _lblDetail = [[UILabel alloc] initWithFrame:rect];
        _lblDetail.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        _lblDetail.font = [Globals shared].defaultInfoFont;
        _lblDetail.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblDetail.backgroundColor = [UIColor clearColor];
        _lblDetail.textAlignment = NSTextAlignmentRight;
        _lblDetail.text = @"Detail";
        _lblDetail.adjustsFontSizeToFitWidth = YES;
    }
    return _lblDetail;
}

@end
