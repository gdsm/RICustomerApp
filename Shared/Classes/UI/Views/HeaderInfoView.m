//
//  HeaderInfoView.m
//  ReddyIce
//
//  Created by Gagan on 12/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "HeaderInfoView.h"
#import "Globals.h"

const CGFloat headerInfoView_topMargin = 0;
const CGFloat headerInfoView_bottomMargin = 0;
const CGFloat headerInfoView_leftMargin = 40;
const CGFloat headerInfoView_rightMargin = 40;

const CGFloat headerInfoViewDefaultHeight = 60;

@implementation HeaderInfoView

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self != nil)
    {
        [self initialize];
    }
    return self;
}

- (void) initialize
{
    self.prefferedHeight = headerInfoViewDefaultHeight;
    self.contentInset = UIEdgeInsetsMake(headerInfoView_topMargin, headerInfoView_leftMargin, headerInfoView_bottomMargin, headerInfoView_rightMargin);
}

- (UILabel *) lblInfo
{
    if (_lblInfo == nil)
    {
        _lblInfo = [[UILabel alloc] initWithFrame:self.bounds];
        _lblInfo.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _lblInfo.font = [Globals shared].defaultInfoFont;
        _lblInfo.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblInfo.numberOfLines = 0;
        _lblInfo.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_lblInfo];
    }
    return _lblInfo;
}

- (void) layoutUI
{
    CGRect rect_lblInfo = self.lblInfo.frame;
    rect_lblInfo.origin.x = self.contentInset.left;
    rect_lblInfo.origin.y = self.contentInset.top;
    rect_lblInfo.size.width = self.bounds.size.width - (self.contentInset.left + self.contentInset.right);
    rect_lblInfo.size.height = self.bounds.size.height - (self.contentInset.top + self.contentInset.bottom);
    self.lblInfo.frame = rect_lblInfo;
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    _contentInset = contentInset;
    [self layoutUI];
}

- (void) setTopInset:(CGFloat)value
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = value;
    self.contentInset = inset;
    [self layoutUI];
}

- (void) setLeftInset:(CGFloat)value
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = value;
    self.contentInset = inset;
    [self layoutUI];
}

- (void) setBottomInset:(CGFloat)value
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = value;
    self.contentInset = inset;
    [self layoutUI];
}

- (void) setRightInset:(CGFloat)value
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = value;
    self.contentInset = inset;
    [self layoutUI];
}

@end
