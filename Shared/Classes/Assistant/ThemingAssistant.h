//
//  ThemingAssistant.h
//  Silver
//
//  Created by Dustin Burke on 5/2/13.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ThemingAssistant : NSObject

@property (nonatomic, strong) UIColor* coloredButtonWhite;
@property (nonatomic, strong) UIColor* blueNorm;
@property (nonatomic, strong) UIColor* blueHigh;
@property (nonatomic, strong) UIColor* redNorm;
@property (nonatomic, strong) UIColor* redHigh;
@property (nonatomic, strong) UIColor* greenBtnNormBG;
@property (nonatomic, strong) UIColor* greenBtnHighBG;

@property (nonatomic, strong) UIColor* defaultTableViewBGColor;
@property (nonatomic, strong) UIColor* defaultViewBGColor;
@property (nonatomic, strong) UIColor* defaultTextColor;
@property (nonatomic, weak) UIColor* defaultBorderColor;
@property (nonatomic, weak) UIColor* defaultIconColor;
@property (nonatomic, weak) UIColor* defaultContentBgColor;
@property (nonatomic, weak) UIColor* defaultButtonNormalBgColor;
@property (nonatomic, weak) UIColor* defaultButtonHighlightedBgColor;
@property (nonatomic, strong) UIColor* defaultSeperatorColor;

@property (nonatomic, weak) UIColor* badgeButtonColor;

@property (nonatomic, weak) UIColor* cartIconColor;

@property (nonatomic, strong) UIColor* touchIDLogoBGColor;
@property (nonatomic, strong) UIColor* touchIDLogoBGBorderColor;

@property (nonatomic, strong) UIColor* homeBtnBgNormColor;
@property (nonatomic, strong) UIColor* homeBtnBgHighColor;
@property (nonatomic, strong) UIColor* homeBtnTitleColor;

@property (nonatomic, strong) UIColor* btmBarBtnBgNormColor;
@property (nonatomic, strong) UIColor* btmBarBtnBgHighColor;
@property (nonatomic, strong) UIColor* btmBarBtnTitleColor;

@property (nonatomic, strong) UIColor* profilePicBackground;
@property (nonatomic, strong) UIColor* userNameTitleColor;

@property (nonatomic, strong) UIColor* itemVCBgColor;
@property (nonatomic, strong) UIColor* itemTitleColor;
@property (nonatomic, strong) UIColor* itemCartQtyTitleColor;
@property (nonatomic, strong) UIColor* itemVariationButtonBGNormalColor;
@property (nonatomic, strong) UIColor* itemVariationButtonBGSelectedColor;

@property (nonatomic, strong) UIColor* checkoutAmountColor;
@property (nonatomic, weak) UIColor* checkoutAmountTitleColor;
@property (nonatomic, strong) UIColor* checkoutBtnHighColor;

@property (nonatomic, weak) UIColor* qtySliderThumbColor;
@property (nonatomic, strong) UIColor* qtySliderLeftTrackColor;

@property (nonatomic, strong) UIColor* crauselDotColor;

@property (nonatomic, strong) UIColor* deliveryTimelineViewBgColor;

@end
