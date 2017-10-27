//
//  EditField.m
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "EditField.h"
#import "Globals.h"
#import "EditFieldStyleTopHintBottomField.h"
#import "EditFieldStyleLeftHintRightField.h"
#import "EditFieldStyleSplit.h"

@interface EditField()
@property (nonatomic, strong) EditFieldStyleTopHintBottomField* editFieldStyleTopHintBottomField;
@property (nonatomic, strong) EditFieldStyleLeftHintRightField* editFieldStyleLeftHintRightField;
@property (nonatomic, strong) EditFieldStyleSplit* editFieldSplit;
@end


@implementation EditField

- (void)setEditFieldStyle:(EditFieldStyle)editFieldStyle
{
    _editFieldStyle = editFieldStyle;
    
    switch (editFieldStyle)
    {
        case EditFieldStyle_Hint_V_TextField:
            [self addSubview:self.editFieldStyleTopHintBottomField];
            break;
        case EditFieldStyle_Hint_H_TextField:
            [self addSubview:self.editFieldStyleLeftHintRightField];
            break;
        case EditFieldStyle_Split:
            [self addSubview:self.editFieldSplit];
            break;
        default:
            break;
    }
}

- (void) layoutUI
{
    UIView* view = nil;
    switch (self.editFieldStyle) {
        case EditFieldStyle_Hint_V_TextField:
            view = self.editFieldStyleTopHintBottomField;
            break;
        case EditFieldStyle_Hint_H_TextField:
            view = self.editFieldStyleLeftHintRightField;
            break;
        case EditFieldStyle_Split:
            view = self.editFieldSplit;
            break;
        default:
            break;
    }
    
    if (view != nil)
    {
        view.frame = CGRectMake(self.contentInsets.left, self.contentInsets.top, self.contentWidth, self.contentHeight);
    }
}

- (void) setHintText:(NSString *)hintText
{
    _hintText = hintText;
    self.lblHint.text = hintText;
}

- (void) setPlaceHolderText2:(NSString *)placeHolderText2
{
    _placeHolderText = placeHolderText2;
    self.textField2.placeholder = placeHolderText2;
}

- (void) setPlaceHolderText:(NSString *)placeHolderText
{
    self.textField.placeholder = placeHolderText;
}

- (UILabel *)lblHint
{
    switch (self.editFieldStyle)
    {
        case EditFieldStyle_Hint_V_TextField:
            return self.editFieldStyleTopHintBottomField.lblHint;
            break;
        case EditFieldStyle_Hint_H_TextField:
            return self.editFieldStyleLeftHintRightField.lblHint;
            break;
        case EditFieldStyle_Split:
            return self.editFieldSplit.lblHint;
            break;
        default:
            break;
    }
    return nil;
}

- (UITextField *) textField
{
    switch (self.editFieldStyle)
    {
        case EditFieldStyle_Hint_V_TextField:
            return self.editFieldStyleTopHintBottomField.textField;
            break;
        case EditFieldStyle_Hint_H_TextField:
            return self.editFieldStyleLeftHintRightField.textField;
            break;
        case EditFieldStyle_Split:
            return self.editFieldSplit.viewTextFieldLeft.textField;
            break;
        default:
            break;
    }
    return nil;
}

- (BaseView *) viewUnderLine
{
    switch (self.editFieldStyle)
    {
        case EditFieldStyle_Hint_V_TextField:
            return self.editFieldStyleTopHintBottomField.viewUnderline;
            break;
        case EditFieldStyle_Hint_H_TextField:
            return self.editFieldStyleLeftHintRightField.viewUnderline;
            break;
        case EditFieldStyle_Split:
            return self.editFieldSplit.viewTextFieldLeft.viewUnderline;
            break;
        default:
            break;
    }
    return nil;
}

- (UITextField *) textField2
{
    switch (self.editFieldStyle)
    {
        case EditFieldStyle_Split:
            return self.editFieldSplit.viewTextFieldRight.textField;
            break;
        default:
            break;
    }
    return nil;
}

- (BaseView *) viewUnderLine2
{
    switch (self.editFieldStyle)
    {
        case EditFieldStyle_Split:
            return self.editFieldSplit.viewTextFieldRight.viewUnderline;
            break;
        default:
            break;
    }
    return nil;
}

- (void)setHideField2:(BOOL)hideField2
{
    _hideField2 = hideField2;
    if (self.editFieldStyle == EditFieldStyle_Split){
        self.editFieldSplit.viewTextFieldRight.hidden = YES;
    }
}

- (BOOL) isResponder
{
    return self.textField.isFirstResponder;
}


- (EditFieldStyleTopHintBottomField *) editFieldStyleTopHintBottomField
{
    if (_editFieldStyleTopHintBottomField == nil)
    {
        _editFieldStyleTopHintBottomField = [EditFieldStyleTopHintBottomField instance];
        [_editFieldStyleTopHintBottomField updateUI];
    }
    return _editFieldStyleTopHintBottomField;
}

- (EditFieldStyleLeftHintRightField *) editFieldStyleLeftHintRightField
{
    if (_editFieldStyleLeftHintRightField == nil)
    {
        _editFieldStyleLeftHintRightField = [EditFieldStyleLeftHintRightField instance];
        [_editFieldStyleLeftHintRightField updateUI];
    }
    return _editFieldStyleLeftHintRightField;
}

- (EditFieldStyleSplit *)editFieldSplit
{
    if (_editFieldSplit == nil)
    {
        _editFieldSplit = [EditFieldStyleSplit instance];
        [_editFieldSplit updateUI];
    }
    return _editFieldSplit;
}

@end
