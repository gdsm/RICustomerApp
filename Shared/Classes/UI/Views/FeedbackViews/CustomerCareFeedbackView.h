//
//  CustomerCareFeedbackView.h
//  ReddyIce
//
//  Created by Gagan on 31/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "ColoredButton.h"
#import "BlockUtils.h"

@interface CustomerCareFeedbackView : BaseView

+ (CustomerCareFeedbackView *) instance;

@property (weak, nonatomic) IBOutlet ColoredButton *btnFeedback;
@property (weak, nonatomic) IBOutlet BaseLabel *lblInfo;
@property (nonatomic) blk_actionSender onFeedback;

@end
