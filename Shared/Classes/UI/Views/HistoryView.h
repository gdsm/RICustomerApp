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
    HistoryType_DNS,
    HistoryType_RequestHistory
};

@interface HistoryView : BaseView

@property (nonatomic, strong) BaseLabel* lblOrderNo;
@property (nonatomic, strong) BaseLabel* lblTotalAmount;
@property (nonatomic, strong) BaseLabel* lblStatus;
@property (nonatomic, strong) BaseLabel* lblStartTime;
@property (nonatomic, strong) BaseLabel* lblEndTime;
@property (nonatomic, strong) BaseView* viewUnderLine;

@property (nonatomic, strong) blk_actionSender onStartPathCheck;
@property (nonatomic, strong) blk_actionSender onEndPathCheck;
@property (nonatomic) HistoryType historyType;
@property (nonatomic) BOOL hidePathView;

@end
