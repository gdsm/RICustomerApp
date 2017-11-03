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
#import "NotificationInfo.h"
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

- (id) init
{
    self = [super init];
    if (self != nil)
    {
        [self listenNotifications];
    }
    return self;
}

- (void)dealloc
{
    [self removeNotifications];
}



#pragma mark - Listeners

- (void) listenNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onUpdateUserLoggedInState:)
                                                 name:noti_UpdateUserLoggedInState
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onUpdateUserRegistrationInState:)
                                                 name:noti_UpdateUserRegistrationState
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onUpdateUserAdditionalSecurity:)
                                                 name:noti_UpdateUserAdditionalSecurity
                                               object:nil];
}

- (void) removeNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:noti_UpdateUserLoggedInState
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:noti_UpdateUserRegistrationState
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:noti_UpdateUserAdditionalSecurity
                                                  object:nil];
}

- (void) onUpdateUserLoggedInState:(NSNotification *)sender
{
    NSDictionary* userInfo = [sender userInfo];
    NotificationInfo* info = [NotificationInfo new];
    [info updateWithDictionary:userInfo];
    
    self.activeUser.userLoggedInState = [info.userLoggedInState integerValue];
    if (self.activeUser.userLoggedInState == UserLoggedInState_LoggedIn)
    {
        self.activeUser.additionalSecurityExpired = NO;
    }
    [self saveActiveUser];
}

- (void) onUpdateUserRegistrationInState:(NSNotification *)sender
{
    NSDictionary* userInfo = [sender userInfo];
    NotificationInfo* info = [NotificationInfo new];
    [info updateWithDictionary:userInfo];
    
    self.activeUser.userRegistrationState = [info.userRegistrationState integerValue];
    
    switch (self.activeUser.userRegistrationState)
    {
        case UserRegistrationState_Registered:{
            self.activeUser.userLoggedInState = UserLoggedInState_LoggedOut;
        }break;
        case UserRegistrationState_NotRegistered:{
            self.activeUser.userLoggedInState = UserLoggedInState_LoggedOut;
            self.activeUser.additionalSecurityExpired = YES;
        }break;
        case UserRegistrationState_Unknown:{
        }break;
    }

    [self saveActiveUser];
}

- (void) onUpdateUserAdditionalSecurity:(NSNotification *)sender
{
    NSDictionary* userInfo = [sender userInfo];
    NotificationInfo* info = [NotificationInfo new];
    [info updateWithDictionary:userInfo];
    
    self.activeUser.additionalSecurityExpired = info.userAdditionalSecurity;
    [self saveActiveUser];
}


#pragma makr - Active User

- (UserSummary *) activeUser
{
    if ([Utilities demoMode])
    {
        if (_activeUser == nil)
        {
            _activeUser = [self getDemoUser];
            _activeUser.additionalSecurityExpired = YES;
        }
        return _activeUser;
    }
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

// MARK: Active User - Private
- (void) saveActiveUser
{
    if ([Utilities demoMode])
    {
        [self saveDemoUser:self.activeUser];
        return;
    }
}



#pragma mark - Registration & Login

- (NSString *) attempLoginForUser:(NSString *)name
                     withPassword:(NSString *)password
{
    NSString* error = nil;
    if (name == nil){
        error = @"Nil user passed";
        return error;
    }
    if (password == nil){
        error = @"Nil password passed";
        return error;
    }
    
    NSArray<UserSummary *>* usrs = [self getAllUsers];
    
    BOOL userMatch = false;
    for (UserSummary* user in usrs){
        if (([user.userId isEqualToString:name]) && ([user.password isEqualToString:password])){
            user.userLoggedInState = UserLoggedInState_LoggedIn;
            userMatch = true;
            break;
        }
    }
    
    if (userMatch == false){
        error = @"No User found";
    }
    
    return error;
}

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

// MARK: Registration & Login
- (NSMutableArray<UserSummary *>*) getAllUsers
{
    NSMutableArray<UserSummary *>* retVal = [NSMutableArray new];
    if ([Utilities demoMode])
    {
        [retVal addObject:[self getDemoUser]];
        return retVal;
    }
    return retVal;
}



#pragma mark - Demo User

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
