//
//  EditFieldStyleLeftHintRightField.m
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "EditFieldStyleLeftHintRightField.h"
#import "Globals.h"

@implementation EditFieldStyleLeftHintRightField

+ (EditFieldStyleLeftHintRightField *)instance
{
    EditFieldStyleLeftHintRightField* infoView = nil;
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"EditField" owner:self options:nil];
    for (UIView* view in views)
    {
        if ([view isKindOfClass:[EditFieldStyleLeftHintRightField class]])
        {
            infoView = (EditFieldStyleLeftHintRightField *)view;
            break;
        }
    }
    return infoView;
}

- (void)updateUI
{
    [self.lblHint defaultStyling];
    
    self.textField.textColor = [Globals shared].themingAssistant.defaultTextColor;
    self.textField.font = [[Globals shared] defaultTextFont];
    self.textField.contentMode = UIViewContentModeScaleAspectFill;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.clipsToBounds = YES;
    
    self.viewUnderline.backgroundColor = [Globals shared].themingAssistant.defaultSeperatorColor;
}

@end
