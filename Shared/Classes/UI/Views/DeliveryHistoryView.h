//
//  DeliveryHistoryView.h
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "BlockUtils.h"

//TODO:[Gagan]: mode this enum to object class
typedef NS_ENUM(NSUInteger, DeliveryHistoryType) {
    DeliveryHistoryType_Order,
    DeliveryHistoryType_Delivery,
    DeliveryHistoryType_DNS
};

@interface DeliveryHistoryView : BaseView

@property (nonatomic, strong) blk_actionSender onStartPathCheck;
@property (nonatomic, strong) blk_actionSender onEndPathCheck;
@property (nonatomic) DeliveryHistoryType historyType;
@property (nonatomic) BOOL hidePathView;

@end
