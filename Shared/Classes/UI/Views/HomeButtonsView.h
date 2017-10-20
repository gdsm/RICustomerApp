//
//  HomeButtonsView.h
//  ReddyIce
//
//  Created by Gagan on 12/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "BlockUtils.h"

extern const CGFloat HomeButtonView_TopMargin;
extern const CGFloat HomeButtonView_BottomMargin;
extern const CGFloat HomeButtonView_VinnerMargin;
extern const CGFloat HomeButtonView_HinnerMargin;

@interface HomeButtonsView : BaseView

- (CGSize) estimatedSize;

@property (nonatomic, strong) blk_actionSender callbackPlaceOrder;
@property (nonatomic, strong) blk_actionSender callbackDeliveryHistory;
@property (nonatomic, strong) blk_actionSender callbackShareFeedback;
@property (nonatomic, strong) blk_actionSender callbackReportAProblem;

@end
