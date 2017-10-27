//
//  QuickOrderView.m
//  ReddyIce
//
//  Created by Gagan on 25/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "QuickOrderView.h"

const CGFloat QuickOrderViewHeight = 170;
const CGFloat QuickOrderViewTopMargin = 20;
const CGFloat QuickOrderBtn_Height = 90;

@implementation QuickOrderView

- (void)updateUI
{
    [self addSubview:self.btnQuickOrder];
    [self addSubview:self.lblInfo];
}

- (void) onBtnTap:(ColoredButton *)sender
{
    if (self.onQuickCheckout != nil)
    {
        self.onQuickCheckout(sender);
    }
}

- (ColoredButton *)btnQuickOrder
{
    if (_btnQuickOrder == nil)
    {
        CGRect rect = CGRectZero;
        rect.origin.y = self.contentInsets.top;
        rect.size.height = QuickOrderBtn_Height;
        rect.size.width = rect.size.height;
        rect.origin.x = (self.frame.size.width - rect.size.width) * 0.5;

        _btnQuickOrder = [ColoredButton coloredButtonType:ColoredButtonType_Red frame:rect];
        [_btnQuickOrder setImage:[UIImage imageNamed:@"QuickOrder.png"] forState:UIControlStateNormal];
        _btnQuickOrder.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        _btnQuickOrder.layer.cornerRadius = rect.size.height * 0.5;

        _btnQuickOrder.clipsToBounds = YES;

        _btnQuickOrder.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        [_btnQuickOrder addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnQuickOrder;
}

- (BaseLabel *)lblInfo
{
    if (_lblInfo == nil)
    {
        CGRect rect = CGRectZero;
        rect.origin.x = self.contentInsets.left;
        rect.origin.y = self.btnQuickOrder.frame.origin.y + self.btnQuickOrder.frame.size.height + self.contentMargin;
        rect.size.width = self.contentWidth;
        rect.size.height = self.contentHeight + self.contentInsets.top - rect.origin.y;

        _lblInfo = [self getBaseLabel];
        _lblInfo.frame = rect;
        _lblInfo.text = @"Quick Order";
        _lblInfo.textAlignment = NSTextAlignmentCenter;
        _lblInfo.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    return _lblInfo;
}
@end
