//
//  BaseButton.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

- (void) setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted)
    {
        self.backgroundColor = self.bgHighlightedColor;
    }
    else
    {
        if (self.isSelected)
        {
            self.backgroundColor = self.bgSelectedColor;
        }
        else
        {
            self.backgroundColor = self.bgNormalColor;
        }
    }
}

- (void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected)
    {
        self.backgroundColor = self.bgSelectedColor;
    }
    else
    {
        self.backgroundColor = self.bgNormalColor;
    }
}

- (void) setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if (enabled)
    {
        self.backgroundColor = self.bgNormalColor;
    }
    else
    {
        self.backgroundColor = self.bgDisableColor;
    }
}

- (void) setTitleNormalColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void) setTitleHighlightedColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateHighlighted];
}

- (void) setTitleSelectedColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateSelected];
}

- (void) setTitleDisableColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateDisabled];
}

- (void)setBorderNormalColor:(UIColor *)color
{
    self.layer.borderColor = color.CGColor;
}

- (void)setNormalBorderWidth:(CGFloat)width
{
    self.layer.borderWidth = width;
}

- (void)setBgNormalColor:(UIColor *)bgNormalColor
{
    _bgNormalColor = bgNormalColor;
    self.backgroundColor = bgNormalColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

- (void) layoutUI
{
    // Child class should implement this to layout the UI on parent ViewController demand
}

- (void) updateUI
{
    // child class override this.
}

- (CGFloat) contentHeight
{
    CGFloat retVal = self.frame.size.height - (self.contentInsets.top + self.contentInsets.bottom);
    return retVal;
}

- (CGFloat) contentWidth
{
    CGFloat retVal = self.frame.size.width - (self.contentInsets.left + self.contentInsets.right);
    return retVal;
}

@end
