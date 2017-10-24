//
//  OrderViewController.m
//  ReddyIce
//
//  Created by Gagan on 18/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderConfirmationViewController.h"
#import "CheckoutView.h"
#import "TicketLineItemCell.h"
#import "TicketLineItemHeaderCell.h"
#import "DeliveryTimelineView.h"


const CGFloat TicketVC_lineHeaderCell_height = 60;
const CGFloat TicketVC_lineCell_height = 150;
const CGFloat TicketVC_deliveryView_height = 60;


@interface OrderViewController ()
@property (nonatomic, strong) CheckoutView* checkoutView;
@property (nonatomic, strong) DeliveryTimelineView* deliveryTimeLineView;
@property (nonatomic, strong) UIBarButtonItem* bbiCancel;
@end

@implementation OrderViewController


#pragma mark - Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) setupUI
{
    //TODO:[GM]: Add localisation
    self.title = @"Order Preview";
    self.bgImgv.image = nil;
    
    CGFloat top = (self.navigationBarHeight + self.statusBarHeight);
    CGFloat bottom = self.bottomTabView.frame.size.height + self.checkoutView.frame.size.height;
    self.tableOffset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollEnabled = NO;
    
    self.bottomTabView.hidden = NO;
    
    self.navigationItem.rightBarButtonItem = self.bbiCancel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Logical Flow

- (void) placeOrder
{
    OrderConfirmationViewController* view = [[OrderConfirmationViewController alloc] initWithNibName:@"OrderConfirmationViewController" bundle:nil];
    [self safePresent:view onSelf:NO animated:YES callbackCompletion:nil];
}

- (void) clearTicket
{
    
}


#pragma mark - TableViewMethods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    __weak TicketViewController* weakSelf = self;
    if (indexPath.row == 0)
    {
        TicketLineItemHeaderCell* cell = [TicketLineItemHeaderCell dequeueFrom:tableView loadFromNib:@"TicketLineItemHeaderCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 1)
    {
        TicketLineItemCell* cell = [TicketLineItemCell dequeueFrom:tableView loadFromNib:@"TicketLineItemCell"];
        [cell updateCell];
        cell.lineItemView.checkbox.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    BaseTableViewCell* cell = [BaseTableViewCell blankCell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat retVal = 1;
    if (indexPath.row == 0)
    {
        retVal = TicketVC_lineHeaderCell_height;
    }
    else if (indexPath.row == 1)
    {
        retVal = TicketVC_lineCell_height;
    }
    return retVal;
}


#pragma mark - Layout Methods

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect rect_checkoutView = self.checkoutView.frame;
    CGRect rect_deliveryView = self.deliveryTimeLineView.frame;

    rect_checkoutView.origin.x = 0;
    rect_checkoutView.origin.y = self.view.frame.size.height - (self.bottomTabView.frame.size.height + rect_checkoutView.size.height);
    rect_checkoutView.size.width = self.view.frame.size.width;
    
    self.checkoutView.frame = rect_checkoutView;
    self.deliveryTimeLineView.frame = rect_deliveryView;

    [self.checkoutView layoutUI];
}

#pragma mark - UI Methods

- (CheckoutView *) checkoutView
{
    if (_checkoutView == nil)
    {
        __weak OrderViewController* weakSelf = self;
        
        CGRect rect = CGRectMake(0, self.view.frame.size.height - checkoutViewHeight, self.view.frame.size.width, checkoutViewHeight);
        _checkoutView = [[CheckoutView alloc] initWithFrame:rect];
        _checkoutView.checkoutTitle = @"Place Order";
        _checkoutView.onCheckout = ^(id sender) {
            [weakSelf placeOrder];
        };
        [self.view addSubview:_checkoutView];
    }
    return _checkoutView;
}

- (DeliveryTimelineView *)deliveryTimeLineView
{
    if (_deliveryTimeLineView == nil)
    {
        CGFloat top = (self.navigationBarHeight + self.statusBarHeight);

        CGRect rect = CGRectMake(0, top, self.view.frame.size.width, TicketVC_deliveryView_height);
        _deliveryTimeLineView = [[DeliveryTimelineView alloc] initWithFrame:rect];
        _deliveryTimeLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [_deliveryTimeLineView updateUI];
        [self.view addSubview:_deliveryTimeLineView];
    }
    return _deliveryTimeLineView;
}

- (UIBarButtonItem *) bbiCancel
{
    if (_bbiCancel == nil)
    {
        _bbiCancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onbbiCancel:)];
    }
    return _bbiCancel;
}

- (void) onbbiCancel:(UIBarButtonItem *)sender
{
    [self clearTicket];
}

@end
