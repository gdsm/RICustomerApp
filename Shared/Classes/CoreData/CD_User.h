//
//  CD_User.h
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface CD_User : NSManagedObject

@property (nonatomic, retain, nonnull) NSString* name;
@property (nonatomic, retain, nullable) NSString* passcode;
@property (nonatomic, retain, nonnull) NSString* password;
@property (nonatomic, retain, nonnull) NSString* userId;
@property (nonatomic, retain, nonnull) NSNumber* isActive;
@property (nonatomic, retain, nullable) NSNumber* touchIdValidated;

@end
