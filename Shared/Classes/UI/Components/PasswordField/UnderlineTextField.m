//
//  UnderlineTextField.m
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "UnderlineTextField.h"
#import "Globals.h"

@implementation UnderlineTextField

- (void) updateUI
{
    [self addSubview:self.textField];
    [self addSubview:self.viewUnderline];
}

- (BaseTextField *)textField
{
    if (_textField == nil)
    {
        CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - seperatorHeight_1px);
        _textField = [[BaseTextField alloc] initWithFrame:rect];
        [_textField defaultStyling];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _textField;
}

- (BaseView *)viewUnderline
{
    if (_viewUnderline == nil)
    {
        CGRect rect = CGRectMake(0, self.bounds.size.height - seperatorHeight_1px, self.bounds.size.width, seperatorHeight_1px);
        _viewUnderline = [[BaseView alloc] initWithFrame:rect];
        _viewUnderline.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _viewUnderline.backgroundColor = [Globals shared].themingAssistant.defaultSeperatorColor;
    }
    return _viewUnderline;
}

@end
