//
//  OrderConfirmationViewController.h
//  ReddyIce
//
//  Created by Gagan on 20/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewController.h"

@interface OrderConfirmationViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet UILabel *lblThanksOrder;
@property (weak, nonatomic) IBOutlet UILabel *lblOrder;
@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;
@property (weak, nonatomic) IBOutlet ColoredButton *btnViewOrder;
- (IBAction)onBtpTap:(ColoredButton *)sender;
@property (weak, nonatomic) IBOutlet ColoredButton *btnDone;

@end
