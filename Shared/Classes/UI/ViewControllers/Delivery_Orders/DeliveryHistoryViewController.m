//
//  DeliveryHistoryViewController.m
//  ReddyIce
//
//  Created by Gagan on 21/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "DeliveryHistoryViewController.h"
#import "DeliveryOrderViewController.h"
#import "OrderViewController.h"
#import "ReportLineCell.h"
#import "HistoryCell.h"
#import "TicketLineItemHeaderCell.h"
#import "ReportLineTemplateCell.h"
#import "TicketLineItemCell.h"
#import "CategoryDetailCell.h"
#import "DriverInfoCell.h"

const CGFloat DeliveryHisVC_AmountCell_Height = 60;
const CGFloat DeliveryHisVC_OrderCell_Height = 60;
const CGFloat DeliveryHisVC_InvoiceCell_Height = 60;
const CGFloat DeliveryHisVC_DriverDetCell_Height = 80;
const CGFloat DeliveryHisVC_FeedbackCell_Height = 60;

typedef NS_ENUM(NSUInteger, DeliveryHistorySections)
{
    DeliveryHistorySections_Delivery,
    DeliveryHistorySections_Order,
    DeliveryHistorySections_Invoice_POD,
    DeliveryHistorySections_DriverDetail,
    DeliveryHistorySections_Feedback,
    DeliveryHistorySections_Items,
    DeliveryHistorySections_TaxTotalQuerries,
    DeliveryHistorySections_MAXCOUNT
};

@interface DeliveryHistoryViewController ()
@property (nonatomic, strong) UIBarButtonItem* bbiShare;
@property (nonatomic, strong) NSMutableArray* lineItems;
@end


@implementation DeliveryHistoryViewController

#pragma mark - View Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) setupUI
{
    self.title = @"#Invoice : 0000000001";
    
    if (self.detailHistory)
    {
        self.bgImgv.image = nil;
        
        self.navigationItem.leftBarButtonItem = self.bbiCancel;
        self.navigationItem.rightBarButtonItem = self.bbiShare;
        
        CGFloat top = (self.navigationBarHeight + self.statusBarHeight);
        self.tableOffset = UIEdgeInsetsMake(top, 0, 0, 0);
        self.tableView.scrollEnabled = YES;
    }
    else
    {
        self.bgImgv.image = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)lineItems
{
    if (_lineItems == nil)
    {
        _lineItems = [NSMutableArray new];
        [_lineItems addObject:@"1"];
        [_lineItems addObject:@"2"];
    }
    return _lineItems;
}

#pragma mark - Logical Flow Methods

- (void) makeSelectedPayments
{
    
}

#pragma mark - TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger retVal = 1;
    if (self.detailHistory)
    {
        retVal = DeliveryHistorySections_MAXCOUNT;
    }
    return retVal;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger retVal = 0;
    if (self.detailHistory)
    {
        if (section == DeliveryHistorySections_Delivery)
        {
            retVal = 1;
        }
        else if (section == DeliveryHistorySections_Order)
        {
            retVal = 1;
        }
        else if (section == DeliveryHistorySections_Invoice_POD)
        {
            retVal = 1;
        }
        else if (section == DeliveryHistorySections_DriverDetail)
        {
            retVal = 1;
        }
        else if (section == DeliveryHistorySections_Feedback)
        {
            retVal = 1;
        }
        else if (section == DeliveryHistorySections_Items)
        {
            retVal = 1 + self.lineItems.count;
        }
        else if (section == DeliveryHistorySections_TaxTotalQuerries)
        {
            retVal = 3;
        }
    }
    else
    {
        retVal = 4;
    }
    return retVal;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 1;
    if (self.detailHistory)
    {
        if (indexPath.section == DeliveryHistorySections_Delivery)
        {
            height = DeliveryOrderVC_OrderCell_Height;
        }
        else if (indexPath.section == DeliveryHistorySections_Order)
        {
            height = DeliveryHisVC_OrderCell_Height;
        }
        else if (indexPath.section == DeliveryHistorySections_Invoice_POD)
        {
            height = DeliveryHisVC_InvoiceCell_Height;
        }
        else if (indexPath.section == DeliveryHistorySections_DriverDetail)
        {
            height = DeliveryHisVC_DriverDetCell_Height;
        }
        else if (indexPath.section == DeliveryHistorySections_Feedback)
        {
            height = DeliveryHisVC_FeedbackCell_Height;
        }
        else if (indexPath.section == DeliveryHistorySections_Items)
        {
            if (indexPath.row == 0)
            {
                height = TicketVC_lineHeaderCell_height;
            }
            else
            {
                height = TicketVC_lineCell_height;
            }
        }
        else if (indexPath.section == DeliveryHistorySections_TaxTotalQuerries)
        {
            height = DeliveryHisVC_AmountCell_Height;
        }
    }
    else
    {
        if (indexPath.row == 0)
        {
            height = DeliveryOrderVC_HeaderCell_Height;
        }
        else
        {
            height = cellHeight_60px;
        }
    }
    return height;
}

- (UITableViewCell *) cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    __weak DeliveryHistoryViewController* weakSelf = self;
    CGFloat div1 = self.tableView.frame.size.width - (viewContentInset_left + viewContentInset_right);
    div1 = (cellHeight_40px / div1);

    if (indexPath.row == 0)
    {
        ReportLineCell* cell = [ReportLineCell dequeueFrom:tableView loadFromNib:@"ReportLineCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.viewUnderLine.hidden = NO;
        
        CGFloat div[] = {div1, 0.35f, 0.6f, 0.85f};
        [cell initWithDividers:div count:5];
        [cell.reportLineView setTitles:@"", @"Invoice No.", @"Delivery Date", @"Amount", @"Payment", nil];
        [cell.reportLineView labelAtIndex:1].textAlignment = NSTextAlignmentLeft;
        [cell.reportLineView labelAtIndex:2].textAlignment = NSTextAlignmentCenter;
        [cell.reportLineView labelAtIndex:3].textAlignment = NSTextAlignmentCenter;
        [cell.reportLineView labelAtIndex:4].textAlignment = NSTextAlignmentRight;
        
        return cell;
    }
    else
    {
        ReportLineTemplateCell* cell = [ReportLineTemplateCell dequeueFrom:tableView loadFromNib:@"ReportLineTemplateCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.viewUnderLine.hidden = NO;
        
        CGFloat div[] = {div1, 0.35f, 0.6f, 0.85f};
        [cell initWithDividers:div count:5 callbackTemplate:^UIView *(NSUInteger index) {
            
            UIView* retView = nil;
            if (index == 0){
                CGRect rect = CGRectMake(0, 0 , checkboxSize, checkboxSize);
                CheckBox* cb = [[CheckBox alloc] initWithFrame:rect];
                [cb updateUI];
                UIEdgeInsets inset = cb.contentInsets;
                inset.left = 0;
                cb.contentInsets = inset;
                cb.onCheckboxCallback = ^(id sender) {
                    [weakSelf makeSelectedPayments];;
                };
                retView = cb;
            }
            else if (index == 1){
                BaseLabel* lbl = [[BaseLabel alloc] init];
                [lbl defaultStyling];
                lbl.text = @"1234567";
                retView = lbl;
            }
            else if (index == 2){
                BaseLabel* lbl = [[BaseLabel alloc] init];
                [lbl defaultStyling];
                lbl.textAlignment = NSTextAlignmentCenter;
                lbl.text = @"MM/DD/YYYY";
                retView = lbl;
            }
            else if (index == 3){
                BaseLabel* lbl = [[BaseLabel alloc] init];
                [lbl defaultStyling];
                lbl.textAlignment = NSTextAlignmentCenter;
                lbl.text = @"$00.00";
                retView = lbl;
            }
            else if (index == 4){
                BaseLabel* lbl = [[BaseLabel alloc] init];
                [lbl iconStyling];
                lbl.text = [IconFontCodes shared].money;
                retView = lbl;
            }
            return retView;
        } layoutTemplate:nil];
        return cell;
    }
    
    return nil;
}

- (UITableViewCell *) detailHistoryCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == DeliveryHistorySections_Delivery)
    {
        if (indexPath.row == 0)
        {
            HistoryCell* cell = [HistoryCell dequeueFrom:tableView loadFromNib:@"HistoryCell"];
            [cell updateCell];
            cell.historyView.historyType = HistoryType_Delivery;
            cell.historyView.hidePathView = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    else if (indexPath.section == DeliveryHistorySections_Order)
    {
        CategoryDetailCell* cell = [CategoryDetailCell dequeueFrom:tableView loadFromNib:@"CategoryDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCell];
        cell.categoryDetailView.viewUnderLine.hidden = NO;
        cell.category = @"Orders";
        cell.detail = @"Implementation Pending. Constructing a Button Grid UI Structure.";
        return cell;
    }
    else if (indexPath.section == DeliveryHistorySections_Invoice_POD)
    {
        CategoryDetailCell* cell = [CategoryDetailCell dequeueFrom:tableView loadFromNib:@"CategoryDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCell];
        cell.categoryDetailView.viewUnderLine.hidden = NO;
        cell.category = @"Invoice";
        cell.detail = @"Implementation Pending. Constructing a Button Grid UI Structure.";
        return cell;
    }
    else if (indexPath.section == DeliveryHistorySections_DriverDetail)
    {
        DriverInfoCell* cell = [DriverInfoCell dequeueFrom:tableView loadFromNib:@"DriverInfoCell"];
        [cell updateCell];
        return cell;
    }
    else if (indexPath.section == DeliveryHistorySections_Feedback)
    {
        CategoryDetailCell* cell = [CategoryDetailCell dequeueFrom:tableView loadFromNib:@"CategoryDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCell];
        [cell.categoryDetailView.lblCategory defaultIconFont];
        cell.detail = @"We love to hear your feedback, it helps us to serve you better.";
        cell.categoryDetailView.lblDetail.textAlignment = NSTextAlignmentLeft;
        cell.category = [IconFontCodes shared].comment_text;
        cell.categoryDetailView.dividerRatio = 0.1;
        cell.categoryDetailView.viewUnderLine.hidden = NO;
        return cell;
    }
    else if (indexPath.section == DeliveryHistorySections_Items)
    {
        if (indexPath.row == 0)
        {
            TicketLineItemHeaderCell* cell = [TicketLineItemHeaderCell dequeueFrom:tableView loadFromNib:@"TicketLineItemHeaderCell"];
            [cell updateCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else
        {
            TicketLineItemCell* cell = [TicketLineItemCell dequeueFrom:tableView loadFromNib:@"TicketLineItemCell"];
            [cell updateCell];
            cell.lineItemView.checkbox.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    else if (indexPath.section == DeliveryHistorySections_TaxTotalQuerries)
    {
        CategoryDetailCell* cell = [CategoryDetailCell dequeueFrom:tableView loadFromNib:@"CategoryDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCell];
        if (indexPath.row == 0)
        {
            //TAX
            cell.category = @"Tax @00%";
            cell.detail = @"$0.00";
        }
        else if (indexPath.row == 1)
        {
            //TOTAL
            cell.categoryDetailView.lblDetail.font = [Globals shared].checkoutTotalFont;
            cell.category = @"Total Amount";
            cell.detail = @"$0.00";
            cell.categoryDetailView.viewUnderLine.hidden = NO;
        }
        else if (indexPath.row == 2)
        {
            //Querries
            [cell.categoryDetailView.lblDetail defaultIconFont];
            cell.category = @"For any query please reach out to our customer care";
            cell.detail = [IconFontCodes shared].comment_text;
            cell.categoryDetailView.dividerRatio = 0.8;
        }
        return cell;
    }
    
    BaseTableViewCell* cell = [BaseTableViewCell blankCell];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.detailHistory)
    {
        UITableViewCell* cell = [self detailHistoryCellForTableView:tableView indexPath:indexPath];
        return cell;
    }
    else
    {
        UITableViewCell* cell = [self cellForTableView:tableView indexPath:indexPath];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((self.onDeliveryTap != nil) && (self.detailHistory == false))
    {
        self.onDeliveryTap(indexPath);
    }
}

#pragma mark - UI Methods

- (void) onBBICancel:(UIBarButtonItem *)sender
{
    if (self.onCancel != nil)
    {
        self.onCancel();
    }
}

- (void) onBBIShare:(UIBarButtonItem *)sender
{
    
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

@end


















/*
 
 Old code


- (UITableViewCell *) cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        ReportLineCell* cell = [ReportLineCell dequeueFrom:tableView loadFromNib:@"ReportLineCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat div[] = {0.5f};
        [cell initWithDividers:div count:2];
        [cell.reportLineView setTitles:@"Invoice No.", @"Total Amount", nil];
        [cell.reportLineView labelAtIndex:0].textAlignment = NSTextAlignmentLeft;
        [cell.reportLineView labelAtIndex:1].textAlignment = NSTextAlignmentRight;
        
        return cell;
    }
    else
    {
        HistoryCell* cell = [HistoryCell dequeueFrom:tableView loadFromNib:@"HistoryCell"];
        
        UIEdgeInsets inset = cell.historyView.contentInsets;
        inset.left = 0;
        inset.right = 0;
        cell.historyView.contentInsets = inset;
        
        [cell updateCell];
        cell.historyView.historyType = HistoryType_Delivery;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}
*/
