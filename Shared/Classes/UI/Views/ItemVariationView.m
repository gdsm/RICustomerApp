//
//  ItemVariationView.m
//  ReddyIce
//
//  Created by Gagan on 15/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ItemVariationView.h"
#import "ToggleSwitchButton.h"

const CGFloat ToggleSwitch_InterMargin = 10;
const CGFloat ToggleSwitch_MaxWidth = 100;

@interface ItemVariationView()
@property (nonatomic, strong) NSMutableArray<ToggleSwitchButton*>* toggleButtons;
@end

@implementation ItemVariationView


#pragma mark - Logical Flow

- (void) toggleSwitchSelected:(ToggleSwitchButton *)sender
{
    if (self.varSelected != nil)
    {
        self.varSelected(nil);
    }
}

- (void)setBgHighColor:(UIColor *)bgHighColor
{
    for (ToggleSwitchButton* btn in self.toggleButtons)
    {
        btn.bgHighColor=  bgHighColor;
    }
}

- (void)setBgNormalColor:(UIColor *)bgNormalColor
{
    for (ToggleSwitchButton* btn in self.toggleButtons)
    {
        btn.bgNormalColor=  bgNormalColor;
    }
}

- (void)setBgSelectedColor:(UIColor *)bgSelectedColor
{
    for (ToggleSwitchButton* btn in self.toggleButtons)
    {
        btn.bgSelectedColor=  bgSelectedColor;
    }
}

- (void)updateUI
{
    _numberOfVariations = 2;
    __weak ItemVariationView* weakSelf = self;
    
    self.maxButtonWidth = ToggleSwitch_MaxWidth;
    
    for (ToggleSwitchButton* btn in self.toggleButtons)
    {
        [btn removeFromSuperview];
    }
    [self.toggleButtons removeAllObjects];
    
    CGFloat avlWidth = self.frame.size.width - (2*ToggleSwitch_InterMargin);
    CGFloat btnWidth = avlWidth / _numberOfVariations;
    
    CGRect rect = CGRectMake(0, 0, btnWidth, self.frame.size.height);
    for (NSInteger i=0 ; i<_numberOfVariations ; i++)
    {
        ToggleSwitchButton* btn = [[ToggleSwitchButton alloc] initWithFrame:rect];
        [btn updateUI];
        btn.hideCheckMark = self.hideCheckMark;
        
        btn.actionCallback = ^(id sender) {
            [weakSelf toggleSwitchSelected:sender];
        };
        
        [self.toggleButtons addObject:btn];
        
        if (i==0)
            btn.title = @"10 lbs";
        else
            btn.title = @"20 lbs";

        [self addSubview:btn];
    }
}

- (void)layoutUI
{
    CGFloat avlWidth = self.contentWidth - (2*ToggleSwitch_InterMargin);
    CGFloat btnWidth = avlWidth / _numberOfVariations;
    CGFloat xOffset = self.contentInsets.left;
    if (btnWidth > self.maxButtonWidth)
    {
        btnWidth = self.maxButtonWidth;
    }

    CGRect rect = CGRectMake(xOffset, self.contentInsets.top, btnWidth, self.contentHeight);
    
    for (ToggleSwitchButton* btn in self.toggleButtons)
    {
        rect.origin.x = xOffset;
        btn.frame = rect;
        xOffset += (btnWidth + ToggleSwitch_InterMargin);
        
        [btn layoutUI];
    }
}

- (NSMutableArray<ToggleSwitchButton *> *)toggleButtons
{
    if (_toggleButtons == nil)
    {
        _toggleButtons = [NSMutableArray new];
    }
    return _toggleButtons;
}

@end
