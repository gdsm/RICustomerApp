//
//  CreateServiceRequestView.h
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "BlockUtils.h"

@interface CreateServiceRequestView : BaseView

@property (nonatomic, strong) blk_actionSender onCreateRequest;

@end
