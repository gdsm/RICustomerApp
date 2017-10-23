//
//  CategoryDetailButton.m
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CategoryDetailButton.h"

@implementation CategoryDetailButton

+ (CategoryDetailButton *) instance
{
    CategoryDetailButton* btn = [CategoryDetailButton buttonWithType:UIButtonTypeCustom];
    [btn updateUI];
    return btn;
}

- (void)updateUI
{
    [self addSubview:self.categoryDetailView];
}

- (CategoryDetailView *) categoryDetailView
{
    if (_categoryDetailView == nil)
    {
        CGRect rect = CGRectMake(self.contentInsets.left, self.contentInsets.top, self.contentWidth, self.contentHeight);
        _categoryDetailView = [[CategoryDetailView alloc] initWithFrame:rect];
        _categoryDetailView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _categoryDetailView.backgroundColor = [UIColor clearColor];
        [_categoryDetailView updateUI];
    }
    return _categoryDetailView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.categoryDetailView layoutUI];
}

@end
