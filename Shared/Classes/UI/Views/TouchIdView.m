//
//  TouchIdView.m
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "TouchIdView.h"
#import "Globals.h"
#import "IconFontCodes.h"


const CGFloat TouchIDView_RILogoTopMargin = 20;
const CGFloat TouchIDView_RILogoInfoMargin = 20;
const CGFloat TouchIDView_InfoLeftMargin = 40;
const CGFloat TouchIDView_InfoRightMargin = 40;
const CGFloat TouchIDView_InfoTopMargin = 20;
const CGFloat TouchIDView_InfoHeight = 60;
const CGFloat TouchIDView_InfoLogoMargin = 20;
const CGFloat TouchIDView_LogoHeight = 130;
const CGFloat TouchIDView_LogoWidth = 130;
const CGFloat TouchIDView_LogoCornerRad = 20;
const CGFloat TouchIDView_EnterPwdLeftMargin = 40;
const CGFloat TouchIDView_EnterPwdRightMargin = 40;
const CGFloat TouchIDView_EnterPwdBottomMargin = 25;
const CGFloat TouchIDView_EnterPwdHeight = 44;


@implementation TouchIdView

- (void) updateUI
{
    self.viewReddyIceLogo.imageName = @"RILogo.png";
    self.viewReddyIceLogo.backgroundColor = [UIColor clearColor];

    //TODO:[GM]: Add localisation.
    self.lblInfo.text = @"Login with Touch ID \n for faster, easier access to your account";
    self.lblInfo.textColor = [Globals shared].themingAssistant.defaultTextColor;
    self.lblInfo.backgroundColor = [UIColor clearColor];
    
    self.viewLogo.imageName = @"TouchID.png";
    self.viewLogo.layer.cornerRadius = TouchIDView_LogoCornerRad;
    self.viewLogo.clipsToBounds = YES;
    self.viewLogo.backgroundColor = [Globals shared].themingAssistant.touchIDLogoBGColor;
    self.viewLogo.layer.borderColor = [Globals shared].themingAssistant.touchIDLogoBGBorderColor.CGColor;
    self.viewLogo.layer.borderWidth = 1;

    self.btnEnterPassword.coloredButtonType = ColoredButtonType_Clear;
    [self.btnEnterPassword setTitleColor:[Globals shared].themingAssistant.defaultTextColor forState:UIControlStateNormal];
    self.btnEnterPassword.titleLabel.font = [Globals shared].defaultInfoFont;
    [self.btnEnterPassword addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutUI
{
    CGRect rect_viewRILogo = self.viewReddyIceLogo.frame;
    CGRect rect_viewLogo = self.viewLogo.frame;
    CGRect rect_lblInfo = self.lblInfo.frame;
    CGRect rect_btnEnterPwd = self.btnEnterPassword.frame;

    CGFloat yOffset = 0;
    
    rect_viewRILogo.origin.y = TouchIDView_RILogoTopMargin;
    rect_viewRILogo.size.width = logoViewWidth;
    rect_viewRILogo.size.height = logoViewHeight;
    rect_viewRILogo.origin.x = (self.frame.size.width - rect_viewRILogo.size.width) * 0.5;
    yOffset += (rect_viewRILogo.origin.y + rect_viewRILogo.size.height + TouchIDView_RILogoInfoMargin);

    rect_lblInfo.origin.x = TouchIDView_InfoLeftMargin;
    rect_lblInfo.origin.y = yOffset;
    rect_lblInfo.size.width = self.frame.size.width - (TouchIDView_InfoLeftMargin + TouchIDView_InfoRightMargin);
    rect_lblInfo.size.height = TouchIDView_InfoHeight;
    yOffset += (rect_lblInfo.size.height + TouchIDView_InfoLogoMargin);
    
    rect_viewLogo.size.width = TouchIDView_LogoWidth;
    rect_viewLogo.size.height = TouchIDView_LogoWidth;
    rect_viewLogo.origin.x = (self.frame.size.width - TouchIDView_LogoWidth) * 0.5;
    rect_viewLogo.origin.y = yOffset;

    rect_btnEnterPwd.origin.x = TouchIDView_EnterPwdLeftMargin;
    rect_btnEnterPwd.size.height = TouchIDView_EnterPwdHeight;
    rect_btnEnterPwd.origin.y = self.frame.size.height - (TouchIDView_EnterPwdBottomMargin + TouchIDView_EnterPwdHeight);
    rect_btnEnterPwd.size.width = self.frame.size.width - (TouchIDView_EnterPwdLeftMargin + TouchIDView_EnterPwdRightMargin);;

    self.viewReddyIceLogo.frame = rect_viewRILogo;
    self.viewLogo.frame = rect_viewLogo;
    self.lblInfo.frame = rect_lblInfo;
    self.btnEnterPassword.frame = rect_btnEnterPwd;
}

- (void) onBtnTap:(ColoredButton *)sender
{
    if (self.onEnterPassword != nil)
    {
        self.onEnterPassword(sender);
    }
}

@end
