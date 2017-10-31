//
//  CustomerCareView.h
//  ReddyIce
//
//  Created by Gagan on 25/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "ColoredButton.h"
#import "BlockUtils.h"

@interface CustomerCareView : BaseView

+ (CustomerCareView *) instance;

@property (weak, nonatomic) IBOutlet ColoredButton *btnCall;
@property (weak, nonatomic) IBOutlet ColoredButton *btnMessage;
@property (weak, nonatomic) IBOutlet BaseLabel *lblInfo;

@property (nonatomic) blk_actionSender onMessage;
@property (nonatomic) blk_actionSender onCall;
@end
