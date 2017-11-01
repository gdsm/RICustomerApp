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

- (void) createDemoUser
{
    NSString* demoUserId = @"DemoUserId";
    
    NSFetchRequest *request = nil;
    CD_User *user = (CD_User *)[[DatabaseManager shared] newOrExistingEntity:demoUserId ofType:@"CD_User" predicateFormat:@"(userId == %@)" reuseRequest:&request];
    
    user.name = @"Reddy";
    user.password = @"ice";
    user.userId = demoUserId;
    user.passcode = @"1234";
    user.isActive = @1;

    [[DatabaseManager shared] saveChanges];
}

- (UserSummary *) activeUser
{
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
    
    NSManagedObjectContext* moc = [DatabaseManager shared].managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CD_User" inManagedObjectContext:moc];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSError *err = nil;
    
    NSArray* finalResult = [moc executeFetchRequest:request error:&err];
    if (err != nil)
    {
        error = err.localizedDescription;
        return error;
    }
    
    BOOL userMatch = false;
    for (CD_User* user in finalResult)
    {
        if (([user.name isEqualToString:name]) && ([user.password isEqualToString:password]))
        {
            user.isActive = @1;
            [[DatabaseManager shared] saveChanges];
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
