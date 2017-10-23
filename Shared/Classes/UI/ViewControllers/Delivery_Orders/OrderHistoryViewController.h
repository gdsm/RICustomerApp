//
//  OrderHistoryViewController.h
//  ReddyIce
//
//  Created by Gagan on 21/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewController.h"

@interface OrderHistoryViewController : BaseTableViewController

@property (nonatomic) BOOL detailHistory;
@property (nonatomic, strong) blk_actionIndexPath onOrderTap;
@property (nonatomic, strong) blk_completion onCancel;

@end
