//
//  ToggleSwitchButton.m
//  ReddyIce
//
//  Created by Gagan on 15/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ToggleSwitchButton.h"
#import "ColoredButton.h"
#import "IconFontCodes.h"

const CGFloat ToggleSwitch_LabelLeftMargin = 2;
const CGFloat ToggleSwitch_CircleTitleMargin = 8;

@interface ToggleSwitchButton ()
@property (nonatomic, strong) ColoredButton* button;
@property (nonatomic, strong) UILabel* lblCircle;
@property (nonatomic, strong) UILabel* lblTitle;
@end

@implementation ToggleSwitchButton
{
    CGFloat titleCheckmarkMargin;
}
- (void)updateUI
{
    self.selected = NO;
    titleCheckmarkMargin = ToggleSwitch_CircleTitleMargin;
}

- (void)layoutUI
{
    CGFloat wh = self.frame.size.height * 0.5;
    CGFloat yOffset = (self.frame.size.height - wh) * 0.5;
    CGFloat xOffset = 0.0;

    CGRect rect_lblCircle = self.lblCircle.frame;
    CGRect rect_lblTitle = self.lblTitle.frame;

    if ((_lblCircle != nil) && (_lblCircle.hidden == NO))
    {
        xOffset = self.frame.size.width * 0.1;
        
        rect_lblCircle.origin.x = xOffset;
        rect_lblCircle.origin.y = yOffset;
        rect_lblCircle.size.height= wh;
        rect_lblCircle.size.width= wh;

        xOffset += wh;
    }

    xOffset += titleCheckmarkMargin;
    rect_lblTitle.origin.x = xOffset;
    rect_lblTitle.origin.y = yOffset;
    rect_lblTitle.size.height= wh;
    rect_lblTitle.size.width= self.frame.size.width - xOffset;

    self.lblCircle.frame = rect_lblCircle;
    self.lblTitle.frame = rect_lblTitle;
    
    self.lblCircle.layer.cornerRadius = wh * 0.5;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (self.selected)
    {
        self.lblCircle.text = [IconFontCodes shared].check;
    }
    else
    {
        self.lblCircle.text = nil;
    }
}

- (void)setHideCheckMark:(BOOL)hideCheckMark
{
    _hideCheckMark = hideCheckMark;
    self.lblCircle.hidden = hideCheckMark;
    
    if (hideCheckMark)
    {
        titleCheckmarkMargin = 0;
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
    }
    else
    {
        titleCheckmarkMargin = ToggleSwitch_CircleTitleMargin;
        self.lblTitle.textAlignment = NSTextAlignmentLeft;
    }
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    self.lblTitle.text = title;
}

- (void)setBgHighColor:(UIColor *)bgHighColor
{
    _bgHighColor = bgHighColor;
    self.button.bgHighlightedColor = _bgHighColor;
}

- (void)setBgNormalColor:(UIColor *)bgNormalColor
{
    _bgNormalColor = bgNormalColor;
    self.button.bgNormalColor = _bgNormalColor;
}

- (void)setBgSelectedColor:(UIColor *)bgSelectedColor
{
    _bgSelectedColor = bgSelectedColor;
    self.button.bgSelectedColor = _bgSelectedColor;
}

- (UILabel *)lblCircle
{
    if (_lblCircle == nil)
    {
        _lblCircle = [[UILabel alloc] init];
        _lblCircle.font = [Globals shared].bbiIconFont;
        _lblCircle.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblCircle.backgroundColor = [UIColor whiteColor];
        _lblCircle.clipsToBounds = YES;
        _lblCircle.adjustsFontSizeToFitWidth = YES;
        _lblCircle.textAlignment = NSTextAlignmentCenter;
        
        [self insertSubview:_lblCircle aboveSubview:self.button];
    }
    return _lblCircle;
}

- (UILabel *) lblTitle
{
    if (_lblTitle == nil)
    {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.font = [Globals shared].defaultTextFont;
        _lblTitle.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblTitle.text = @"20 lbs";
        _lblTitle.backgroundColor = [UIColor clearColor];
        _lblTitle.clipsToBounds = YES;
        _lblTitle.textColor = [UIColor whiteColor];
        _lblTitle.adjustsFontSizeToFitWidth = YES;
        _lblTitle.textAlignment = NSTextAlignmentLeft;
        
        [self insertSubview:_lblTitle aboveSubview:self.button];
    }
    return _lblTitle;
}

- (ColoredButton *)button
{
    if (_button == nil)
    {
        _button = [ColoredButton coloredButtonType:ColoredButtonType_Green frame:self.bounds];
        _button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _button.borderNormalColor = [Globals shared].themingAssistant.defaultBorderColor;
        _button.bgNormalColor = [Globals shared].themingAssistant.itemVariationButtonBGNormalColor;
        _button.bgHighlightedColor = [Globals shared].themingAssistant.itemVariationButtonBGSelectedColor;
        _button.layer.cornerRadius = 6;
        _button.clipsToBounds = YES;

        [_button addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return _button;
}

- (void) onBtnTap:(ColoredButton *)sender
{
    self.selected = !_selected;
    if (self.actionCallback != nil)
    {
        self.actionCallback(self);
    }
}

@end
