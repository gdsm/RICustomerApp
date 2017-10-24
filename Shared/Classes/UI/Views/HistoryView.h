//
//  HistoryView.h
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "BlockUtils.h"

//TODO:[Gagan]: mode this enum to object class
typedef NS_ENUM(NSUInteger, HistoryType) {
    HistoryType_Order,
    HistoryType_Delivery,
    HistoryType_DNS
};

@interface HistoryView : BaseView

@property (nonatomic, strong) blk_actionSender onStartPathCheck;
@property (nonatomic, strong) blk_actionSender onEndPathCheck;
@property (nonatomic) HistoryType historyType;
@property (nonatomic) BOOL hidePathView;

@end
