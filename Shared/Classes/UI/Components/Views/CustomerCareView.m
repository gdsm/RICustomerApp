//
//  CustomerCareView.m
//  ReddyIce
//
//  Created by Gagan on 25/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CustomerCareView.h"
#import "IconFontCodes.h"

const CGFloat CustomerCareView_Height = 150;

@implementation CustomerCareView

+ (CustomerCareView *) instance
{
    CustomerCareView* infoView = nil;
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"CustomerCareView" owner:self options:nil];
    for (UIView* view in views)
    {
        if ([view isKindOfClass:[CustomerCareView class]])
        {
            infoView = (CustomerCareView *)view;
            break;
        }
    }
    return infoView;
}

- (void) updateUI
{
    self.btnMessage.coloredButtonType = ColoredButtonType_Blue;
    self.btnMessage.titleLabel.font = [Globals shared].bbiIconFont;
    self.btnMessage.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.btnMessage.titleNormalColor = [Globals shared].themingAssistant.whiteNorm;
    [self.btnMessage setTitle:[IconFontCodes shared].message forState:UIControlStateNormal];
    
    self.btnCall.coloredButtonType = ColoredButtonType_Blue;
    self.btnCall.titleLabel.font = [Globals shared].bbiIconFont;
    self.btnCall.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.btnCall.titleNormalColor = [Globals shared].themingAssistant.whiteNorm;
    [self.btnCall setTitle:[IconFontCodes shared].call forState:UIControlStateNormal];

    [self.lblInfo defaultStyling];
    
    self.btnMessage.layer.cornerRadius = MIN(self.btnMessage.frame.size.width, self.btnMessage.frame.size.height) * 0.5;
    self.btnCall.layer.cornerRadius = MIN(self.btnMessage.frame.size.width, self.btnMessage.frame.size.height) * 0.5;

    [self.btnMessage addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCall addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lblInfo.text = @"For any query reach out to our customer care.\rPlease mention your order number to our customer representative to service you support quickly";
}

- (void) onBtnTap:(ColoredButton *)sender
{
    
}

@end
