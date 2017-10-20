//
//  UserManager.h
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserSummary.h"

@interface UserManager : NSObject

+ (UserManager *) shared;

@property (nonatomic, strong) UserSummary* activeUser;

- (void) createDemoUser;
- (NSString *) attempLoginForUser:(NSString *)user withPassword:(NSString *)password;
@end
