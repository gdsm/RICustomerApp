//
//  BadgeButton.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ColoredButton.h"

@interface BadgeButton : ColoredButton

@property (nonatomic, strong) UILabel* lblBadge;
@property (nonatomic, strong) NSString* iconTitle;
@property (nonatomic) NSUInteger badgeNumber;
@property (nonatomic) BOOL hideBadge;

@end
