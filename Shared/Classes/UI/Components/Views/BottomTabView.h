//
//  BottomTabView.h
//  ReddyIce
//
//  Created by Gagan on 13/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "BlockUtils.h"
#import "BottomTabButton.h"

@interface BottomTabView : BaseView

- (void) unselectBottomTabs;

@property (nonatomic, strong) BottomTabButton* btnHome;
@property (nonatomic, strong) BottomTabButton* btnPlaceOrder;
@property (nonatomic, strong) BottomTabButton* btnDeliveryHistory;
@property (nonatomic, strong) BottomTabButton* btnReportAProb;
@property (nonatomic, strong) BottomTabButton* btnShareFeedback;

@property (nonatomic, strong) blk_actionSender callbackHome;
@property (nonatomic, strong) blk_actionSender callbackPlaceOrder;
@property (nonatomic, strong) blk_actionSender callbackDeliveryHistory;
@property (nonatomic, strong) blk_actionSender callbackShareFeedback;
@property (nonatomic, strong) blk_actionSender callbackReportAProblem;

@end
