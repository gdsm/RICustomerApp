//
//  DeliveryHistoryViewController.h
//  ReddyIce
//
//  Created by Gagan on 21/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewController.h"

@interface DeliveryHistoryViewController : BaseTableViewController

@property (nonatomic) BOOL detailHistory;
@property (nonatomic, strong) blk_actionIndexPath onDeliveryTap;
@property (nonatomic, strong) blk_completion onCancel;

@end
