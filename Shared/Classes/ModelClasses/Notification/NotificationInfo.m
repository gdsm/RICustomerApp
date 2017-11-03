//
//  NotificationInfo.m
//  ReddyIce
//
//  Created by Gagan on 20/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "NotificationInfo.h"

NSString* const noti_OrderConfirmationDone = @"OrderConfirmationDone";
NSString* const noti_ProblemRequestSubmit = @"ProblemRequestSubmit";
NSString* const noti_FeedbackRequestSubmit = @"FeedbackRequestSubmit";
NSString* const noti_ClearTicketDone = @"ClearTicketDone";

NSString* const noti_UpdateUserLoggedInState = @"UpdateUserLoggedInState";
NSString* const noti_UpdateUserRegistrationState = @"UpdateUserRegistrationState";
NSString* const noti_UpdateUserAdditionalSecurity = @"UpdateUserAdditionalSecurity";


@implementation NotificationInfo

- (NSDictionary *)toDictionary
{
    NSMutableDictionary* retVal = [NSMutableDictionary new];
    
    if (self.ticketType != nil){
        [retVal setObject:self.ticketType forKey:@"ticketType"];
    }
    if (self.ticketWorkFlow != nil){
        [retVal setObject:self.ticketWorkFlow forKey:@"ticketWorkFlow"];
    }
    if (self.userRegistrationState != nil){
        [retVal setObject:self.userRegistrationState forKey:@"userRegistrationState"];
    }
    if (self.userLoggedInState != nil){
        [retVal setObject:self.userLoggedInState forKey:@"userLoggedInState"];
    }
    if (self.userRegistrationState != nil){
        [retVal setObject:self.userRegistrationState forKey:@"userRegistrationState"];
    }

    return retVal;
}

- (void) updateWithDictionary:(NSDictionary *)dictionary
{
    if (dictionary == nil){
        return;
    }
    
    self.ticketType = [dictionary objectForKey:@"ticketType"];
    self.ticketWorkFlow = [dictionary objectForKey:@"ticketWorkFlow"];
    self.userLoggedInState = [dictionary objectForKey:@"userLoggedInState"];
    self.userRegistrationState = [dictionary objectForKey:@"userRegistrationState"];
}

@end
