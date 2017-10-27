//
//  BaseTextField.m
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTextField.h"
#import "Globals.h"

@implementation BaseTextField

- (void) defaultStyling
{
    self.textColor = [Globals shared].themingAssistant.defaultTextColor;
    self.font = [[Globals shared] defaultTextFont];
}

@end
