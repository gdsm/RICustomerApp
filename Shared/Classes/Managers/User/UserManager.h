//
//  UserManager.h
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserSummary.h"

typedef void (^blk_userRegistrationCallback)(UserSummary* user, NSString* error);

@interface UserManager : NSObject

+ (UserManager *) shared;

@property (nonatomic, strong) UserSummary* activeUser;

- (void) createDemoUser;
- (NSString *) registerUserWithPhone:(UserSummary *)user callback:(blk_userRegistrationCallback)callback;
- (NSString *) attempLoginForUser:(NSString *)user withPassword:(NSString *)password;
@end
