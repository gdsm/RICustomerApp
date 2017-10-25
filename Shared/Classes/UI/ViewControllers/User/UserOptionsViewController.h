//
//  UserOptionsViewController.h
//  ReddyIce
//
//  Created by Gagan on 25/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BlockUtils.h"

@interface UserOptionsViewController : BaseTableViewController

@property (nonatomic, strong) blk_completion callbackMyProfile;
@property (nonatomic, strong) blk_completion callbackLogout;
@property (nonatomic, strong) blk_completion callbackChangePassword;

@end
