//
//  CheckBox.m
//  ReddyIce
//
//  Created by Gagan on 18/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CheckBox.h"
#import "ColoredButton.h"
#import "IconFontCodes.h"

@interface CheckBox()
@property (nonatomic, strong) ColoredButton* button;
@end

@implementation CheckBox

- (void) updateUI
{
    self.layer.borderColor = [Globals shared].themingAssistant.defaultSeperatorColor.CGColor;
    self.layer.borderWidth = 1;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    [self addSubview:self.button];
}

- (void) onBtnTap:(ColoredButton *)sender
{
    self.selected = !self.selected;
    sender.selected = self.selected;
    
    if (self.selected)
    {
        [self.button setTitle:[IconFontCodes shared].check forState:UIControlStateNormal];
    }
    else
    {
        [self.button setTitle:nil forState:UIControlStateNormal];
    }
    
    if (self.onCheckboxCallback != nil)
    {
        self.onCheckboxCallback(sender);
    }
}

- (ColoredButton *) button
{
    if (_button == nil)
    {
        //TODO:[GM] Add Localisation
        CGRect rect = self.bounds;
        _button = [ColoredButton coloredButtonType:ColoredButtonType_Clear frame:rect];
        _button.titleLabel.adjustsFontSizeToFitWidth = YES;
        _button.titleNormalColor = [Globals shared].themingAssistant.defaultTextColor;
        _button.titleLabel.font = [[Globals shared].defaultIconFont fontWithSize:14];

        [_button addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
