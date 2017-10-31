//
//  InvoiceReceiptViewController.m
//  ReddyIce
//
//  Created by Gagan on 31/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "InvoiceReceiptViewController.h"
#import "FeedbackQuestionareViewController.h"
#import "ReportLineTemplateCell.h"
#import "ReportLineCell.h"
#import "CategoryDetailView.h"
#import "CategoryDetailButton.h"
#import "CustomerCareFeedbackView.h"

const CGFloat InvoiceReceiptVC_UserInfo_Height = 80;
const CGFloat InvoiceReceiptVC_POD_Button_Width = 100;

typedef NS_ENUM(NSUInteger, InvoiceRowType){
    InvoiceRowType_UserInfo,
    InvoiceRowType_POHeader,
    InvoiceRowType_PODetails,
    InvoiceRowType_POD,
    InvoiceRowType_TicketHeader,
    InvoiceRowType_TicketSale,
    InvoiceRowType_TicketTotal,
    InvoiceRowType_InvoiceTotal,
    InvoiceRowType_ReceivedPayment,
    InvoiceRowType_ReceiptSignature,
    InvoiceRowType_ReceiptAcknowledgement,
    InvoiceRowType_MAXCOUNT
};

@interface InvoiceReceiptViewController ()
@property (nonatomic, strong) UIBarButtonItem* bbiShare;
@property (nonatomic, strong) CustomerCareFeedbackView* viewFeedback;
@end

@implementation InvoiceReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI
{
    self.title = @"Invoice #000000001";
    self.bgImgv.image = nil;
    
    self.bottomTabView.hidden = YES;
    
    CGFloat top = (self.navigationBarHeight + self.statusBarHeight);
    CGFloat bottom = self.viewFeedback.frame.size.height + bottomMargin_20px;
    self.tableOffset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollEnabled = YES;

    self.navigationItem.rightBarButtonItem = self.bbiShare;
    self.navigationItem.leftBarButtonItem = self.bbiCancel;

    [self.view addSubview:self.viewFeedback];
}

#pragma mark - Logical Methods

- (void) shareInvoice
{
    
}

- (void) showPOD
{
    
}

- (void) shareFeedback
{
    FeedbackQuestionareViewController* view = [[FeedbackQuestionareViewController alloc] init];
    [self safePush:view animated:YES];
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return InvoiceRowType_MAXCOUNT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat retVal = 1;
    if (indexPath.row == InvoiceRowType_UserInfo)
    {
        retVal = InvoiceReceiptVC_UserInfo_Height;
    }
    else if (indexPath.row == InvoiceRowType_POHeader)
    {
        retVal = cellHeight_40px;
    }
    else if ((indexPath.row == InvoiceRowType_PODetails) || (indexPath.row == InvoiceRowType_TicketHeader) || (indexPath.row == InvoiceRowType_TicketSale) || (indexPath.row == InvoiceRowType_TicketTotal) || (indexPath.row == InvoiceRowType_InvoiceTotal) || (indexPath.row == InvoiceRowType_ReceivedPayment))
    {
        retVal = cellHeight_40px;
    }
    else if ((indexPath.row == InvoiceRowType_POD) || (indexPath.row == InvoiceRowType_ReceiptSignature) || (indexPath.row == InvoiceRowType_ReceiptAcknowledgement))
    {
        retVal = cellHeight_150px;
    }
    return retVal;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak InvoiceReceiptViewController* weakSelf = self;
    if (indexPath.row == InvoiceRowType_UserInfo)
    {
        ReportLineTemplateCell* cell = [ReportLineTemplateCell dequeueFrom:tableView loadFromNib:@"ReportLineTemplateCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat div[] = {0.3f, 0.6f};
        [cell initWithDividers:div count:3 callbackTemplate:^UIView *(NSUInteger index) {
            
            UIView* retView = nil;
            if (index == 0){
                CategoryDetailView* view = [[CategoryDetailView alloc] init];
                [view updateUI];
                view.categoryDetailStyle = CategoryDetailStyle_Vertical;
                view.category = @"Delivery";
                view.detail = @"Driver Name";
                view.contentInsets = UIEdgeInsetsZero;
                view.lblCategory.font = [Globals shared].defaultInfoFont;
                view.lblDetail.textAlignment = NSTextAlignmentLeft;
                retView = view;
            }
            else if (index == 1){
                CategoryDetailView* view = [[CategoryDetailView alloc] init];
                [view updateUI];
                view.categoryDetailStyle = CategoryDetailStyle_Vertical;
                view.category = @"MM/DD/YYYY";
                view.detail = @"Scooby Doo";
                view.contentInsets = UIEdgeInsetsZero;
                view.lblDetail.font = [Globals shared].defaultTextFont;
                view.lblDetail.textAlignment = NSTextAlignmentLeft;
                retView = view;
            }
            else if (index == 2){
                BaseLabel* lbl = [[BaseLabel alloc] init];
                [lbl defaultStyling];
                lbl.textAlignment = NSTextAlignmentRight;
                lbl.text = @"6004 N,\rSHEPHERDHOUSTON,\rTX-77091";
                retView = lbl;
            }
            return retView;
        } layoutTemplate:nil];
        return cell;
    }
    else if ((indexPath.row == InvoiceRowType_POHeader) || (indexPath.row == InvoiceRowType_PODetails))
    {
        ReportLineCell* cell = [ReportLineCell dequeueFrom:tableView loadFromNib:@"ReportLineCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.viewUnderLine.hidden = NO;
        
        CGFloat div[] = {0.25f, 0.5f, 0.75f};
        [cell initWithDividers:div count:4];
        [cell.reportLineView labelAtIndex:0].textAlignment = NSTextAlignmentLeft;
        [cell.reportLineView labelAtIndex:1].textAlignment = NSTextAlignmentCenter;
        [cell.reportLineView labelAtIndex:2].textAlignment = NSTextAlignmentCenter;
        [cell.reportLineView labelAtIndex:3].textAlignment = NSTextAlignmentRight;

        if (indexPath.row == InvoiceRowType_POHeader)
        {
            [cell.reportLineView setTitles:@"PO Required", @"Customer No.", @"Type", @"Payment Mode", nil];
        }
        else
        {
            [cell.reportLineView setTitles:@"----", @"16081", @"DSD", @"Not Entered", nil];
        }
        return cell;
    }
    else if (indexPath.row == InvoiceRowType_POD)
    {
        ReportLineTemplateCell* cell = [ReportLineTemplateCell dequeueFrom:tableView loadFromNib:@"ReportLineTemplateCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat div1 = self.tableView.frame.size.width - (viewContentInset_left + viewContentInset_right);
        div1 = (InvoiceReceiptVC_POD_Button_Width / div1);

        CGFloat div[] = {(1 - div1)};
        [cell initWithDividers:div count:2 callbackTemplate:^UIView *(NSUInteger index) {
            
            UIView* retView = nil;
            if (index == 0){
                CategoryDetailView* view = [[CategoryDetailView alloc] init];
                [view updateUI];
                view.categoryDetailStyle = CategoryDetailStyle_Vertical;
                view.category = @"Sold To:";
                view.detail = @"WHATABURGER\r#108113933 E SAM, HOUSTON PKWAY\rNHOUSTON,TX 77044";
                view.lblCategory.font = [Globals shared].defaultInfoFont;
                view.contentInsets = UIEdgeInsetsZero;
                view.lblDetail.font = [Globals shared].defaultTextFont;
                view.lblDetail.textAlignment = NSTextAlignmentLeft;
                retView = view;
            }
            else if (index == 1){
                CGRect rect = CGRectMake(0, 0, viewHeight_40px, viewHeight_40px);
                CategoryDetailButton* btn = [CategoryDetailButton instanceWithFrame:rect];
                btn.layer.borderWidth = borderWidth_1px;
                btn.layer.borderColor = [Globals shared].themingAssistant.defaultBorderColor.CGColor;
                btn.layer.cornerRadius = cornerRadius_6px;
                btn.categoryDetailView.contentInsets = UIEdgeInsetsZero;
                btn.categoryDetailView.imgCategory = @"Delivery.png";
                btn.categoryDetailView.categoryDetailStyle = CategoryDetailStyle_Vertical;
                btn.categoryDetailView.detail = @"POD";
                btn.categoryDetailView.lblDetail.textAlignment = NSTextAlignmentCenter;
                [btn addTarget:weakSelf action:@selector(showPOD) forControlEvents:UIControlEventTouchUpInside];
                retView = btn;
            }
            return retView;
        } layoutTemplate:nil];
        return cell;
    }
    else if ((indexPath.row == InvoiceRowType_TicketHeader) || (indexPath.row == InvoiceRowType_TicketSale))
    {
        ReportLineCell* cell = [ReportLineCell dequeueFrom:tableView loadFromNib:@"ReportLineCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.viewUnderLine.hidden = NO;
        
        CGFloat div[] = {0.15f, 0.45f, 0.6f, 0.8f};
        [cell initWithDividers:div count:5];
        [cell.reportLineView labelAtIndex:0].textAlignment = NSTextAlignmentLeft;
        [cell.reportLineView labelAtIndex:1].textAlignment = NSTextAlignmentCenter;
        [cell.reportLineView labelAtIndex:2].textAlignment = NSTextAlignmentCenter;
        [cell.reportLineView labelAtIndex:3].textAlignment = NSTextAlignmentCenter;
        [cell.reportLineView labelAtIndex:4].textAlignment = NSTextAlignmentRight;

        if (indexPath.row == InvoiceRowType_TicketHeader)
        {
            [cell.reportLineView setTitles:@"Code", @"Product", @"Unit Price", @"Units", @"Total Sales", nil];
        }
        else
        {
            [cell.reportLineView setTitles:@"700", @"Cube Ice", @"$10.00", @"2", @"$20.00", nil];
        }
        return cell;
    }
    else if ((indexPath.row == InvoiceRowType_TicketTotal) || (indexPath.row == InvoiceRowType_InvoiceTotal) || (indexPath.row == InvoiceRowType_ReceivedPayment))
    {
        ReportLineCell* cell = [ReportLineCell dequeueFrom:tableView loadFromNib:@"ReportLineCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.viewUnderLine.hidden = NO;
        
        CGFloat div[] = {0.8f};
        [cell initWithDividers:div count:2];
        [cell.reportLineView labelAtIndex:0].textAlignment = NSTextAlignmentRight;
        [cell.reportLineView labelAtIndex:1].textAlignment = NSTextAlignmentRight;
        
        if (indexPath.row == InvoiceRowType_TicketTotal)
        {
            [cell.reportLineView setTitles:@"Total Sales", @"$20.00", nil];
        }
        else if (indexPath.row == InvoiceRowType_InvoiceTotal)
        {
            [cell.reportLineView setTitles:@"Total Invoice", @"$20.00", nil];
        }
        else if (indexPath.row == InvoiceRowType_ReceivedPayment)
        {
            [cell.reportLineView setTitles:@"Total Payment Received", @"$0.00", nil];
        }
        return cell;
    }
    else if (indexPath.row == InvoiceRowType_ReceiptSignature)
    {
        ReportLineTemplateCell* cell = [ReportLineTemplateCell dequeueFrom:tableView loadFromNib:@"ReportLineTemplateCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.viewUnderLine.hidden = NO;
        
        CGFloat div[] = {0.75};
        [cell initWithDividers:div count:2 callbackTemplate:^UIView *(NSUInteger index) {
            
            UIView* retView = nil;
            if (index == 0){
                CategoryDetailView* view = [[CategoryDetailView alloc] init];
                [view updateUI];
                view.categoryDetailStyle = CategoryDetailStyle_Vertical;
                view.category = @"Receiver Name:";
                view.dividerRatio = 0.3;
                view.detail = @"Mr. John";
                view.lblCategory.font = [Globals shared].defaultInfoFont;
                view.lblDetail.font = [Globals shared].defaultTextFont;
                view.contentInsets = UIEdgeInsetsZero;
                view.lblDetail.textAlignment = NSTextAlignmentLeft;
                retView = view;
            }
            else if (index == 1){
                CategoryDetailView* view = [[CategoryDetailView alloc] init];
                [view updateUI];
                view.categoryDetailStyle = CategoryDetailStyle_Vertical;
                view.category = @"Customer Signature:";
                view.imgDetail = @"";
                view.lblCategory.font = [Globals shared].defaultInfoFont;
                view.lblCategory.textAlignment = NSTextAlignmentRight;
                view.lblDetail.font = [Globals shared].defaultTextFont;
                view.contentInsets = UIEdgeInsetsZero;
                retView = view;
            }
            return retView;
        } layoutTemplate:nil];
        return cell;
    }
    else if (indexPath.row == InvoiceRowType_ReceiptAcknowledgement)
    {
        ReportLineTemplateCell* cell = [ReportLineTemplateCell dequeueFrom:tableView loadFromNib:@"ReportLineTemplateCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.viewUnderLine.hidden = NO;
        
        CGFloat div[] = {0.5};
        [cell initWithDividers:div count:2 callbackTemplate:^UIView *(NSUInteger index) {
            
            UIView* retView = nil;
            if (index == 0){
                CategoryDetailView* view = [[CategoryDetailView alloc] init];
                [view updateUI];
                view.categoryDetailStyle = CategoryDetailStyle_Vertical;
                view.dividerRatio = 0.2;
                view.category = @"ACH Payment";
                view.detail = @"Account No. 635 943 483,Routing Number: 111 000 614";
                view.lblCategory.font = [Globals shared].boldTextFont;
                view.lblDetail.font = [Globals shared].defaultInfoFont;
                view.contentInsets = UIEdgeInsetsZero;
                view.lblCategory.textAlignment = NSTextAlignmentLeft;
                view.lblDetail.textAlignment = NSTextAlignmentLeft;
                retView = view;
            }
            else if (index == 1){
                CategoryDetailView* view = [[CategoryDetailView alloc] init];
                [view updateUI];
                view.categoryDetailStyle = CategoryDetailStyle_Vertical;
                view.dividerRatio = 0.2;
                view.category = @"Remittance Address";
                view.detail = @"Reddy Ice Corporation,P.O. Box 730505,Dallas, TX 75373 – 0505";
                view.lblCategory.font = [Globals shared].boldTextFont;
                view.lblDetail.font = [Globals shared].defaultInfoFont;
                view.contentInsets = UIEdgeInsetsZero;
                view.lblCategory.textAlignment = NSTextAlignmentRight;
                view.lblDetail.textAlignment = NSTextAlignmentRight;
                retView = view;
            }
            return retView;
        } layoutTemplate:nil];
        return cell;
    }

    BaseTableViewCell* cell = [BaseTableViewCell blankCell];
    return cell;
}

#pragma mark - Layout Methods

#pragma mark - UI Methods

- (CustomerCareFeedbackView *) viewFeedback
{
    if (_viewFeedback == nil)
    {
        __weak InvoiceReceiptViewController* weakSelf = self;
        CGFloat top = self.view.frame.size.height - (viewHeight_150px + bottomMargin_20px);
        CGRect rect = CGRectMake(0, top, self.view.frame.size.width, viewHeight_150px);
        _viewFeedback = [CustomerCareFeedbackView instance];
        _viewFeedback.frame = rect;
        _viewFeedback.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _viewFeedback.backgroundColor = [UIColor clearColor];
        _viewFeedback.onFeedback = ^(id sender) {
            [weakSelf shareFeedback];
        };
        [_viewFeedback updateUI];
    }
    return _viewFeedback;
}

- (UIBarButtonItem *)bbiShare
{
    if (_bbiShare == nil)
    {
        _bbiShare = [[UIBarButtonItem alloc] initWithTitle:[IconFontCodes shared].share style:UIBarButtonItemStylePlain target:self action:@selector(onBBIShare:)];
        [_bbiShare setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[Globals shared].bbiIconFont, NSFontAttributeName, [Globals shared].themingAssistant.defaultIconColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    }
    return _bbiShare;
}

- (void) onBBIShare:(UIBarButtonItem *)sender
{
    [self shareInvoice];
}

@end
