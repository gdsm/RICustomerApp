//
//  EditFieldStyleSplit.m
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "EditFieldStyleSplit.h"
#import "Globals.h"

@implementation EditFieldStyleSplit

+ (EditFieldStyleSplit *)instance
{
    EditFieldStyleSplit* infoView = nil;
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"EditField" owner:self options:nil];
    for (UIView* view in views)
    {
        if ([view isKindOfClass:[EditFieldStyleSplit class]])
        {
            infoView = (EditFieldStyleSplit *)view;
            break;
        }
    }
    return infoView;
}

- (void)updateUI
{
    [self.viewTextFieldLeft updateUI];
    [self.viewTextFieldRight updateUI];

    [self.lblHint defaultStyling];
    [self.viewTextFieldLeft.textField defaultStyling];
    [self.viewTextFieldRight.textField defaultStyling];
    
    self.viewTextFieldLeft.backgroundColor = [UIColor clearColor];
    self.viewTextFieldRight.backgroundColor = [UIColor clearColor];
}


@end
