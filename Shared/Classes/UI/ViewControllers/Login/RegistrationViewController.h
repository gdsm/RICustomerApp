//
//  RegistrationViewController.h
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BlockUtils.h"

@interface RegistrationViewController : BaseTableViewController

@property (nonatomic, strong) blk_completion onLogin;
@property (nonatomic, strong) blk_completion onSuccessfulRegistration;

@end
