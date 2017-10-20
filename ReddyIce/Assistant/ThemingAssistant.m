//
//  ThemingAssistant.m
//  Silver
//
//  Created by Dustin Burke on 4/25/13.
//
//

#import "ThemingAssistant.h"
#import "Utilities.h"

@implementation ThemingAssistant

- (UIColor *) coloredButtonRed
{
    if (_coloredButtonRed == nil)
    {
        _coloredButtonRed = [[Utilities shared] colorFromHexRed:@"E5" green:@"23" blue:@"23" alpha:@"FF"];
    }
    return _coloredButtonRed;
}

- (UIColor *) coloredButtonGreen
{
    if (_coloredButtonGreen == nil)
    {
        _coloredButtonGreen = [UIColor greenColor];
    }
    return _coloredButtonGreen;
}

- (UIColor *) coloredButtonWhite
{
    if (_coloredButtonWhite == nil)
    {
        _coloredButtonWhite = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    }
    return _coloredButtonWhite;
}

- (UIColor *) defaultTableViewBGColor
{
    if (_defaultTableViewBGColor == nil)
    {
        _defaultTableViewBGColor = [UIColor whiteColor];
    }
    return _defaultTableViewBGColor;
}

- (UIColor *) defaultViewBGColor
{
    if (_defaultViewBGColor == nil)
    {
        _defaultViewBGColor = [UIColor whiteColor];
    }
    return _defaultViewBGColor;
}

- (UIColor *) defaultTextColor
{
    if (_defaultTextColor == nil)
    {
        _defaultTextColor = [[Utilities shared] colorFromHexRed:@"66" green:@"66" blue:@"66" alpha:@"FF"];
    }
    return _defaultTextColor;
}

- (UIColor *) defaultBorderColor
{
    if (_defaultBorderColor == nil)
    {
        _defaultBorderColor = [[Utilities shared] colorFromHexRed:@"04" green:@"77" blue:@"BE" alpha:@"FF"];
    }
    return _defaultBorderColor;
}

- (UIColor *) defaultIconColor
{
    if (_defaultIconColor == nil)
    {
        _defaultIconColor = [[Utilities shared] colorFromHexRed:@"04" green:@"77" blue:@"BE" alpha:@"FF"];
    }
    return _defaultIconColor;
}

- (UIColor *) defaultContentBgColor
{
    if (_defaultContentBgColor == nil)
    {
        _defaultContentBgColor = [[Utilities shared] colorFromHexRed:@"E5" green:@"23" blue:@"23" alpha:@"FF"];
    }
    return _defaultContentBgColor;
}

- (UIColor *) defaultButtonNormalBgColor
{
    if (_defaultButtonNormalBgColor == nil)
    {
        _defaultButtonNormalBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    }
    return _defaultButtonNormalBgColor;
}

- (UIColor *) defaultButtonHighlightedBgColor
{
    if (_defaultButtonHighlightedBgColor == nil)
    {
        _defaultButtonHighlightedBgColor = [[Utilities shared] colorFromHexRed:@"04" green:@"77" blue:@"BE" alpha:@"FF"];
    }
    return _defaultButtonHighlightedBgColor;
}

- (UIColor *) defaultSeperatorColor
{
    if (_defaultSeperatorColor == nil)
    {
        _defaultSeperatorColor = [[Utilities shared] colorFromHexRed:@"99" green:@"99" blue:@"99" alpha:@"FF"];
    }
    return _defaultSeperatorColor;
}

- (UIColor *) badgeButtonColor
{
    if (_badgeButtonColor == nil)
    {
        _badgeButtonColor = self.coloredButtonRed;
    }
    return _badgeButtonColor;
}

- (UIColor *) cartIconColor
{
    if (_cartIconColor == nil)
    {
        _cartIconColor = [[Utilities shared] colorFromHexRed:@"04" green:@"77" blue:@"BE" alpha:@"FF"];
    }
    return _cartIconColor;
}

- (UIColor *) touchIDLogoBGColor
{
    if (_touchIDLogoBGColor == nil)
    {
        _touchIDLogoBGColor = [[Utilities shared] colorFromHexRed:@"FF" green:@"FF" blue:@"FF" alpha:@"FF"];
    }
    return _touchIDLogoBGColor;
}

- (UIColor *) touchIDLogoBGBorderColor
{
    if (_touchIDLogoBGBorderColor == nil)
    {
        _touchIDLogoBGBorderColor = [[Utilities shared] colorFromHexRed:@"CC" green:@"CC" blue:@"CC" alpha:@"FF"];
    }
    return _touchIDLogoBGBorderColor;
}

- (UIColor *) homeBtnBgNormColor
{
    if (_homeBtnBgNormColor == nil)
    {
        _homeBtnBgNormColor = [[[Utilities shared] colorFromHexRed:@"04" green:@"77" blue:@"BE" alpha:@"FF"] colorWithAlphaComponent:0.8];
    }
    return _homeBtnBgNormColor;
}

- (UIColor *) homeBtnBgHighColor
{
    if (_homeBtnBgHighColor == nil)
    {
        _homeBtnBgHighColor = [[Utilities shared] colorFromHexRed:@"14" green:@"40" blue:@"5C" alpha:@"FF"];
    }
    return _homeBtnBgHighColor;
}

- (UIColor *) homeBtnTitleColor
{
    if (_homeBtnTitleColor == nil)
    {
        _homeBtnTitleColor = [[Utilities shared] colorFromHexRed:@"FF" green:@"FF" blue:@"FF" alpha:@"FF"];
    }
    return _homeBtnTitleColor;
}

- (UIColor *) btmBarBtnBgNormColor
{
    if (_btmBarBtnBgNormColor == nil)
    {
        _btmBarBtnBgNormColor = [UIColor clearColor];
    }
    return _btmBarBtnBgNormColor;
}

- (UIColor *) btmBarBtnTitleColor
{
    if (_btmBarBtnTitleColor == nil)
    {
        _btmBarBtnTitleColor = self.defaultTextColor;
    }
    return _btmBarBtnTitleColor;
}

- (UIColor *) btmBarBtnBgHighColor
{
    if (_btmBarBtnBgHighColor == nil)
    {
        _btmBarBtnBgHighColor = [UIColor clearColor];
    }
    return _btmBarBtnBgHighColor;
}

- (UIColor *) profilePicBackground
{
    if (_profilePicBackground == nil)
    {
        _profilePicBackground = [[Utilities shared] colorFromHexRed:@"91" green:@"B3" blue:@"DB" alpha:@"FF"];
    }
    return _profilePicBackground;
}

- (UIColor *) userNameTitleColor
{
    if (_userNameTitleColor == nil)
    {
        _userNameTitleColor = [[Utilities shared] colorFromHexRed:@"04" green:@"63" blue:@"D6" alpha:@"FF"];
    }
    return _userNameTitleColor;
}

- (UIColor *) itemVCBgColor
{
    if (_itemVCBgColor == nil)
    {
        _itemVCBgColor = [[Utilities shared] colorFromHexRed:@"E6" green:@"EF" blue:@"F4" alpha:@"FF"];
    }
    return _itemVCBgColor;
}

- (UIColor *) itemTitleColor
{
    if (_itemTitleColor == nil)
    {
        _itemTitleColor = [[Utilities shared] colorFromHexRed:@"33" green:@"33" blue:@"33" alpha:@"FF"];
    }
    return _itemTitleColor;
}

- (UIColor *) itemCartQtyTitleColor
{
    if (_itemCartQtyTitleColor == nil)
    {
        _itemCartQtyTitleColor = [[Utilities shared] colorFromHexRed:@"99" green:@"99" blue:@"99" alpha:@"FF"];
    }
    return _itemCartQtyTitleColor;
}

- (UIColor *)itemVariationButtonBGNormalColor
{
    if (_itemVariationButtonBGNormalColor == nil)
    {
        _itemVariationButtonBGNormalColor = [[Utilities shared] colorFromHexRed:@"04" green:@"77" blue:@"BE" alpha:@"FF"];
    }
    return _itemVariationButtonBGNormalColor;
}

- (UIColor *)itemVariationButtonBGSelectedColor
{
    if (_itemVariationButtonBGSelectedColor == nil)
    {
        _itemVariationButtonBGSelectedColor = [[Utilities shared] colorFromHexRed:@"14" green:@"40" blue:@"5C" alpha:@"FF"];
    }
    return _itemVariationButtonBGSelectedColor;
}

- (UIColor *) checkoutAmountTitleColor
{
    if (_checkoutAmountTitleColor == nil)
    {
        _checkoutAmountTitleColor = [[Utilities shared] colorFromHexRed:@"99" green:@"99" blue:@"99" alpha:@"FF"];
    }
    return _checkoutAmountTitleColor;
}

- (UIColor *) checkoutBtnHighColor
{
    if (_checkoutBtnHighColor == nil)
    {
        _checkoutBtnHighColor = [[Utilities shared] colorFromHexRed:@"C9" green:@"14" blue:@"14" alpha:@"FF"];
    }
    return _checkoutBtnHighColor;
}

- (UIColor *) checkoutAmountColor
{
    if (_checkoutAmountColor == nil)
    {
        _checkoutAmountColor = [[Utilities shared] colorFromHexRed:@"04" green:@"77" blue:@"BE" alpha:@"FF"];
    }
    return _checkoutAmountColor;
}

- (UIColor *) qtySliderThumbColor
{
    if (_qtySliderThumbColor == nil)
    {
        _qtySliderThumbColor = [[Utilities shared] colorFromHexRed:@"04" green:@"77" blue:@"BE" alpha:@"FF"];
    }
    return _qtySliderThumbColor;
}

- (UIColor *) qtySliderLeftTrackColor
{
    if (_qtySliderLeftTrackColor == nil)
    {
        _qtySliderLeftTrackColor = [[Utilities shared] colorFromHexRed:@"E5" green:@"23" blue:@"23" alpha:@"FF"];
    }
    return _qtySliderLeftTrackColor;
}

- (UIColor *) crauselDotColor
{
    if (_crauselDotColor == nil)
    {
        _crauselDotColor = [[Utilities shared] colorFromHexRed:@"04" green:@"77" blue:@"BE" alpha:@"FF"];
    }
    return _crauselDotColor;
}

- (UIColor *)deliveryTimelineViewBgColor
{
    if (_deliveryTimelineViewBgColor == nil)
    {
        _deliveryTimelineViewBgColor = [[Utilities shared] colorFromHexRed:@"04" green:@"77" blue:@"BE" alpha:@"FF"];
    }
    return _deliveryTimelineViewBgColor;
}

@end
