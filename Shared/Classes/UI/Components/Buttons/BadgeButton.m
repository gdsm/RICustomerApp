//
//  BadgeButton.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BadgeButton.h"

const CGFloat BadgeButton_BadgeSize = 15;


@implementation BadgeButton

- (void) setIconTitle:(NSString *)iconTitle
{
    _iconTitle = iconTitle;
    [self setTitle:iconTitle forState:UIControlStateNormal];
    self.titleLabel.font = [Globals shared].bbiIconFont;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setBadgeNumber:(NSUInteger)badgeNumber
{
    self.lblBadge.text = [NSString stringWithFormat:@"%lu", (unsigned long)badgeNumber];
}

- (void)setHideBadge:(BOOL)hideBadge
{
    self.lblBadge.hidden = hideBadge;
}

- (UILabel *) lblBadge
{
    if (_lblBadge == nil)
    {
        CGRect rect = CGRectMake(self.frame.size.width - BadgeButton_BadgeSize, 0, BadgeButton_BadgeSize, BadgeButton_BadgeSize);
        _lblBadge = [[UILabel alloc] initWithFrame:rect];
        _lblBadge.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        _lblBadge.font = [Globals shared].badgeFont;
        _lblBadge.text = @"0";
        _lblBadge.backgroundColor = [Globals shared].themingAssistant.redNorm;
        _lblBadge.clipsToBounds = YES;
        _lblBadge.textColor = [UIColor whiteColor];
        _lblBadge.adjustsFontSizeToFitWidth = YES;
        _lblBadge.textAlignment = NSTextAlignmentCenter;
        _lblBadge.layer.cornerRadius = BadgeButton_BadgeSize * 0.5;
        
        [self insertSubview:_lblBadge aboveSubview:self.titleLabel];
    }
    return _lblBadge;
}
@end
