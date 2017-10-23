//
//  OrderHistoryViewController.m
//  ReddyIce
//
//  Created by Gagan on 21/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "OrderHistoryViewController.h"
#import "DeliveryOrderViewController.h"
#import "OrderViewController.h"
#import "ReportLineCell.h"
#import "DeliveryHistoryCell.h"
#import "TicketLineItemHeaderCell.h"
#import "TicketLineItemCell.h"
#import "CategoryDetailCell.h"

const CGFloat OrderHisVC_AmountCell_Height = 60;

@interface OrderHistoryViewController ()
@property (nonatomic, strong) UIBarButtonItem* bbiShare;
@property (nonatomic, strong) UIBarButtonItem* bbiCancel;
@property (nonatomic, strong) NSMutableArray* lineItems;
@end

@implementation OrderHistoryViewController

#pragma mark - View Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) setupUI
{
    //TODO:[GM]: Add localisation
    self.title = @"#Order : 0000000001";

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

- (void)didReceiveMemoryWarning
{
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

- (void) startPathChecked
{
    
}

- (void) endPathChecked
{
    
}


#pragma mark - TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger retVal = 1;
    if (self.detailHistory)
    {
        retVal = 3;
    }
    return retVal;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger retVal = 0;
    if (self.detailHistory)
    {
        if (section == 1)
        {
            retVal = self.lineItems.count + 1;
        }
        else if (section == 2)
        {
            retVal = 2;
        }
        else
        {
            retVal = 1;
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
        if (indexPath.section == 0)
        {
            height = DeliveryOrderVC_OrderCell_Height;
        }
        else if (indexPath.section == 1)
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
        else if (indexPath.section == 2)
        {
            height = OrderHisVC_AmountCell_Height;
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
            height = DeliveryOrderVC_OrderCell_Height;
        }
    }
    return height;
}

- (UITableViewCell *) cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    __weak OrderHistoryViewController* weakSelf = self;
    if (indexPath.row == 0)
    {
        ReportLineCell* cell = [ReportLineCell dequeueFrom:tableView loadFromNib:@"ReportLineCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat div[] = {0.3f, 0.7f};
        [cell initWithDividers:div count:3];
        [cell.reportLineView setTitles:@"Order No.", @"Total Amount", @"Status", nil];
        [cell.reportLineView labelAtIndex:0].textAlignment = NSTextAlignmentLeft;
        [cell.reportLineView labelAtIndex:1].textAlignment = NSTextAlignmentCenter;
        [cell.reportLineView labelAtIndex:2].textAlignment = NSTextAlignmentRight;
        
        return cell;
    }
    else
    {
        DeliveryHistoryCell* cell = [DeliveryHistoryCell dequeueFrom:tableView loadFromNib:@"DeliveryHistoryCell"];

        UIEdgeInsets inset = cell.deliveryHistoryView.contentInsets;
        inset.left = 0;
        inset.right = 0;
        cell.deliveryHistoryView.contentInsets = inset;

        [cell updateCell];
        cell.deliveryHistoryView.historyType = DeliveryHistoryType_Order;
        cell.deliveryHistoryView.onStartPathCheck = ^(id sender) {
            [weakSelf startPathChecked];
        };
        cell.deliveryHistoryView.onEndPathCheck = ^(id sender) {
            [weakSelf endPathChecked];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}

- (UITableViewCell *) detailHistoryCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    __weak OrderHistoryViewController* weakSelf = self;
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            DeliveryHistoryCell* cell = [DeliveryHistoryCell dequeueFrom:tableView loadFromNib:@"DeliveryHistoryCell"];
            [cell updateCell];
            cell.deliveryHistoryView.historyType = DeliveryHistoryType_Order;
            cell.deliveryHistoryView.onStartPathCheck = ^(id sender) {
                [weakSelf startPathChecked];
            };
            cell.deliveryHistoryView.onEndPathCheck = ^(id sender) {
                [weakSelf endPathChecked];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    else if (indexPath.section == 1)
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
    else if (indexPath.section == 2)
    {
        CategoryDetailCell* cell = [CategoryDetailCell dequeueFrom:tableView loadFromNib:@"CategoryDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCell];
        cell.categoryDetailView.viewUnderLine.hidden = NO;
        if (indexPath.row == 0)
        {
            cell.categoryDetailView.lblDetail.font = [Globals shared].checkoutTotalFont;
            cell.category = @"Total Amount";
            cell.detail = @"$0.00";
        }
        else
        {
            [cell.categoryDetailView.lblDetail defaultIconFont];
            cell.category = @"For any query please reach out to our customer care";
            cell.detail = [IconFontCodes shared].comment_text;
            cell.categoryDetailView.dividerRatio = 0.8;
        }
        return cell;
    }

    return nil;
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
    if ((self.onOrderTap != nil) && (self.detailHistory == false))
    {
        self.onOrderTap(indexPath);
    }
}


#pragma mark - UI Methods

- (UIBarButtonItem *)bbiCancel
{
    if (_bbiCancel == nil)
    {
        _bbiCancel = [[UIBarButtonItem alloc] initWithTitle:@"X" style:UIBarButtonItemStylePlain target:self action:@selector(onBBICancel:)];
        [_bbiCancel setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[Globals shared].boldTextFont, NSFontAttributeName, [Globals shared].themingAssistant.defaultIconColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    }
    return _bbiCancel;
}

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
