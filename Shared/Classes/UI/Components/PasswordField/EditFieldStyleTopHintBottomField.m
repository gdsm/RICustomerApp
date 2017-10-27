//
//  EditFieldStyleTopHintBottomField.m
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "EditFieldStyleTopHintBottomField.h"
#import "Globals.h"

@implementation EditFieldStyleTopHintBottomField

+ (EditFieldStyleTopHintBottomField *)instance
{
    EditFieldStyleTopHintBottomField* infoView = nil;
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"EditField" owner:self options:nil];
    for (UIView* view in views)
    {
        if ([view isKindOfClass:[EditFieldStyleTopHintBottomField class]])
        {
            infoView = (EditFieldStyleTopHintBottomField *)view;
            break;
        }
    }
    return infoView;
}

- (void)updateUI
{
    [self.lblHint defaultStyling];
    
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.clipsToBounds = YES;
    
    self.viewUnderline.backgroundColor = [Globals shared].themingAssistant.defaultSeperatorColor;
}

@end
