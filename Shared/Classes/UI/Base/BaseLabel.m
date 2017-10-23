//
//  BaseLabel.m
//  ReddyIce
//
//  Created by Gagan on 20/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseLabel.h"
#import "Globals.h"

@implementation BaseLabel

- (void) defaultIconFont
{
    self.font = [Globals shared].defaultIconFont;
    self.textColor = [Globals shared].themingAssistant.defaultIconColor;
}

- (void) defaultTextFont
{
    self.font = [Globals shared].defaultTextFont;
    self.textColor = [Globals shared].themingAssistant.defaultTextColor;
}



@end
