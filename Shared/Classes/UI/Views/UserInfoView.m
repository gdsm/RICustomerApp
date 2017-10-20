//
//  UserInfoView.m
//  ReddyIce
//
//  Created by Gagan on 13/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "UserInfoView.h"
#import "Globals.h"

const CGFloat UserInfoView_WelcomeTopMargin = 0;
const CGFloat UserInfoView_WelcomeLeftMargin = 0;
const CGFloat UserInfoView_WelcomeRightMargin = 0;
const CGFloat UserInfoView_WelcomeHeight = 20;
const CGFloat UserInfoView_WelcomeNameMargin = 5;

const CGFloat UserInfoView_ImageWidth = 80;
const CGFloat UserInfoView_ImageHeight = 80;
const CGFloat UserInfoView_ImageNameMargin = 5;

const CGFloat UserInfoView_NameLeftMargin = 0;
const CGFloat UserInfoView_NameRightMargin = 0;
const CGFloat UserInfoView_NameHeight = 20;
const CGFloat UserInfoView_NameDescrMargin = 0;

const CGFloat UserInfoView_DescrMarginLeft = 0;
const CGFloat UserInfoView_DescrMarginRight = 0;
const CGFloat UserInfoView_DescrMarginBottom = 0;

@implementation UserInfoView

- (void) updateUI
{
    self.viewUserImage.layer.cornerRadius = UserInfoView_ImageWidth * 0.5;
}

- (void)layoutUI
{
    CGRect rect_lblWelcome = self.lblWelcome.frame;
    CGRect rect_lblUserName = self.lblUserName.frame;
    CGRect rect_lblUserImage = self.viewUserImage.frame;
    CGRect rect_lblDescription = self.lblDescription.frame;

    
    CGFloat yOffset = UserInfoView_WelcomeTopMargin;

    rect_lblWelcome.origin.x = UserInfoView_WelcomeLeftMargin;
    rect_lblWelcome.origin.y = yOffset;
    rect_lblWelcome.size.width = self.frame.size.width - (UserInfoView_WelcomeLeftMargin + UserInfoView_WelcomeRightMargin);
    rect_lblWelcome.size.height = UserInfoView_WelcomeHeight;

    
    yOffset += (UserInfoView_WelcomeHeight + UserInfoView_WelcomeNameMargin);

    
    rect_lblUserImage.size.width = UserInfoView_ImageWidth;
    rect_lblUserImage.size.height = UserInfoView_ImageHeight;
    rect_lblUserImage.origin.x = (self.frame.size.width - UserInfoView_ImageWidth) * 0.5;
    rect_lblUserImage.origin.y = yOffset;

    
    yOffset += (UserInfoView_ImageHeight + UserInfoView_ImageNameMargin);

    
    rect_lblUserName.origin.x = UserInfoView_NameLeftMargin;
    rect_lblUserName.origin.y = yOffset;
    rect_lblUserName.size.width = self.frame.size.width - (UserInfoView_NameLeftMargin + UserInfoView_NameRightMargin);
    rect_lblUserName.size.height = UserInfoView_NameHeight;
    
    
    yOffset += (UserInfoView_NameHeight + UserInfoView_NameDescrMargin);

    
    rect_lblDescription.origin.x = UserInfoView_DescrMarginLeft;
    rect_lblDescription.origin.y = yOffset;
    rect_lblDescription.size.width = self.frame.size.width - (UserInfoView_DescrMarginLeft + UserInfoView_DescrMarginRight);
    rect_lblDescription.size.height = (self.frame.size.height - yOffset);
    
    
    self.lblWelcome.frame = rect_lblWelcome;
    self.viewUserImage.frame = rect_lblUserImage;
    self.lblUserName.frame = rect_lblUserName;
    self.lblDescription.frame = rect_lblDescription;
}

- (UILabel *) lblWelcome
{
    if (_lblWelcome == nil)
    {
        _lblWelcome = [[UILabel alloc] initWithFrame:self.bounds];
        _lblWelcome.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _lblWelcome.font = [Globals shared].defaultInfoFont;
        _lblWelcome.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblWelcome.numberOfLines = 0;
        _lblWelcome.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_lblWelcome];
    }
    return _lblWelcome;
}

- (UILabel *) lblUserName
{
    if (_lblUserName == nil)
    {
        _lblUserName = [[UILabel alloc] initWithFrame:self.bounds];
        _lblUserName.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _lblUserName.font = [Globals shared].boldTextFont;
        _lblUserName.textColor = [Globals shared].themingAssistant.userNameTitleColor;
        _lblUserName.numberOfLines = 0;
        _lblUserName.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_lblUserName];
    }
    return _lblUserName;
}

- (UILabel *) lblDescription
{
    if (_lblDescription == nil)
    {
        _lblDescription = [[UILabel alloc] initWithFrame:self.bounds];
        _lblDescription.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _lblDescription.font = [Globals shared].defaultInfoFont;
        _lblDescription.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblDescription.numberOfLines = 0;
        _lblDescription.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_lblDescription];
    }
    return _lblDescription;
}

- (LogoView *) viewUserImage
{
    if (_viewUserImage == nil)
    {
        CGRect rect = CGRectMake(0, 0, UserInfoView_ImageWidth, UserInfoView_ImageHeight);
        _viewUserImage = [[LogoView alloc] initWithFrame:rect];
        _viewUserImage.backgroundColor = [Globals shared].themingAssistant.profilePicBackground;
        [self addSubview:_viewUserImage];
    }
    return _viewUserImage;
}

@end
