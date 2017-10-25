//
//  QuickOrderView.h
//  ReddyIce
//
//  Created by Gagan on 25/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "ColoredButton.h"
#import "BlockUtils.h"

extern const CGFloat QuickOrderViewHeight;
extern const CGFloat QuickOrderViewTopMargin;


@interface QuickOrderView : BaseView

@property (nonatomic, strong) blk_actionSender onQuickCheckout;
@property (nonatomic, strong) ColoredButton* btnQuickOrder;
@property (nonatomic, strong) BaseLabel* lblInfo;
@property (nonatomic) CGFloat contentMargin;

@end
