//
//  IconTextField.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "IconTextField.h"
#import "Globals.h"

const CGFloat iconTextField_icon_leftMargin = 5.0f;
const CGFloat iconTextField_icon_rightMargin = 5.0f;
const CGFloat iconTextField_icon_topMargin = 5.0f;
const CGFloat iconTextField_icon_bottomMargin = 5.0f;

const CGFloat iconTextField_tf_leftMargin = 5.0f;
const CGFloat iconTextField_tf_rightMargin = 5.0f;
const CGFloat iconTextField_tf_topMargin = 1.0f;
const CGFloat iconTextField_tf_botomMargin = 0.0f;


@interface IconTextField ()
@end


@implementation IconTextField

- (void) layoutUI
{
    CGRect rect_imgv = self.imgvIcon.frame;
    CGRect rect_lblIcon = self.lblIcon.frame;
    CGRect rect_textField = self.textField.frame;
    CGRect rect_underLine = self.viewUnderLine.frame;

    CGFloat offsetX = 0;
    
    if (self.imgvIcon.hidden == NO)
    {
        offsetX += iconTextField_icon_leftMargin;
        
        rect_imgv.origin.x = offsetX;
        rect_imgv.origin.y = iconTextField_icon_topMargin;
        rect_imgv.size.height = self.frame.size.height - iconTextField_icon_topMargin - iconTextField_icon_bottomMargin;
        rect_imgv.size.width = rect_imgv.size.height;
        
        offsetX += (offsetX + rect_imgv.size.width);
    }
    else if (self.lblIcon.hidden == NO)
    {
        offsetX += iconTextField_icon_leftMargin;
        
        rect_lblIcon.origin.x = offsetX;
        rect_lblIcon.origin.y = iconTextField_icon_topMargin;
        rect_lblIcon.size.height = self.frame.size.height - iconTextField_icon_topMargin - iconTextField_icon_bottomMargin;
        rect_lblIcon.size.width = rect_lblIcon.size.height;
        
        offsetX += (offsetX + rect_lblIcon.size.width);
    }

    
    if (self.textField.hidden == NO)
    {
        offsetX += iconTextField_tf_leftMargin;

        rect_textField.origin.x = offsetX;
        rect_textField.origin.y = iconTextField_tf_topMargin;
        rect_textField.size.height = self.frame.size.height - iconTextField_tf_topMargin - iconTextField_tf_botomMargin;
        rect_textField.size.width = self.frame.size.width - offsetX - iconTextField_tf_rightMargin;

        offsetX += (offsetX + rect_textField.size.width);
    }
    
    if (self.viewUnderLine.hidden == NO)
    {
        rect_underLine.origin.x = rect_textField.origin.x;
        rect_underLine.origin.y = self.frame.size.height - seperatorHeight_1px;
        rect_underLine.size.width = rect_textField.size.width;
        rect_underLine.size.height = seperatorHeight_1px;
    }

    self.imgvIcon.frame = rect_imgv;
    self.lblIcon.frame = rect_lblIcon;
    self.textField.frame = rect_textField;
    self.viewUnderLine.frame = rect_underLine;
}

- (void) setImageName:(NSString *)imageName
{
    _imageName = imageName;
    UIImage* image = [UIImage imageNamed:_imageName];
    self.imgvIcon.image = image;

    self.imgvIcon.hidden = NO;
    self.lblIcon.hidden = YES;
}

- (void)setIconCode:(NSString *)iconCode
{
    _iconCode = iconCode;
    self.lblIcon.text = iconCode;
    
    self.imgvIcon.hidden = YES;
    self.lblIcon.hidden = NO;
}

- (void) setPlaceHolderText:(NSString *)placeHolderText
{
    self.textField.placeholder = placeHolderText;
}

- (UIImageView *) imgvIcon
{
    if (_imgvIcon == nil)
    {
        _imgvIcon = [[UIImageView alloc] initWithFrame:self.frame];
        _imgvIcon.backgroundColor = [UIColor clearColor];
        _imgvIcon.contentMode = UIViewContentModeScaleAspectFill;
        _imgvIcon.clipsToBounds = YES;
        
        [self addSubview:_imgvIcon];
    }
    return _imgvIcon;
}

- (UITextField *) textField
{
    if (_textField == nil)
    {
        _textField = [[UITextField alloc] initWithFrame:self.frame];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.contentMode = UIViewContentModeScaleAspectFill;
        _textField.font = [Globals shared].defaultTextFont;
        _textField.clipsToBounds = YES;
        
        [self addSubview:_textField];
    }
    return _textField;
}

- (BaseLabel *) lblIcon
{
    if (_lblIcon == nil)
    {
        _lblIcon = [[BaseLabel alloc] initWithFrame:self.frame];
        [_lblIcon iconStyling];
        [self addSubview:_lblIcon];
    }
    return _lblIcon;
}

- (BaseView *) viewUnderLine
{
    if (_viewUnderLine == nil)
    {
        _viewUnderLine = [[BaseView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, seperatorHeight_1px)];
        _viewUnderLine.backgroundColor = [Globals shared].themingAssistant.defaultSeperatorColor;
        _viewUnderLine.hidden = YES;
        
        [self addSubview:_viewUnderLine];
    }
    return _viewUnderLine;
}

- (BOOL) isResponder
{
    return self.textField.isFirstResponder;
}

@end
