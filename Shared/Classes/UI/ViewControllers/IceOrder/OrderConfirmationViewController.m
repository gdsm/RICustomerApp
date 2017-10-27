//
//  OrderConfirmationViewController.m
//  ReddyIce
//
//  Created by Gagan on 20/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "OrderConfirmationViewController.h"
#import "TitleCell.h"
#import "NotificationInfo.h"
#import "CustomerCareView.h"
#import "NSString+Additions.h"

const CGFloat OrderConfVC_lblThanks_Height = 70;
const CGFloat OrderConfVC_lblThanksOrder_margin = 10;
const CGFloat OrderConfVC_lblThanksOrder_heightPer = 0.35;
const CGFloat OrderConfVC_lblOrderBtnView_margin = 10;
const CGFloat OrderConfVC_btnViewTable_margin = 10;
const CGFloat OrderConfVC_btnView_height = 44;
const CGFloat OrderConfVC_TableHeight = 120;

@interface OrderConfirmationViewController ()
@property (nonatomic, strong) UIBarButtonItem* bbiShare;
@property (nonatomic, strong) CustomerCareView* viewCustomerCare;
@end

@implementation OrderConfirmationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) setupUI
{
    //TODO:[GM]: Add localisation
    self.title = @"Order Confirmation";
    self.bgImgv.image = nil;
    
    self.tableView.hidden = YES;

    self.navigationItem.rightBarButtonItem = self.bbiShare;

    self.lblThanksOrder.backgroundColor = [UIColor clearColor];
    self.lblThanksOrder.font = [Globals shared].defaultTextFont;
    self.lblThanksOrder.numberOfLines = 0;
    self.lblThanksOrder.textAlignment = NSTextAlignmentJustified;
    self.lblThanksOrder.adjustsFontSizeToFitWidth = YES;
    self.lblThanksOrder.textColor = [Globals shared].themingAssistant.defaultTextColor;
    self.lblThanksOrder.text = @"Thank you for ordering with ReddyIce. You will receive an email confirmation shortly at email_id@domain.com.";
    
    self.lblOrder.backgroundColor = [UIColor clearColor];
    self.lblOrder.font = [Globals shared].defaultTextFont;
    self.lblOrder.numberOfLines = 0;
    self.lblOrder.textColor = [Globals shared].themingAssistant.defaultTextColor;
    self.lblOrder.adjustsFontSizeToFitWidth = YES;
    self.lblOrder.text = @"Order No.\r\
    123456789\r\r\
    Address\r\
    Address line 1\r\
    Address Line 2\r\
    hh:mm\r\
    Total Amount *\r\
    $ 0000:00";

    self.lblDateTime.backgroundColor = [UIColor clearColor];
    self.lblDateTime.font = [Globals shared].defaultTextFont;
    self.lblDateTime.numberOfLines = 0;
    self.lblDateTime.text = @"Order Date\r\
                            dd mmm yyyy\r\
                            hh:mm\r\
                            Expected Delivery*\r\
                            dd mmm yyyy -\r\
                            dd-mmm-yyyy.";
    self.lblDateTime.textColor = [Globals shared].themingAssistant.defaultTextColor;
    self.lblDateTime.adjustsFontSizeToFitWidth = YES;

//    self.btnViewOrder.bgNormalColor = [Globals shared].themingAssistant.blueNorm;
//    self.btnViewOrder.bgHighlightedColor = [Globals shared].themingAssistant.blueHigh;
//    self.btnViewOrder.titleNormalColor = [UIColor whiteColor];
//    self.btnViewOrder.layer.cornerRadius = cornerRadius_10px;
//    [self.btnViewOrder setTitle:@"View Ordered Items" forState:UIControlStateNormal];
    self.btnViewOrder.hidden = YES;
    
    self.btnDone.bgNormalColor = [Globals shared].themingAssistant.redNorm;
    self.btnDone.bgHighlightedColor = [Globals shared].themingAssistant.redHigh;
    self.btnDone.titleNormalColor = [UIColor whiteColor];
    self.btnDone.layer.cornerRadius = cornerRadius_10px;
    
    
    [self.view addSubview:self.viewCustomerCare];
    self.viewCustomerCare.lblInfo.text = @"For any query reach out to our customer care.\rPlease mention your order number to our customer representative to service you support quickly";
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Logical Flow Methods

- (void) shareOrderConfirmation
{
    
}

- (void) viewOrder
{
    
}

- (void) orderPlacementComplete
{
    [[NSNotificationCenter defaultCenter] postNotificationName:noti_OrderConfirmationDone object:nil userInfo:nil];
}


#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (OrderConfVC_TableHeight * 0.5);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCell* cell = [TitleCell dequeueFrom:tableView loadFromNib:@"TitleCell"];
    [cell updateCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0)
    {
        cell.lblTitle.text = @"You can always check  the status  of your order through this app in realtime.";
        cell.viewSeperator.hidden = NO;
        cell.btnInfo.hidden = YES;
    }
    else if (indexPath.row == 1)
    {
        cell.lblTitle.text = @"For any query please reach out to our customer care.";
        cell.viewSeperator.hidden = YES;
        cell.btnInfo.hidden = NO;
        [cell.btnInfo setTitle:[IconFontCodes shared].fileText forState:UIControlStateNormal];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [Globals shared].themingAssistant.whiteHigh;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}


#pragma mark - Logical Flow Methods

- (void) makeCall
{
    
}

- (void) makeMessage
{
    
}

#pragma mark - Layout Methods

- (void) layoutSubViews
{
    CGRect rect_lblThanksOrder = self.lblThanksOrder.frame;
    CGRect rect_lblOrder = self.lblOrder.frame;
    CGRect rect_lblDateTime = self.lblDateTime.frame;
    CGRect rect_btnViewOrder = self.btnViewOrder.frame;
    CGRect rect_tableView = self.tableView.frame;

    CGFloat yOffset = (self.navigationBarHeight + self.statusBarHeight + topMargin_20px);

    rect_lblThanksOrder.origin.x = leftMargin_20px;
    rect_lblThanksOrder.origin.y = yOffset;
    rect_lblThanksOrder.size.width = self.view.frame.size.width - (leftMargin_20px + rightMargin_20px);
    
    yOffset += (rect_lblThanksOrder.size.height + OrderConfVC_lblThanksOrder_margin);

    rect_lblOrder.origin.x = leftMargin_20px;
    rect_lblOrder.origin.y = yOffset;
    rect_lblOrder.size.width = (self.view.frame.size.width * 0.5) - leftMargin_20px;
    rect_lblOrder.size.height = self.view.frame.size.height * OrderConfVC_lblThanksOrder_heightPer;

    rect_lblDateTime.origin.x = self.lblOrder.frame.origin.x + self.lblOrder.frame.size.width;
    rect_lblDateTime.origin.y = yOffset;
    rect_lblDateTime.size.width = (self.view.frame.size.width * 0.5) - rightMargin_20px;
    rect_lblDateTime.size.height = self.view.frame.size.height * OrderConfVC_lblThanksOrder_heightPer;

    yOffset += (rect_lblDateTime.size.height + OrderConfVC_lblOrderBtnView_margin);

    rect_btnViewOrder.origin.x = (self.view.frame.size.width - rect_btnViewOrder.size.width) * 0.5;
    rect_btnViewOrder.origin.y = yOffset;
    rect_btnViewOrder.size.height = OrderConfVC_btnView_height;

    yOffset += (rect_btnViewOrder.size.height + OrderConfVC_btnViewTable_margin);

    rect_tableView.size.height = OrderConfVC_TableHeight;
    rect_tableView.size.width = self.view.frame.size.width - (leftMargin_20px + rightMargin_20px);
    rect_tableView.origin.x = leftMargin_20px;
    rect_tableView.origin.y = yOffset;
    
    self.lblThanksOrder.frame = rect_lblThanksOrder;
    self.lblOrder.frame = rect_lblOrder;
    self.lblDateTime.frame = rect_lblDateTime;
    self.btnViewOrder.frame = rect_btnViewOrder;
    self.tableView.frame= rect_tableView;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self layoutSubViews];
}

#pragma mark - UI Methods

- (UIBarButtonItem *)bbiShare
{
    if (_bbiShare == nil)
    {
        _bbiShare = [[UIBarButtonItem alloc] initWithTitle:[IconFontCodes shared].share style:UIBarButtonItemStylePlain target:self action:@selector(onBBIShare:)];
        [_bbiShare setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[Globals shared].bbiIconFont, NSFontAttributeName, [Globals shared].themingAssistant.defaultIconColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    }
    return _bbiShare;
}

- (CustomerCareView *)viewCustomerCare
{
    if (_viewCustomerCare == nil)
    {
        __weak OrderConfirmationViewController* weakSelf = self;
        CGFloat top = self.view.frame.size.height - (CustomerCareView_Height + bottomMargin_20px + self.btnDone.frame.size.height + bottomMargin_20px);
        CGRect rect = CGRectMake(0, top, self.view.frame.size.width, CustomerCareView_Height);
        _viewCustomerCare = [CustomerCareView instance];
        _viewCustomerCare.frame = rect;
        _viewCustomerCare.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _viewCustomerCare.backgroundColor = [UIColor clearColor];
        _viewCustomerCare.onCall = ^(id sender) {
            [weakSelf makeCall];
        };
        _viewCustomerCare.onMessage = ^(id sender) {
            [weakSelf makeMessage];
        };
        [_viewCustomerCare updateUI];
    }
    return _viewCustomerCare;
}

- (void) onBBIShare:(UIBarButtonItem *)sender
{
    [self shareOrderConfirmation];
}

- (IBAction)onBtpTap:(ColoredButton *)sender
{
    if ([sender isEqual:self.btnViewOrder])
    {
        [self viewOrder];
    }
    else if ([sender isEqual:self.btnDone])
    {
        [self orderPlacementComplete];
    }
}
@end
