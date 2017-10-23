//
//  DriverInfoView.m
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "DriverInfoView.h"
#import "IconFontCodes.h"
#import "Globals.h"


@interface DriverInfoView()
@property (nonatomic, strong) BaseView* viewUnderLine;
@end


@implementation DriverInfoView

+ (DriverInfoView *) instance
{
    DriverInfoView* infoView = nil;
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"DriverInfoView" owner:self options:nil];
    for (UIView* view in views)
    {
        if ([view isKindOfClass:[DriverInfoView class]])
        {
            infoView = (DriverInfoView *)view;
            break;
        }
    }
    return infoView;
}

- (void) updateUI
{
    [self.lblUserIcon defaultIconFont];
    self.lblUserIcon.text = [IconFontCodes shared].user;
    self.lblName.text = @"Driver Name";
    self.lblPhone.text = @"+1 (000)-(000)-(0000)";
    self.lblLicenseNo.text = @"License No.";
    
    self.lblUserIcon.layer.borderColor = [Globals shared].themingAssistant.defaultBorderColor.CGColor;
    self.lblUserIcon.layer.borderWidth = 1.0;
    
    self.lblUserIcon.backgroundColor = [UIColor clearColor];
    self.imgvUserIcon.backgroundColor = [UIColor clearColor];
    self.lblLicenseNo.backgroundColor = [UIColor clearColor];
    self.lblPhone.backgroundColor = [UIColor clearColor];
    self.lblName.backgroundColor = [UIColor clearColor];

    self.imgvUserIcon.hidden = YES;
    
    CGFloat wh = MIN(self.lblUserIcon.frame.size.height, self.lblUserIcon.frame.size.width);
    self.lblUserIcon.layer.cornerRadius = wh * 0.5;
    self.imgvUserIcon.layer.cornerRadius = wh * 0.5;
    
    self.lblUserIcon.textAlignment = NSTextAlignmentCenter;
    self.lblLicenseNo.textAlignment = NSTextAlignmentLeft;
    self.lblPhone.textAlignment = NSTextAlignmentRight;

    [self addSubview:self.viewUnderLine];
}

- (BaseView *) viewUnderLine
{
    if (_viewUnderLine == nil)
    {
        _viewUnderLine = [[BaseView alloc] initWithFrame:CGRectMake(self.contentInsets.left, self.frame.size.height - seperatorHeight_1px, self.contentWidth, seperatorHeight_1px)];
        _viewUnderLine.hidden = NO;
        _viewUnderLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _viewUnderLine.backgroundColor = [Globals shared].themingAssistant.itemCartQtyTitleColor;
    }
    return _viewUnderLine;
}

@end
