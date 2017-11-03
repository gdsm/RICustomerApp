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
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary* retVal = [NSMutableDictionary new];
    
    if (_name != nil){
        [retVal setObject:_name forKey:@"name"];
    }
    if (_emailId != nil){
        [retVal setObject:_emailId forKey:@"emailId"];
    }
    if (_phoneNumber != nil){
        [retVal setObject:_phoneNumber forKey:@"phoneNumber"];
    }
    if (_userId != nil){
        [retVal setObject:_userId forKey:@"userId"];
    }
    if (_accountId != nil){
        [retVal setObject:_accountId forKey:@"accountId"];
    }
    if (_passcode != nil){
        [retVal setObject:_passcode forKey:@"passcode"];
    }
    if (_password != nil){
        [retVal setObject:_password forKey:@"password"];
    }
    if (_touchIdValidated != nil){
        [retVal setObject:_touchIdValidated forKey:@"touchIdValidated"];
    }

    [retVal setObject:self.obj_additionalSecurityExpired forKey:@"additionalSecurityExpired"];
    [retVal setObject:self.obj_userRegistrationState forKey:@"userRegistrationState"];
    [retVal setObject:self.obj_userLoggedInState forKey:@"userLoggedInState"];
    [retVal setObject:self.obj_userSecurityType forKey:@"userSecurityType"];

    return retVal;
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
    self.name = [dictionary objectForKey:@"name"];
    self.emailId = [dictionary objectForKey:@"emailId"];
    self.phoneNumber = [dictionary objectForKey:@"phoneNumber"];
    self.userId = [dictionary objectForKey:@"userId"];
    self.accountId = [dictionary objectForKey:@"accountId"];
    self.passcode = [dictionary objectForKey:@"passcode"];
    self.password = [dictionary objectForKey:@"password"];
    self.touchIdValidated = [dictionary objectForKey:@"touchIdValidated"];
    
    self.obj_userRegistrationState = [dictionary objectForKey:@"userRegistrationState"];
    self.obj_userLoggedInState = [dictionary objectForKey:@"userLoggedInState"];
    self.obj_additionalSecurityExpired = [dictionary objectForKey:@"additionalSecurityExpired"];
    self.obj_userSecurityType = [dictionary objectForKey:@"userSecurityType"];
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








- (NSNumber *) obj_userSecurityType
{
    return [NSNumber numberWithInteger:self.userSecurityType];
}

- (void) setObj_userSecurityType:(NSNumber *)obj_userSecurityType
{
    self.userSecurityType = [obj_userSecurityType integerValue];
}

- (NSNumber *) obj_userLoggedInState
{
    return [NSNumber numberWithInteger:self.userLoggedInState];
}

- (void) setObj_userLoggedInState:(NSNumber *)obj_userLoggedInState
{
    self.userLoggedInState = [obj_userLoggedInState integerValue];
}

- (NSNumber *) obj_userRegistrationState
{
    return [NSNumber numberWithInteger:self.userRegistrationState];
}

- (void) setObj_userRegistrationState:(NSNumber *)obj_userRegistrationState
{
    self.userRegistrationState = [obj_userRegistrationState integerValue];
}

- (NSNumber *) obj_additionalSecurityExpired
{
    return [NSNumber numberWithInteger:self.additionalSecurityExpired];
}

- (void) setObj_additionalSecurityExpired:(NSNumber *)obj_additionalSecurityExpired
{
    self.additionalSecurityExpired = [obj_additionalSecurityExpired boolValue];
}

@end
