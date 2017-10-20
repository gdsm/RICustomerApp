//
//  CheckoutView.h
//  ReddyIce
//
//  Created by Gagan on 16/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "BlockUtils.h"

extern const CGFloat checkoutViewHeight;

@interface CheckoutView : BaseView

@property (nonatomic, strong) NSString* checkoutTitle;
@property (nonatomic, strong) blk_actionSender onCheckout;

@end
