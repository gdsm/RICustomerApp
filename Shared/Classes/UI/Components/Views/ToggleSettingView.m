//
//  ToggleSettingView.m
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ToggleSettingView.h"
#import "NSDecimalNumber+Additions.h"

@interface ToggleSettingView ()
- (IBAction)onValueChanged:(UISwitch *)sender;
@end


@implementation ToggleSettingView

+ (ToggleSettingView *) instance
{
    ToggleSettingView* infoView = nil;
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"ToggleSettingView" owner:self options:nil];
    for (UIView* view in views)
    {
        if ([view isKindOfClass:[ToggleSettingView class]])
        {
            infoView = (ToggleSettingView *)view;
            break;
        }
    }
    return infoView;
}

- (void)updateUI
{
    self.constLeftLblDescr.constant = self.contentInsets.left;
    self.constRightSwitch.constant = self.contentInsets.right;
    self.constTopLblDescr.constant = self.contentInsets.top;
    self.constBottomLbl.constant = self.contentInsets.bottom;
    
    [self.lblDescription defaultStyling];
}

- (IBAction)onValueChanged:(UISwitch *)sender
{
    if (self.onValueChanged != nil)
    {
        self.onValueChanged([NSDecimalNumber decimalNumberWithFloat:sender.isOn]);
    }
}
@end
