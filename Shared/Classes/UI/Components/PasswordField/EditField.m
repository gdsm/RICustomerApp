//
//  EditField.m
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "EditField.h"
#import "Globals.h"

const CGFloat EditField_lbl_leftMargin = 0.0f;
const CGFloat EditField_lbl_rightMargin = 0.0f;
const CGFloat EditField_lbl_topMargin = 0.0f;
const CGFloat EditField_lbl_bottomMargin = 5.0f;
const CGFloat EditField_lbl_height = 20.0f;

const CGFloat EditField_tf_leftMargin = 0.0f;
const CGFloat EditField_tf_rightMargin = 0.0f;
const CGFloat EditField_tf_topMargin = 10.0f;
const CGFloat EditField_tf_botomMargin = 1.0f;




@implementation EditField

- (void) layoutUI
{
    CGRect rect_lblHint = self.lblHint.frame;
    CGRect rect_textField = self.textField.frame;
    CGRect rect_underLine = self.viewUnderLine.frame;
    
    CGFloat offsetY = 0;
    
    if (self.lblHint.hidden == NO)
    {
        offsetY += EditField_lbl_topMargin;
        
        rect_lblHint.origin.x = EditField_lbl_leftMargin;
        rect_lblHint.origin.y = offsetY;
        rect_lblHint.size.height = EditField_lbl_height;
        rect_lblHint.size.width = self.frame.size.width - EditField_lbl_leftMargin - EditField_lbl_rightMargin;
        
        offsetY += (rect_lblHint.size.height);
    }
    
    if (self.textField.hidden == NO)
    {
        offsetY += EditField_tf_topMargin;
        
        rect_textField.origin.x = EditField_tf_leftMargin;
        rect_textField.origin.y = offsetY;
        rect_textField.size.height = self.frame.size.height - offsetY - EditField_tf_botomMargin;
        rect_textField.size.width = self.frame.size.width - EditField_tf_leftMargin - EditField_tf_rightMargin;

        offsetY += (offsetY + rect_textField.size.height);
    }
    
    if (self.viewUnderLine.hidden == NO)
    {
        rect_underLine.origin.x = 0;
        rect_underLine.origin.y = self.frame.size.height - seperatorHeight_1px;
        rect_underLine.size.width = self.frame.size.width;
        rect_underLine.size.height = seperatorHeight_1px;
    }
    
    self.lblHint.frame = rect_lblHint;
    self.textField.frame = rect_textField;
    self.viewUnderLine.frame = rect_underLine;
}

- (void)setHintText:(NSString *)hintText
{
    _hintText = hintText;
    self.lblHint.text = hintText;
}

- (void) setPlaceHolderText:(NSString *)placeHolderText
{
    self.textField.placeholder = placeHolderText;
}

- (UILabel *)lblHint
{
    if (_lblHint == nil)
    {
        _lblHint = [[UILabel alloc] initWithFrame:self.frame];
        _lblHint.backgroundColor = [UIColor clearColor];
        _lblHint.clipsToBounds = YES;
        _lblHint.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblHint.font = [Globals shared].defaultInfoFont;
        _lblHint.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_lblHint];
    }
    return _lblHint;
}

- (UITextField *) textField
{
    if (_textField == nil)
    {
        _textField = [[UITextField alloc] initWithFrame:self.frame];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _textField.font = [[Globals shared] defaultTextFont];
        _textField.contentMode = UIViewContentModeScaleAspectFill;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.clipsToBounds = YES;
        
        [self addSubview:_textField];
    }
    return _textField;
}

- (BaseView *) viewUnderLine
{
    if (_viewUnderLine == nil)
    {
        _viewUnderLine = [[BaseView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, seperatorHeight_1px)];
        _viewUnderLine.hidden = NO;
        _viewUnderLine.backgroundColor = [Globals shared].themingAssistant.defaultBorderColor;
        
        [self addSubview:_viewUnderLine];
    }
    return _viewUnderLine;
}

- (BOOL) isResponder
{
    return self.textField.isFirstResponder;
}

@end
