//
//  ChangePasswordModelObject.h
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CoreObject.h"


@interface ChangePasswordModelObject : CoreObject

/// @brief Keys to be used in dicionary
@property (nonatomic, strong) NSMutableArray* allKeys;
/// @brief Keys to be display in UI
- (NSString *) displayValueForKey:(NSString *)key;

@property (nonatomic, strong) NSString* existingPassword;
@property (nonatomic, strong) NSString* latestPassword; // new password . New cannobe be prefix in keywords
@property (nonatomic, strong) NSString* confirmPassword;

@end
