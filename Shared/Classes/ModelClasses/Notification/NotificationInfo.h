//
//  NotificationInfo.h
//  ReddyIce
//
//  Created by Gagan on 20/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CoreObject.h"

extern NSString* const noti_OrderConfirmationDone;
extern NSString* const noti_ProblemRequestSubmit;
extern NSString* const noti_FeedbackRequestSubmit;
extern NSString* const noti_ClearTicketDone;

@interface NotificationInfo : CoreObject

@property (nonatomic, strong) NSNumber* ticketWorkFlow;
@property (nonatomic, strong) NSNumber* ticketType;

@end
