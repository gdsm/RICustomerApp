//
//  UINavigationBar+Additions.m
//  ReddyIce
//
//  Created by Gagan on 31/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "UINavigationBar+Additions.h"
#import "Globals.h"

@implementation UINavigationBar (Additions)

- (void)setBottomBorderColor:(UIColor *)color height:(CGFloat)height
{
    CGRect bottomBorderRect = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), height);
    UIView *bottomBorder = [[UIView alloc] initWithFrame:bottomBorderRect];
    [bottomBorder setBackgroundColor:color];
    [self addSubview:bottomBorder];
}

- (void) whiteTheme
{
    
}

- (void) blueTheme
{
    self.barTintColor = [Globals shared].themingAssistant.navBarBlueThemeBgColor;
    [self setBottomBorderColor:[Globals shared].themingAssistant.navBarBlueThemeBorderColor height:borderWidth_1px];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[Globals shared].themingAssistant.navBarBlueThemeTextColor}];
    self.tintColor = [Globals shared].themingAssistant.navBarBlueThemeTextColor;
}

@end
