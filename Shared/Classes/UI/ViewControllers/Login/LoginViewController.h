//
//  LandingViewController.h
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

@property (nonatomic, strong) blk_completion onSuccessfullLogin;
@property (nonatomic, strong) blk_completion onNewRegistration;

@end
