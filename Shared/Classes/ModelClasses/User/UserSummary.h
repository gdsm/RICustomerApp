//
//  UserSummary.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CoreObject.h"
#import "CD_User.h"

typedef NS_ENUM(NSUInteger, UserAdditionalSecurityType){
    UserAdditionalSecurityType_NoSecurity,
    UserAdditionalSecurityType_Passcode,
    UserAdditionalSecurityType_Fingure
};

typedef NS_ENUM(NSUInteger, UserRegistrationState){
    UserRegistrationState_Unknown,
    UserRegistrationState_NotRegistered,
    UserRegistrationState_Registered,
};

typedef NS_ENUM(NSUInteger, UserLoggedInState){
    UserLoggedInState_Unknown,
    UserLoggedInState_LoggedOut,
    UserLoggedInState_LoggedIn
};

@interface UserSummary : CoreObject

- (UserSummary *) initWithUser:(CD_User *)user;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* emailId;
@property (nonatomic, strong) NSString* phoneNumber;
@property (nonatomic, strong) NSString* userId;
@property (nonatomic, strong) NSString* accountId;

@property (nonatomic) UserRegistrationState userRegistrationState;
@property (nonatomic) UserLoggedInState userLoggedInState;
@property (nonatomic) BOOL additionalSecurityExpired;

@property (nonatomic, strong) NSString* passcode;
@property (nonatomic, strong) NSString* password;

@property (nonatomic, strong) NSNumber* touchIdValidated;

@property (nonatomic) BOOL hasAdditionalSecurity;
@property (nonatomic) UserAdditionalSecurityType userSecurityType;

@property (nonatomic, weak) NSNumber* obj_userRegistrationState;
@property (nonatomic, weak) NSNumber* obj_userLoggedInState;
@property (nonatomic, weak) NSNumber* obj_additionalSecurityExpired;
@property (nonatomic, weak) NSNumber* obj_userSecurityType;

@end
