//
//  CheckoutView.m
//  ReddyIce
//
//  Created by Gagan on 16/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CheckoutView.h"
#import "ColoredButton.h"

const CGFloat checkoutViewHeight = 84;

const CGFloat CheckoutView_btnCart_leftMargin = 20;
const CGFloat CheckoutView_btnCart_topMargin = 20;
const CGFloat CheckoutView_btnCart_bottomMargin = 20;
const CGFloat CheckoutView_btnCart_width = 150;
const CGFloat CheckoutView_btnCart_height = 44;

const CGFloat CheckoutView_lblInfoAmt_rightMargin = 20;
const CGFloat CheckoutView_lblInfoAmt_width = CheckoutView_btnCart_width;
const CGFloat CheckoutView_lblInfoAmt_margin = 5;
const CGFloat CheckoutView_lblAmt_rightMargin = 20;
const CGFloat CheckoutView_lblAmt_width = CheckoutView_btnCart_width;


@interface CheckoutView ()

@property (nonatomic, strong) ColoredButton* btnCheckout;
@property (nonatomic, strong) UILabel* lblAmount;
@property (nonatomic, strong) UILabel* lblInfoAmount;
@property (nonatomic, strong) BaseView* viewUnderLine;

@end


@implementation CheckoutView

- (void)setCheckoutTitle:(NSString *)checkoutTitle
{
    _checkoutTitle = checkoutTitle;
    [self.btnCheckout setTitle:checkoutTitle forState:UIControlStateNormal];
}

- (void) onBtnTap:(ColoredButton *)sender
{
    if (self.onCheckout != nil)
    {
        self.onCheckout(sender);
    }
}

- (void) updateUI
{
    self.backgroundColor = [Globals shared].themingAssistant.itemVCBgColor;
}

#pragma mark - Layout Methods

- (void)layoutUI
{
    CGRect rect_btnCheckout = self.btnCheckout.frame;
    CGRect rect_lblAmount = self.lblAmount.frame;
    CGRect rect_lblInfoAmount = self.lblInfoAmount.frame;
    CGRect rect_viewUnderline = self.viewUnderLine.frame;

    CGFloat btnWidth = self.frame.size.width * 0.4;
    CGFloat btnHeight = self.frame.size.height - (CheckoutView_btnCart_topMargin + CheckoutView_btnCart_bottomMargin);
    btnWidth = MIN(CheckoutView_btnCart_width, btnWidth);
    btnHeight = MIN(CheckoutView_btnCart_height, btnHeight);

    rect_btnCheckout.origin.x = CheckoutView_btnCart_leftMargin;
    rect_btnCheckout.origin.y = (self.frame.size.height - btnHeight) * 0.5;
    rect_btnCheckout.size.width = btnWidth;

    
    CGFloat lblWidth = self.frame.size.width * 0.4;
    lblWidth = MIN(CheckoutView_lblInfoAmt_width, lblWidth);
    CGFloat lblHeight = (btnHeight + (CheckoutView_lblInfoAmt_margin));

    rect_lblInfoAmount.size.width = lblWidth;
    rect_lblInfoAmount.size.height = lblHeight * 0.3;
    rect_lblInfoAmount.origin.x = (self.frame.size.width - CheckoutView_lblInfoAmt_rightMargin - btnWidth);
    rect_lblInfoAmount.origin.y = ((self.frame.size.height - lblHeight) * 0.5) - CheckoutView_lblInfoAmt_margin;

    rect_lblAmount.size.width = btnWidth;
    rect_lblAmount.size.height = lblHeight * 0.7;
    rect_lblAmount.origin.x = (self.frame.size.width - CheckoutView_lblAmt_rightMargin - btnWidth);
    rect_lblAmount.origin.y = (rect_lblInfoAmount.origin.y + rect_lblInfoAmount.size.height);

    rect_viewUnderline.origin.x = 0;
    rect_viewUnderline.origin.y = 0;
    rect_viewUnderline.size.width = self.frame.size.width;
    rect_viewUnderline.size.height = seperatorHeight_1px;

    self.btnCheckout.frame = rect_btnCheckout;
    self.lblAmount.frame = rect_lblAmount;
    self.lblInfoAmount.frame = rect_lblInfoAmount;
    self.viewUnderLine.frame = rect_viewUnderline;
    
//    self.lblAmount.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
//    self.lblInfoAmount.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
}

#pragma mark - UI Methods

- (ColoredButton *) btnCheckout
{
    if (_btnCheckout == nil)
    {
        CGRect rect = CGRectMake(0, 0, CheckoutView_btnCart_width, CheckoutView_btnCart_height);
        _btnCheckout = [ColoredButton coloredButtonType:ColoredButtonType_Red frame:rect];
        [_btnCheckout setTitle:@"Add to Cart" forState:UIControlStateNormal];
        _btnCheckout.titleNormalColor = [UIColor whiteColor];
        _btnCheckout.bgHighlightedColor = [Globals shared].themingAssistant.checkoutBtnHighColor;
        _btnCheckout.layer.cornerRadius = 8;
        _btnCheckout.titleLabel.font = [Globals shared].boldTextFont;
        _btnCheckout.clipsToBounds = YES;
        
        [_btnCheckout addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnCheckout];
    }
    return _btnCheckout;
}

- (UILabel *) lblAmount
{
    if (_lblAmount == nil)
    {
        CGRect rect = CGRectMake(0, 0, CheckoutView_lblAmt_width, CheckoutView_btnCart_height*0.5);
        _lblAmount = [[UILabel alloc] initWithFrame:rect];
        _lblAmount.font = [Globals shared].checkoutTotalFont;
        _lblAmount.textColor = [Globals shared].themingAssistant.checkoutAmountColor;
        _lblAmount.backgroundColor = [UIColor clearColor];
        _lblAmount.textAlignment = NSTextAlignmentRight;
        _lblAmount.text = @"$000.00";
        _lblAmount.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:_lblAmount];
    }
    return _lblAmount;
}

- (UILabel *) lblInfoAmount
{
    if (_lblInfoAmount == nil)
    {
        CGRect rect = CGRectMake(0, 0, CheckoutView_lblInfoAmt_width, CheckoutView_btnCart_height*0.5);
        _lblInfoAmount = [[UILabel alloc] initWithFrame:rect];
        _lblInfoAmount.font = [Globals shared].defaultInfoFont;
        _lblInfoAmount.textColor = [Globals shared].themingAssistant.checkoutAmountTitleColor;
        _lblInfoAmount.backgroundColor = [UIColor clearColor];
        _lblInfoAmount.textAlignment = NSTextAlignmentRight;
        _lblInfoAmount.text = @"Total Amount";
        _lblInfoAmount.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:_lblInfoAmount];
    }
    return _lblInfoAmount;
}

- (BaseView *) viewUnderLine
{
    if (_viewUnderLine == nil)
    {
        _viewUnderLine = [[BaseView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, seperatorHeight_1px)];
        _viewUnderLine.hidden = NO;
        _viewUnderLine.backgroundColor = [Globals shared].themingAssistant.defaultSeperatorColor;
        
        [self addSubview:_viewUnderLine];
    }
    return _viewUnderLine;
}

@end
