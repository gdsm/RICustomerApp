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

const CGFloat checkboxSize = 20;
const CGFloat checkboxMargin = 5;


@interface CheckBox()
@property (nonatomic, strong) ColoredButton* button;
@end


@implementation CheckBox

- (void) baseViewInitialisation
{
    self.contentInsets = UIEdgeInsetsMake(checkboxMargin, checkboxMargin, checkboxMargin, checkboxMargin);
}

- (void) updateUI
{
    self.button.layer.borderColor = [Globals shared].themingAssistant.defaultSeperatorColor.CGColor;
    self.button.layer.borderWidth = 1;
    self.button.bgNormalColor = [UIColor whiteColor];
    self.button.bgHighlightedColor = [UIColor whiteColor];
    self.button.bgSelectedColor = [UIColor whiteColor];
    self.button.layer.cornerRadius = cornerRadius_6px;
    self.button.clipsToBounds = YES;
    [self addSubview:self.button];
}

- (void)layoutUI
{
    CGRect rect = self.button.frame;
    
    CGFloat wh = MIN(self.contentWidth, self.contentHeight);
    rect.size.width = wh;
    rect.size.height = wh;

    rect.origin.x = self.contentInsets.left + ((self.contentWidth - wh)*0.5);
    rect.origin.y = self.contentInsets.top + ((self.contentHeight - wh)*0.5);;
    self.button.frame = rect;
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
