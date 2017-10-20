//
//  EnterQuantityView.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "EnterQuantityView.h"
#import "Globals.h"

const CGFloat EnterQtyView_lblQty_width = 40;
const CGFloat EnterQtyView_tflblQty_margin = 10;
const CGFloat EnterQtyView_textField_width = 80;

@implementation EnterQuantityView

- (void)updateUI
{
}

- (void)layoutUI
{
    CGRect rect_lblTitle = self.lblTitle.frame;
    CGRect rect_lblQty = self.lblQty.frame;
    CGRect rect_textField = self.textField.frame;
    CGRect rect_viewUnderLine = self.viewUnderLine.frame;

    rect_lblTitle.origin.x = self.contentInsets.left;
    rect_lblTitle.origin.y = self.contentInsets.top;
    rect_lblTitle.size.width = self.contentWidth * 0.4;
    rect_lblTitle.size.height = self.contentHeight;

    CGFloat xOffset = self.frame.size.width - (self.contentInsets.right + EnterQtyView_lblQty_width);
    rect_lblQty.origin.x = xOffset;
    rect_lblQty.origin.y = self.contentInsets.top;
    rect_lblQty.size.width = EnterQtyView_lblQty_width;
    rect_lblQty.size.height = self.contentHeight;

    xOffset -= (EnterQtyView_textField_width + EnterQtyView_tflblQty_margin);
    rect_textField.origin.x = xOffset;
    rect_textField.origin.y = self.contentInsets.top;
    rect_textField.size.width = EnterQtyView_textField_width;
    rect_textField.size.height = self.contentHeight - seperatorHeight_1px;

    rect_viewUnderLine.origin.x = xOffset;
    rect_viewUnderLine.origin.y = rect_textField.origin.y + rect_textField.size.height;
    rect_viewUnderLine.size.width = rect_textField.size.width;
    rect_viewUnderLine.size.height = seperatorHeight_1px;

    
    self.lblTitle.frame = rect_lblTitle;
    self.lblQty.frame = rect_lblQty;
    self.textField.frame = rect_textField;
    self.viewUnderLine.frame = rect_viewUnderLine;
}

- (UITextField *) textField
{
    if (_textField == nil)
    {
        _textField = [[UITextField alloc] initWithFrame:self.frame];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _textField.font = [[Globals shared] enterQtyFont];
        _textField.contentMode = UIViewContentModeScaleAspectFill;
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.clipsToBounds = YES;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        
        [self addSubview:_textField];
    }
    return _textField;
}

- (UILabel *) lblTitle
{
    if (_lblTitle == nil)
    {
        CGRect rect = CGRectMake(0, 0, self.frame.size.width * 0.5, self.frame.size.height);
        _lblTitle = [[UILabel alloc] initWithFrame:rect];
        _lblTitle.font = [Globals shared].defaultInfoFont;
        _lblTitle.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblTitle.backgroundColor = [UIColor clearColor];
        _lblTitle.textAlignment = NSTextAlignmentLeft;
        _lblTitle.text = @"Select the Quantity";
        _lblTitle.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:_lblTitle];
    }
    return _lblTitle;
}

- (UILabel *)lblQty
{
    if (_lblQty == nil)
    {
        CGRect rect = CGRectMake(0, 0, self.frame.size.width * 0.5, self.frame.size.height);
        _lblQty = [[UILabel alloc] initWithFrame:rect];
        _lblQty.font = [Globals shared].defaultInfoFont;
        _lblQty.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblQty.backgroundColor = [UIColor clearColor];
        _lblQty.textAlignment = NSTextAlignmentRight;
        _lblQty.text = @"Qty.";
        _lblQty.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:_lblQty];
    }
    return _lblQty;
}

- (BaseView *) viewUnderLine
{
    if (_viewUnderLine == nil)
    {
        _viewUnderLine = [[BaseView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, seperatorHeight_1px)];
        _viewUnderLine.hidden = NO;
        _viewUnderLine.backgroundColor = [Globals shared].themingAssistant.defaultSeperatorColor;
        
        [self addSubview:_viewUnderLine];
    }
    return _viewUnderLine;
}

@end
