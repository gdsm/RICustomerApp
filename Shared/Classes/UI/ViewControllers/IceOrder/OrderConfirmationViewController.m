//
//  OrderConfirmationViewController.m
//  ReddyIce
//
//  Created by Gagan on 20/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "OrderConfirmationViewController.h"
#import "ReportLineCell.h"
#import "NotificationInfo.h"
#import "CustomerCareView.h"
#import "CategoryDetailView.h"
#import "NSString+Additions.h"

const CGFloat OrderConfVC_TableHeight = 120;

@interface OrderConfirmationViewController ()

@property (weak, nonatomic) IBOutlet BaseLabel *lblTitle;
@property (weak, nonatomic) IBOutlet ColoredButton *btnDone;
@property (weak, nonatomic) IBOutlet CategoryDetailView *viewOrderNo;
@property (weak, nonatomic) IBOutlet CategoryDetailView *viewOrderDate;
@property (weak, nonatomic) IBOutlet CategoryDetailView *viewEarliestDate;
@property (weak, nonatomic) IBOutlet CategoryDetailView *viewLatestDate;
@property (weak, nonatomic) IBOutlet CategoryDetailView *viewDeliveryAddress;

- (IBAction)onBtpTap:(ColoredButton *)sender;

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
    
    self.tableView.hidden = NO;

    self.navigationItem.rightBarButtonItem = self.bbiShare;

    [self.lblTitle defaultStyling];
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    self.lblTitle.text = @"Thank you for ordering with ReddyIce.";
    
    UIEdgeInsets inset = UIEdgeInsetsMake(topMargin_5px, leftMargin_20px, bottomMargin_5px, rightMargin_20px);
    
    self.viewOrderNo.categoryDetailStyle = CategoryDetailStyle_Vertical;
    [self.viewOrderNo updateUI];
    self.viewOrderNo.category = @"Order No.";
    self.viewOrderNo.lblCategory.textAlignment = NSTextAlignmentLeft;
    self.viewOrderNo.lblCategory.font = [Globals shared].defaultInfoFont;
    self.viewOrderNo.detail = @"123456780";
    self.viewOrderNo.lblDetail.font = [Globals shared].defaultTextFont;
    self.viewOrderNo.lblDetail.textAlignment = NSTextAlignmentLeft;
    self.viewOrderNo.contentInsets = inset;

    self.viewOrderDate.categoryDetailStyle = CategoryDetailStyle_Vertical;
    [self.viewOrderDate updateUI];
    self.viewOrderDate.category = @"Order Date";
    self.viewOrderDate.lblCategory.textAlignment = NSTextAlignmentRight;
    self.viewOrderDate.lblCategory.font = [Globals shared].defaultInfoFont;
    self.viewOrderDate.detail = @"MM/DD/YYYY";
    self.viewOrderDate.lblDetail.font = [Globals shared].defaultTextFont;
    self.viewOrderDate.lblDetail.textAlignment = NSTextAlignmentRight;
    self.viewOrderDate.contentInsets = inset;

    self.viewEarliestDate.categoryDetailStyle = CategoryDetailStyle_Vertical;
    [self.viewEarliestDate updateUI];
    self.viewEarliestDate.category = @"Earliest service date";
    self.viewEarliestDate.lblCategory.textAlignment = NSTextAlignmentLeft;
    self.viewEarliestDate.lblCategory.font = [Globals shared].defaultInfoFont;
    self.viewEarliestDate.detail = @"MM/DD/YYYY";
    self.viewEarliestDate.lblDetail.font = [Globals shared].defaultTextFont;
    self.viewEarliestDate.lblDetail.textAlignment = NSTextAlignmentLeft;
    self.viewEarliestDate.contentInsets = inset;

    self.viewLatestDate.categoryDetailStyle = CategoryDetailStyle_Vertical;
    [self.viewLatestDate updateUI];
    self.viewLatestDate.category = @"Latest service date";
    self.viewLatestDate.lblCategory.textAlignment = NSTextAlignmentRight;
    self.viewLatestDate.lblCategory.font = [Globals shared].defaultInfoFont;
    self.viewLatestDate.detail = @"MM/DD/YYYY";
    self.viewLatestDate.lblDetail.font = [Globals shared].defaultTextFont;
    self.viewLatestDate.lblDetail.textAlignment = NSTextAlignmentRight;
    self.viewLatestDate.contentInsets = inset;

    self.viewDeliveryAddress.categoryDetailStyle = CategoryDetailStyle_Vertical;
    [self.viewDeliveryAddress updateUI];
    self.viewDeliveryAddress.category = @"Delivery to";
    self.viewDeliveryAddress.lblCategory.textAlignment = NSTextAlignmentLeft;
    self.viewDeliveryAddress.lblCategory.font = [Globals shared].defaultInfoFont;
    self.viewDeliveryAddress.detail = @"WHATABURGER\r#108113933 E SAM, HOUSTON PKWAY\rNHOUSTON,TX 77044";
    self.viewDeliveryAddress.lblDetail.font = [Globals shared].defaultTextFont;
    self.viewDeliveryAddress.lblDetail.textAlignment = NSTextAlignmentLeft;
    self.viewDeliveryAddress.contentInsets = inset;

    self.btnDone.coloredButtonType = ColoredButtonType_Blue;
    self.btnDone.titleNormalColor = [UIColor whiteColor];
    self.btnDone.layer.cornerRadius = cornerRadius_10px;
    
    self.viewOrderNo.backgroundColor = [UIColor clearColor];
    self.viewOrderDate.backgroundColor = [UIColor clearColor];
    self.viewEarliestDate.backgroundColor = [UIColor clearColor];
    self.viewLatestDate.backgroundColor = [UIColor clearColor];
    self.viewDeliveryAddress.backgroundColor = [UIColor clearColor];

    [self.view addSubview:self.viewCustomerCare];
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setEquipmentRepair:(BOOL)equipmentRepair
{
    _equipmentRepair = equipmentRepair;
    self.tableView.hidden = equipmentRepair;
    
    if (equipmentRepair == YES)
    {
        self.viewOrderNo.category = @"Work Order No.";
        self.viewOrderDate.category = @"Work Order Date";
    }
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
    return cellHeight_60px;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReportLineCell* cell = [ReportLineCell dequeueFrom:tableView loadFromNib:@"ReportLineCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat div[] = {0.6};
    
    [cell initWithDividers:div count:2];
    [cell.reportLineView labelAtIndex:0].textAlignment = NSTextAlignmentLeft;
    [cell.reportLineView labelAtIndex:0].font = [Globals shared].defaultTextFont;
    [cell.reportLineView labelAtIndex:0].textColor = [Globals shared].themingAssistant.defaultTextColor;

    [cell.reportLineView labelAtIndex:1].textAlignment = NSTextAlignmentRight;
    [cell.reportLineView labelAtIndex:1].font = [Globals shared].defaultTextFont;
    [cell.reportLineView labelAtIndex:1].textColor = [Globals shared].themingAssistant.defaultTextColor;

//    [cell.reportLineView labelAtIndex:2].textAlignment = NSTextAlignmentRight;
//    [cell.reportLineView labelAtIndex:2].font = [Globals shared].defaultTextFont;
//    [cell.reportLineView labelAtIndex:2].textColor = [Globals shared].themingAssistant.defaultTextColor;
//
//    [cell.reportLineView labelAtIndex:3].textAlignment = NSTextAlignmentRight;
//    [cell.reportLineView labelAtIndex:3].font = [Globals shared].defaultTextFont;
//    [cell.reportLineView labelAtIndex:3].textColor = [Globals shared].themingAssistant.defaultTextColor;
    
    cell.viewUnderLine.hidden = NO;

    [cell updateCell];

    if (indexPath.row == 0)
    {
        [cell.reportLineView setTitles:@"Products",@"Qty", nil];
    }
    else
    {
        [cell.reportLineView setTitles:@"Product Name",@"99", nil];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    CGRect rect_lblTitle = self.lblTitle.frame;
    CGRect rect_viewOrderNo = self.viewOrderNo.frame;
    CGRect rect_viewOrderDate = self.viewOrderDate.frame;
    CGRect rect_viewEarliestDate = self.viewEarliestDate.frame;
    CGRect rect_viewLatestDate = self.viewLatestDate.frame;
    CGRect rect_viewDelivery = self.viewDeliveryAddress.frame;
    CGRect rect_tableView = self.tableView.frame;

    CGFloat yOffset = (self.navigationBarHeight + self.statusBarHeight + topMargin_20px);

    rect_lblTitle.origin.x = leftMargin_20px;
    rect_lblTitle.origin.y = yOffset;
    rect_lblTitle.size.width = self.view.frame.size.width - (leftMargin_20px + rightMargin_20px);
    
    yOffset += (rect_lblTitle.size.height + bottomMargin_10px);

    rect_viewOrderNo.origin.x = 0;
    rect_viewOrderNo.origin.y = yOffset;
    rect_viewOrderNo.size.width = (self.view.frame.size.width * 0.5);

    rect_viewOrderDate.origin.x = rect_viewOrderNo.origin.x + rect_viewOrderNo.size.width;
    rect_viewOrderDate.origin.y = yOffset;
    rect_viewOrderDate.size.width = rect_viewOrderNo.size.width;

    yOffset += (rect_viewOrderNo.size.height);

    rect_viewEarliestDate.origin.x = 0;
    rect_viewEarliestDate.origin.y = yOffset;
    rect_viewEarliestDate.size.width = (self.view.frame.size.width * 0.5);
    
    rect_viewLatestDate.origin.x = rect_viewEarliestDate.origin.x + rect_viewEarliestDate.size.width;
    rect_viewLatestDate.origin.y = yOffset;
    rect_viewLatestDate.size.width = rect_viewOrderNo.size.width;
    
    yOffset += (rect_viewEarliestDate.size.height);

    rect_viewDelivery.origin.x = 0;
    rect_viewDelivery.origin.y = yOffset;
    rect_viewDelivery.size.width = self.view.frame.size.width;
    
    yOffset += (rect_viewDelivery.size.height);

    rect_tableView.origin.x = 0;
    rect_tableView.origin.y = yOffset;
    rect_tableView.size.height = self.viewCustomerCare.frame.origin.y - yOffset;
    rect_tableView.size.width = self.view.frame.size.width;
    
    self.lblTitle.frame = rect_lblTitle;
    self.viewOrderNo.frame = rect_viewOrderNo;
    self.viewOrderDate.frame = rect_viewOrderDate;
    self.viewEarliestDate.frame = rect_viewEarliestDate;
    self.viewLatestDate.frame = rect_viewLatestDate;
    self.viewDeliveryAddress.frame = rect_viewDelivery;
    self.tableView.frame = rect_tableView;
    
    
    [self.viewOrderNo layoutUI];
    [self.viewOrderDate layoutUI];
    [self.viewEarliestDate layoutUI];
    [self.viewLatestDate layoutUI];
    [self.viewDeliveryAddress layoutUI];
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
        CGFloat top = self.view.frame.size.height - (viewHeight_150px + bottomMargin_10px + self.btnDone.frame.size.height + bottomMargin_10px);
        CGRect rect = CGRectMake(0, top, self.view.frame.size.width, viewHeight_150px);
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
    if ([sender isEqual:self.btnDone])
    {
        [self orderPlacementComplete];
    }
}
@end
