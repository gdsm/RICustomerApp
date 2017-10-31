//
//  CustomerCareFeedbackView.m
//  ReddyIce
//
//  Created by Gagan on 31/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CustomerCareFeedbackView.h"
#import "IconFontCodes.h"

@interface CustomerCareFeedbackView()
@end

@implementation CustomerCareFeedbackView

+ (CustomerCareFeedbackView *) instance
{
    CustomerCareFeedbackView* infoView = nil;
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"CustomerCareFeedbackView" owner:self options:nil];
    for (UIView* view in views)
    {
        if ([view isKindOfClass:[CustomerCareFeedbackView class]])
        {
            infoView = (CustomerCareFeedbackView *)view;
            break;
        }
    }
    return infoView;
}

- (void) updateUI
{
    self.btnFeedback.coloredButtonType = ColoredButtonType_Blue;
    self.btnFeedback.titleLabel.font = [Globals shared].bbiIconFont;
    self.btnFeedback.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.btnFeedback.titleNormalColor = [Globals shared].themingAssistant.whiteNorm;
    [self.btnFeedback setTitle:[IconFontCodes shared].comment_text forState:UIControlStateNormal];
    
    [self.lblInfo defaultStyling];
    
    self.btnFeedback.layer.cornerRadius = MIN(self.btnFeedback.frame.size.width, self.btnFeedback.frame.size.height) * 0.5;
    
    self.lblInfo.text = @"We love to hear your feedback.\rIt helps us to serve you better.";
}

- (IBAction)onBtnTap:(ColoredButton *)sender
{
    if ([sender isEqual:self.btnFeedback] && (self.onFeedback != nil))
    {
        self.onFeedback(sender);
    }
}

@end
