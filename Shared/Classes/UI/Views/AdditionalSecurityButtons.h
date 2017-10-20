//
//  AdditionalSecurityButtons.h
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColoredButton.h"
#import "BaseView.h"
#import "BlockUtils.h"

extern const CGFloat additionalSecurityButtons_width;

@interface AdditionalSecurityButtons : BaseView

@property (strong, nonatomic) ColoredButton* btnPasscode;
@property (strong, nonatomic) ColoredButton* btnFingure;

@property (nonatomic, strong) blk_completion onPassCode;
@property (nonatomic, strong) blk_completion onFingureScan;

@end
