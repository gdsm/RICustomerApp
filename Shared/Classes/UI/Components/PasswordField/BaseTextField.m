//
//  BaseTextField.m
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTextField.h"
#import "Globals.h"
#import "Utilities.h"

@implementation BaseTextField

- (void) defaultStyling
{
    self.textColor = [Globals shared].themingAssistant.defaultTextColor;
    self.font = [[Globals shared] defaultTextFont];
}

- (void) phoneNumberMode
{
    self.numerOfCharacters = [[Utilities shared] maxPhoneNumberDigits];
    self.textFieldMode = TextFieldMode_PhoneNumber;
}

@end
