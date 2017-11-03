//
//  UserManager.m
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "UserManager.h"
#import "DatabaseManager.h"
#import "Utilities.h"
#import "BlockUtils.h"
#import "CD_User.h"

@implementation UserManager

+ (UserManager *) shared
{
    __strong static UserManager * _userManager_sharedInstance = nil;
    
    static dispatch_once_t userManager_SharedDispatchOnceToken = 0;
    dispatch_once(&userManager_SharedDispatchOnceToken, ^{
        _userManager_sharedInstance = [UserManager new];
    });
    
    return _userManager_sharedInstance;
}

- (UserSummary *) createDemoUser
{
    UserSummary* user = [UserSummary new];
    user.name = @"Reddy Ice";
    user.userId = @"Reddy";
    user.password = @"ice";
    user.passcode = @"1234";
    user.userRegistrationState = UserRegistrationState_NotRegistered;
    user.userLoggedInState = UserLoggedInState_LoggedOut;
    user.additionalSecurityExpired = YES;
    
    [self saveDemoUser:user];
    
    return user;
}

- (void) saveDemoUser:(UserSummary *)user
{
    if (user == nil){
        return;
    }
    NSDictionary* dict = [user toDictionary];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"DemoUser"];
}

- (UserSummary *) getDemoUser
{
    NSDictionary* dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"DemoUser"];
    UserSummary* user = nil;
    
    if (dict == nil){
        user = [self createDemoUser];
    }
    else{
        user = [UserSummary new];
        [user updateWithDictionary:dict];
    }
    return user;
}

- (void) saveActiveUser
{
#ifdef DEV_MODE
    [self saveDemoUser:self.activeUser];
    return;
#endif
}

- (UserSummary *) activeUser
{
#ifdef DEV_MODE
    if (_activeUser == nil){
        _activeUser = [self getDemoUser];
        _activeUser.additionalSecurityExpired = YES;
    }
#endif
    if (_activeUser == nil)
    {
        NSManagedObjectContext* moc = [DatabaseManager shared].managedObjectContext;
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"CD_User" inManagedObjectContext:moc];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        
        NSError *error = nil;
        
        NSArray* finalResult = [moc executeFetchRequest:request error:&error];
        if (error != nil)
        {
            return nil;
        }
        
        for (CD_User* user in finalResult)
        {
            if (user.isActive.boolValue == YES)
            {
                _activeUser = [[UserSummary alloc] initWithUser:user];
                break;
            }
        }
    }
    
    return _activeUser;
}

- (NSString *) attempLoginForUser:(NSString *)name withPassword:(NSString *)password
{
    NSString* error = nil;
    if (name == nil)
    {
        error = @"Nil user passed";
        return error;
    }
    if (password == nil)
    {
        error = @"Nil password passed";
        return error;
    }

    NSArray<UserSummary *>* usrs = [self getAllUsers];
    
    BOOL userMatch = false;
    for (UserSummary* user in usrs)
    {
        if (([user.userId isEqualToString:name]) && ([user.password isEqualToString:password]))
        {
            user.userLoggedInState = UserLoggedInState_LoggedIn;
            userMatch = true;
            break;
        }
    }

    if (userMatch == false)
    {
        error = @"No User found";
    }

    return error;
}

- (NSMutableArray<UserSummary *>*) getAllUsers
{
    NSMutableArray<UserSummary *>* retVal = [NSMutableArray new];
#ifdef DEV_MODE
    [retVal addObject:[self getDemoUser]];
#endif
    return retVal;
}




#pragma mark - User Registration

- (NSString *) registerUserWithPhone:(UserSummary *)user
                            callback:(blk_userRegistrationCallback)callback
{
    NSString* err = nil;
    
    if (user == nil){
        err = @"NIL user passed";
        return err;
    }
    else if ((user.phoneNumber == nil) || (user.phoneNumber.length < [[Utilities shared] maxPhoneNumberDigits])){
        err = @"Invalid Phone number";
        return err;
    }
    
    [self registerUser:nil callback:^(NSDictionary* response) {
        
        if (callback != nil){
            callback(user, @"Unable to register user");
        }
    }];
    
    return err;
}


#pragma mark - Web Service Access Methods

- (void) registerUser:(NSDictionary *)userDict callback:(blk_callbackResponse)callback
{
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
        if (callback != nil){
            callback(nil);
        }
    }];
}

#pragma mark - Database Access Methods


@end
