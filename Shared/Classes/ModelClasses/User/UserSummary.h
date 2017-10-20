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

@interface UserSummary : CoreObject

- (UserSummary *) initWithUser:(CD_User *)user;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* passcode;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* userId;
@property (nonatomic, strong) NSNumber* isActive;
@property (nonatomic, strong) NSNumber* touchIdValidated;

@property (nonatomic) BOOL hasAdditionalSecurity;
@property (nonatomic) UserAdditionalSecurityType userSecurityType;

@end
