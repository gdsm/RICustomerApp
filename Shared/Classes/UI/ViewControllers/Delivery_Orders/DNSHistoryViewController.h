//
//  DNSHistoryViewController.h
//  ReddyIce
//
//  Created by Gagan on 21/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewController.h"

@interface DNSHistoryViewController : BaseTableViewController

@property (nonatomic) BOOL detailHistory;
@property (nonatomic, strong) blk_actionIndexPath onDNSTap;
@property (nonatomic, strong) blk_completion onCancel;

@end
