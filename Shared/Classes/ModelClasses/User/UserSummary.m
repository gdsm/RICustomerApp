//
//  UserSummary.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "UserSummary.h"

@implementation UserSummary

- (UserSummary *) initWithUser:(CD_User *)user
{
    self = [super init];
    if (self != nil)
    {
        [self copyUser:user];
    }
    return self;
}

- (void) copyUser:(CD_User *)user
{
    self.name = user.name;
    self.passcode = user.passcode;
    self.password = user.password;
    self.userId = user.userId;
    self.isActive = user.isActive;
    self.touchIdValidated = user.touchIdValidated;
}

- (UserAdditionalSecurityType) userSecurityType
{
    UserAdditionalSecurityType type = UserAdditionalSecurityType_NoSecurity;
    if (self.touchIdValidated != nil)
    {
        type = UserAdditionalSecurityType_Fingure;
    }
    else if (self.passcode != nil)
    {
        type = UserAdditionalSecurityType_Passcode;
    }
    return type;
}

- (BOOL) hasAdditionalSecurity
{
    BOOL retVal = NO;
    if ((self.password != nil) || (self.touchIdValidated != nil))
    {
        retVal = YES;
    }
    return retVal;
}

@end
