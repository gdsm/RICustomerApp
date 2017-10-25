//
//  AdditionalSecurityButtons.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "AdditionalSecurityButtons.h"
#import "DeviceManager.h"
#import "Globals.h"

const CGFloat additionalSecurityButtons_width = 200;

@implementation AdditionalSecurityButtons

- (ColoredButton *) btnFingure
{
    if (_btnFingure == nil)
    {
        _btnFingure = [ColoredButton coloredButtonType:ColoredButtonType_White frame:CGRectMake(0, 0, 50, 50)];
        _btnFingure.titleNormalColor = [[Globals shared].themingAssistant defaultTextColor];
        _btnFingure.titleLabel.font = [[Globals shared] helveticaNeue:16];

        [_btnFingure setTitle:@"Touch ID" forState:UIControlStateNormal];
        
        _btnFingure.hidden = ![DeviceManager shared].supportsFingureScanning;
        [_btnFingure addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:_btnFingure];
    }
    return _btnFingure;
}

- (ColoredButton *) btnPasscode
{
    if (_btnPasscode == nil)
    {
        _btnPasscode = [ColoredButton coloredButtonType:ColoredButtonType_White frame:CGRectMake(0, 0, 50, 50)];
        _btnPasscode.titleNormalColor = [[Globals shared].themingAssistant defaultTextColor];
        _btnPasscode.layer.borderColor = [Globals shared].themingAssistant.defaultBorderColor.CGColor;
        _btnPasscode.layer.borderWidth = 1;
        _btnPasscode.titleLabel.font = [[Globals shared] helveticaNeue:16];

        [_btnPasscode setTitle:@"Passcode" forState:UIControlStateNormal];
        [_btnPasscode addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:_btnPasscode];
    }
    return _btnPasscode;
}

- (void) layoutUI
{
    CGRect rect_btnFingure = self.btnFingure.frame;
    CGRect rect_btnPasscode = self.btnPasscode.frame;

    CGFloat offsetX = 0;
    CGFloat divider = 0.5;
    if (self.btnFingure.hidden)
    {
        divider = 1.0;
    }
    
    rect_btnPasscode.origin.x = offsetX;
    rect_btnPasscode.origin.y = 0;
    rect_btnPasscode.size.width = self.frame.size.width * divider;
    rect_btnPasscode.size.height = self.frame.size.height;
    offsetX += rect_btnPasscode.size.width;
    
    rect_btnFingure.origin.x = offsetX;
    rect_btnFingure.origin.y = 0;
    rect_btnFingure.size.width = self.frame.size.width * (1.0 - divider);
    rect_btnFingure.size.height = self.frame.size.height;

    self.btnFingure.frame = rect_btnFingure;
    self.btnPasscode.frame = rect_btnPasscode;
}


- (void) onBtnTap:(ColoredButton *)sender
{
    if ([sender isEqual:self.btnFingure] && self.onFingureScan)
    {
        self.onFingureScan();
    }
    else if ([sender isEqual:self.btnPasscode] && self.onPassCode)
    {
        self.onPassCode();
    }
}

@end
