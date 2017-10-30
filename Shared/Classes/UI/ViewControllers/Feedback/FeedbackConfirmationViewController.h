//
//  ConfirmationViewController.h
//  ReddyIce
//
//  Created by Gagan on 27/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BlockUtils.h"

@interface FeedbackConfirmationViewController : BaseTableViewController

- (void) setNavTitle:(NSString *)navTitle title:(NSString *)title description:(NSString *)description;
@property (nonatomic) CGFloat matrixHeight;
@property (nonatomic, strong) blk_completion onDone;

@end
