//
//  SliderView.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "SliderView.h"
#import "NSDecimalNumber+Additions.h"

@interface SliderView ()
@property (nonatomic, strong) UISlider* slider;
@end

@implementation SliderView

- (void) updateUI
{
    [self layoutUI];
}

- (void)layoutUI
{
    CGRect rect_slider = self.slider.frame;
    
    rect_slider.origin.x = self.contentInsets.left;
    rect_slider.size.width = self.contentWidth;
    rect_slider.origin.y = self.contentInsets.top + ((self.contentHeight - rect_slider.size.height) * 0.5);
    
    self.slider.frame = rect_slider;
}

- (void) setThumbColor:(UIColor *)thumbColor
{
    _thumbColor = thumbColor;
    self.slider.thumbTintColor = thumbColor;
}

- (void) setLeftBarColor:(UIColor *)leftBarColor
{
    _leftBarColor = leftBarColor;
    self.slider.minimumTrackTintColor = leftBarColor;
}

- (void)setRightBarColor:(UIColor *)rightBarColor
{
    _rightBarColor = rightBarColor;
    self.slider.maximumTrackTintColor = rightBarColor;
}

- (void) onValueChanged:(UISlider *)sender
{
    if (self.onValueChangedCallback != nil)
    {
        NSDecimalNumber* value = [NSDecimalNumber decimalNumberWithFloat:sender.value];
        self.onValueChangedCallback(value);
    }
}

- (UISlider *)slider
{
    if (_slider == nil)
    {
        _slider = [[UISlider alloc] initWithFrame:self.bounds];
        [_slider addTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventValueChanged];
        _slider.frame = self.bounds;
        _slider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_slider];
    }
    return _slider;
}

@end
