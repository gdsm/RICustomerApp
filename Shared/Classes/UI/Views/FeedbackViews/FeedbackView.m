//
//  FeedbackView.m
//  ReddyIce
//
//  Created by Gagan on 27/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "FeedbackView.h"
#import "IconFontCodes.h"

@interface FeedbackView()

@property (weak, nonatomic) IBOutlet ColoredButton *btnLevel1;
@property (weak, nonatomic) IBOutlet ColoredButton *btnLevel2;
@property (weak, nonatomic) IBOutlet ColoredButton *btnLevel3;
@property (weak, nonatomic) IBOutlet ColoredButton *btnLevel4;
@property (weak, nonatomic) IBOutlet BaseView *viewQuestion;

- (IBAction)onBtnTap:(ColoredButton *)sender;

@end

@implementation FeedbackView

+ (FeedbackView *) instance
{
    FeedbackView* infoView = nil;
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"FeedbackLevelView" owner:self options:nil];
    for (UIView* view in views)
    {
        if ([view isKindOfClass:[FeedbackView class]])
        {
            infoView = (FeedbackView *)view;
            break;
        }
    }
    return infoView;
}

- (void)updateUI
{
    self.backgroundColor = [UIColor clearColor];
    self.viewQuestion.backgroundColor = [Globals shared].themingAssistant.blueNorm;
    self.viewQuestion.layer.cornerRadius = cornerRadius_20px;
    [self.lblQuestion defaultStyling];
    self.lblQuestion.textAlignment = NSTextAlignmentCenter;
    self.lblQuestion.textColor = [UIColor whiteColor];
    
    self.btnLevel1.coloredButtonType = ColoredButtonType_Clear;
    self.btnLevel2.coloredButtonType = ColoredButtonType_Clear;
    self.btnLevel3.coloredButtonType = ColoredButtonType_Clear;
    self.btnLevel4.coloredButtonType = ColoredButtonType_Clear;
    
    self.btnLevel1.titleLabel.font = [Globals shared].defaultIconFont;
    self.btnLevel2.titleLabel.font = [Globals shared].defaultIconFont;
    self.btnLevel3.titleLabel.font = [Globals shared].defaultIconFont;
    self.btnLevel4.titleLabel.font = [Globals shared].defaultIconFont;
    
    [self.btnLevel1 setTitle:[IconFontCodes shared].mood_bad forState:UIControlStateNormal];
    [self.btnLevel2 setTitle:[IconFontCodes shared].mood_bad forState:UIControlStateNormal];
    [self.btnLevel3 setTitle:[IconFontCodes shared].mood_bad forState:UIControlStateNormal];
    [self.btnLevel4 setTitle:[IconFontCodes shared].mood_bad forState:UIControlStateNormal];

    [self.btnLevel1 setTitle:[IconFontCodes shared].mood_good forState:UIControlStateSelected];
    [self.btnLevel2 setTitle:[IconFontCodes shared].mood_good forState:UIControlStateNormal];
    [self.btnLevel3 setTitle:[IconFontCodes shared].mood_good forState:UIControlStateNormal];
    [self.btnLevel4 setTitle:[IconFontCodes shared].mood_good forState:UIControlStateNormal];
}

- (IBAction)onBtnTap:(ColoredButton *)sender
{
    if (self.onRattingValue != nil)
    {
        if ([sender isEqual:_btnLevel1]){
            self.feedbackValue = 1;
            self.onRattingValue(self);
        }
        else if ([sender isEqual:_btnLevel2]){
            self.feedbackValue = 2;
            self.onRattingValue(self);
        }
        else if ([sender isEqual:_btnLevel3]){
            self.feedbackValue = 3;
            self.onRattingValue(self);
        }
        else if ([sender isEqual:_btnLevel4]){
            self.feedbackValue = 4;
            self.onRattingValue(self);
        }
    }
}

@end
