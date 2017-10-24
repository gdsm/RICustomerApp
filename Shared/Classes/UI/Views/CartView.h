//
//  CartView.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "BlockUtils.h"

@interface CartView : BaseView

+ (CartView *) instance;
+ (void) clearInstance;

@property (nonatomic) BOOL hideBadge;
@property (nonatomic, strong) blk_actionSender onCartCallback;

@end
