//
//  TicketEnums.h
//  ReddyIce
//
//  Created by Gagan on 20/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#ifndef TicketEnums_h
#define TicketEnums_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TicketWorkFlow)
{
    TicketWorkFlow_NotStarted = 1000,
    TicketWorkFlow_Processing,
    TicketWorkFlow_PlaceOrder,
    TicketWorkFlow_Completed
};

#endif /* TicketEnums_h */
