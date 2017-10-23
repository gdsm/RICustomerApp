//
//  SliderView.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "SliderView.h"
#import "Globals.h"
#import "NSDecimalNumber+Additions.h"

@interface SliderView ()
@property (nonatomic, strong) UISlider* slider;
@property (nonatomic, strong) UILabel* lblMin;
@property (nonatomic, strong) UILabel* lblMax;
@end

@implementation SliderView

- (void) updateUI
{
    [self layoutUI];
}

- (void)layoutUI
{
    CGRect rect_slider = self.slider.frame;
    CGRect rect_lblMax = self.lblMin.frame;
    CGRect rect_lblMin = self.lblMax.frame;

    rect_slider.origin.x = self.contentInsets.left;
    rect_slider.size.width = self.contentWidth;
    rect_slider.origin.y = self.contentInsets.top + ((self.contentHeight - rect_slider.size.height) * 0.5);

    rect_lblMin.origin.x = self.contentInsets.left;
    rect_lblMin.origin.y = self.contentInsets.top;
    rect_lblMin.size.width = self.contentWidth * 0.4;
    rect_lblMin.size.height = viewHeight_20px;

    rect_lblMax.size.width = self.contentWidth * 0.4;
    rect_lblMax.size.height = viewHeight_20px;
    rect_lblMax.origin.x = self.contentWidth - (rect_lblMax.size.width + self.contentInsets.left);
    rect_lblMax.origin.y = self.contentInsets.top;

    self.slider.frame = rect_slider;
    self.lblMin.frame = rect_lblMax;
    self.lblMax.frame = rect_lblMin;
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

- (UILabel *)lblMin
{
    if (_lblMin == nil)
    {
        _lblMin = [self getLabel];
        _lblMin.textAlignment = NSTextAlignmentLeft;
        _lblMin.font = [Globals shared].defaultInfoFont;
        [self addSubview:_lblMin];
    }
    return _lblMin;
}

- (UILabel *) lblMax
{
    if (_lblMax == nil)
    {
        _lblMax = [self getLabel];
        _lblMax.textAlignment = NSTextAlignmentRight;
        _lblMax.font = [Globals shared].defaultInfoFont;
        [self addSubview:_lblMax];
    }
    return _lblMax;
}

@end
