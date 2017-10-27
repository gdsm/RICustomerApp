
#import "ThemingAssistant.h"
#import "Utilities.h"

@implementation ThemingAssistant


#pragma mark - Core Colors

- (UIColor *) blueNorm
{
    if (_blueNorm == nil)
    {
        _blueNorm = [[Utilities shared] colorFromHexRed:@"04" green:@"77" blue:@"BE" alpha:@"FF"];
    }
    return _blueNorm;
}

- (UIColor *) blueHigh
{
    if (_blueHigh == nil)
    {
        _blueHigh = [[Utilities shared] colorFromHexRed:@"14" green:@"40" blue:@"5C" alpha:@"FF"];
    }
    return _blueHigh;
}

- (UIColor *) redNorm
{
    if (_redNorm == nil)
    {
        _redNorm = [[Utilities shared] colorFromHexRed:@"E5" green:@"23" blue:@"23" alpha:@"FF"];
    }
    return _redNorm;
}

- (UIColor *) redHigh
{
    if (_redHigh == nil)
    {
        _redHigh = [[Utilities shared] colorFromHexRed:@"C9" green:@"14" blue:@"14" alpha:@"FF"];
    }
    return _redHigh;
}

- (UIColor *) greenNorm
{
    if (_greenNorm == nil)
    {
        _greenNorm = [UIColor greenColor];
    }
    return _greenNorm;
}

- (UIColor *) greenHigh
{
    if (_greenHigh == nil)
    {
        _greenHigh = [UIColor greenColor];
    }
    return _greenHigh;
}

- (UIColor *) whiteNorm
{
    if (_whiteNorm == nil)
    {
        _whiteNorm = [UIColor whiteColor];
    }
    return _whiteNorm;
}

- (UIColor *) whiteHigh
{
    if (_whiteHigh == nil)
    {
        _whiteHigh = [UIColor lightGrayColor];
    }
    return _whiteHigh;
}

- (UIColor *) gray666666
{
    if (_gray666666 == nil)
    {
        _gray666666 = [[Utilities shared] colorFromHexRed:@"66" green:@"66" blue:@"66" alpha:@"FF"];
    }
    return _gray666666;
}

- (UIColor *) gray999999
{
    if (_gray999999 == nil)
    {
        _gray999999 = [[Utilities shared] colorFromHexRed:@"99" green:@"99" blue:@"99" alpha:@"FF"];
    }
    return _gray999999;
}

- (UIColor *) grayCCCCCC
{
    if (_grayCCCCCC == nil)
    {
        _grayCCCCCC = [[Utilities shared] colorFromHexRed:@"CC" green:@"CC" blue:@"CC" alpha:@"FF"];
    }
    return _grayCCCCCC;
}

- (UIColor *)gray333333
{
    if (_gray333333 == nil)
    {
        _gray333333 = [[Utilities shared] colorFromHexRed:@"33" green:@"33" blue:@"33" alpha:@"FF"];
    }
    return _gray333333;
}

- (UIColor *)clearNorm
{
    if (_clearNorm == nil)
    {
        _clearNorm = [UIColor clearColor];
    }
    return _clearNorm;
}

- (UIColor *)color91B3DB
{
    if (_color91B3DB == nil)
    {
        _color91B3DB = [[Utilities shared] colorFromHexRed:@"91" green:@"B3" blue:@"DB" alpha:@"FF"];
    }
    return _color91B3DB;
}

- (UIColor *)color0463D6
{
    if (_color0463D6 == nil)
    {
        _color0463D6 = [[Utilities shared] colorFromHexRed:@"04" green:@"63" blue:@"D6" alpha:@"FF"];
    }
    return _color0463D6;
}


#pragma mark - Default Colors

- (UIColor *) defaultTableViewBGColor
{
    return self.whiteNorm;
}

- (UIColor *) defaultViewBGColor
{
    return self.whiteNorm;
}

- (UIColor *) defaultTextColor
{
    return self.gray666666;
}

- (UIColor *) defaultBorderColor
{
    return self.blueNorm;
}

- (UIColor *) defaultIconColor
{
    return  self.blueNorm;
}

- (UIColor *) defaultContentBgColor
{
    return self.redNorm;
}

- (UIColor *) defaultSeperatorColor
{
    return self.gray999999;
}


#pragma mark - Usage Based Colors

- (UIColor *) badgeButtonColor
{
    return self.redNorm;
}

- (UIColor *) cartIconColor
{
    return self.blueNorm;
}

- (UIColor *) touchIDLogoBGColor
{
    return self.whiteNorm;
}

- (UIColor *) touchIDLogoBGBorderColor
{
    return self.grayCCCCCC;
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

- (UIColor *) homeBtnIceOrderBgNormColor{
    return self.blueNorm;
}

- (UIColor *) homeBtnIceOrderBgHighColor{
    return self.blueHigh;
}

- (UIColor *) homeBtnFeedbackBgNormColor{
    return self.blueNorm;
}

- (UIColor *) homeBtnFeedbackBgHighColor{
    return self.blueHigh;
}

- (UIColor *) homeBtnEqpSrvcBgNormColor{
    return self.blueNorm;
}

- (UIColor *) homeBtnEqpSrvcBgHighColor{
    return self.blueHigh;
}

- (UIColor *) homeBtnHistoryBgNormColor{
    return self.blueNorm;
}

- (UIColor *) homeBtnHistoryBgHighColor{
    return self.blueHigh;
}

- (UIColor *) btmBarBtnBgNormColor
{
    return self.clearNorm;
}

- (UIColor *) btmBarBtnTitleColor
{
    return self.gray666666;
}

- (UIColor *) btmBarBtnBgHighColor
{
    return self.clearNorm;
}

- (UIColor *) profilePicBackground
{
    return self.color91B3DB;
}

- (UIColor *) userNameTitleColor
{
    return self.color0463D6;
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
    return self.gray333333;
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
    return self.gray999999;
}

- (UIColor *) checkoutBtnHighColor
{
    return self.redHigh;
}

- (UIColor *) checkoutAmountColor
{
    return self.blueNorm;
}

- (UIColor *) qtySliderThumbColor
{
    return self.blueNorm;
}

- (UIColor *) qtySliderLeftTrackColor
{
    return self.redNorm;
}

- (UIColor *) crauselDotColor
{
    return self.blueNorm;
}

- (UIColor *) deliveryTimelineViewBgColor
{
    return self.blueNorm;
}

@end
