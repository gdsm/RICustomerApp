//
//  CartView.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CartView.h"
#import "BadgeButton.h"
#import "IconFontCodes.h"

static CartView *staticCartView = nil;

@interface CartView()
@property (nonatomic, strong) BadgeButton* btnCart;
@end


@implementation CartView

+ (CartView *) instance
{
    if (staticCartView == nil)
    {
        staticCartView = [[CartView alloc] initWithFrame:CGRectMake(0, 0, cartSize_44px, cartSize_44px)];
        [staticCartView listenNotifications];
        [staticCartView updateUI];
    }
    
    return staticCartView;
}

+ (void) clearInstance
{
    [staticCartView removeNotifications];
    staticCartView = nil;
}

- (void)listenNotifications
{
    
}

- (void)removeNotifications
{
    
}

- (void)updateUI
{
    [self addSubview:self.btnCart];
}

- (void) onBtnCart:(BadgeButton *)sender
{
    if (self.onCartCallback != nil)
    {
        self.onCartCallback(sender);
    }
}

- (void)setHideBadge:(BOOL)hideBadge
{
    _hideBadge = hideBadge;
    self.btnCart.lblBadge.hidden = hideBadge;
}

- (BadgeButton *)btnCart
{
    if (_btnCart == nil)
    {
        _btnCart = [BadgeButton buttonWithType:UIButtonTypeCustom];
        _btnCart.frame = self.bounds;
        _btnCart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _btnCart.badgeNumber = 0;
        _btnCart.titleNormalColor = [Globals shared].themingAssistant.cartIconColor;
        _btnCart.iconTitle = [IconFontCodes shared].cart;
        
        [_btnCart addTarget:self action:@selector(onBtnCart:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCart;
}

@end
