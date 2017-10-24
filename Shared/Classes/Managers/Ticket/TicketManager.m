//
//  TicketManager.m
//  ReddyIce
//
//  Created by Gagan on 20/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "TicketManager.h"
#import "NotificationInfo.h"

@implementation TicketManager

+ (TicketManager *) shared
{
    __strong static TicketManager * _ticketManager_sharedInstance = nil;
    
    static dispatch_once_t ticketManager_SharedDispatchOnceToken = 0;
    dispatch_once(&ticketManager_SharedDispatchOnceToken, ^{
        _ticketManager_sharedInstance = [TicketManager new];
    });
    
    return _ticketManager_sharedInstance;
}

- (void) listenNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderConfirmationDone:) name:noti_OrderConfirmationDone object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(problemRequestSubmit:) name:noti_ProblemRequestSubmit object:nil];
}

- (void) removeNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:noti_OrderConfirmationDone object:nil];
}


#pragma mark - Listener Methods

- (void) orderConfirmationDone:(NSNotification *)sender
{
    // Have some core stuff later.
    [[NSNotificationCenter defaultCenter] postNotificationName:noti_ClearTicketDone object:nil userInfo:nil];
}

- (void) problemRequestSubmit:(NSNotification *)sender
{
    // Have some core stuff later.
    [[NSNotificationCenter defaultCenter] postNotificationName:noti_ClearTicketDone object:nil userInfo:nil];
}

@end
