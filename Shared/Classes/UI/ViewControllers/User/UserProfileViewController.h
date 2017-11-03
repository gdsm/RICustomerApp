//
//  UserProfileViewController.h
//  ReddyIce
//
//  Created by Gagan on 25/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BlockUtils.h"

@interface UserProfileViewController : BaseTableViewController

@property (nonatomic) BOOL isNewUser;
@property (nonatomic, strong) blk_completion onRegistrationComplete;

@end
