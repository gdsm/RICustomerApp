//
//  TicketViewController.m
//  ReddyIce
//
//  Created by Gagan on 18/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "TicketViewController.h"
#import "OrderConfirmationViewController.h"
#import "OrderViewController.h"
#import "CheckoutView.h"
#import "TicketLineItemCell.h"
#import "TicketLineItemHeaderCell.h"


@interface TicketViewController ()
@property (nonatomic, strong) CheckoutView* checkoutView;
@property (nonatomic, strong) UIBarButtonItem* bbiClear;
@end

@implementation TicketViewController


#pragma mark - Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) setupUI
{
    //TODO:[GM]: Add localisation
    self.title = @"Cart Items";
    self.bgImgv.image = nil;
    
    CGFloat top = (self.navigationBarHeight + self.statusBarHeight);
    CGFloat bottom = self.bottomTabView.frame.size.height + self.checkoutView.frame.size.height;
    self.tableOffset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    self.navigationItem.rightBarButtonItem = self.bbiClear;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.bottomTabView.hidden = NO;
}

#pragma mark - Logical Flow

- (void) clearTicket
{
    
}

- (void) confirmOrder
{
    OrderConfirmationViewController* view = [[OrderConfirmationViewController alloc] initWithNibName:@"OrderConfirmationViewController" bundle:nil];
    [self safePresent:view onSelf:NO animated:YES callbackCompletion:nil];

    //    OrderViewController* view = [[OrderViewController alloc] init];
//    [self safePush:view animated:YES];
}

- (void) refreshTicket
{
    
}

- (void) itemSelectedInTicket
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

        UIEdgeInsets inset = cell.lineItemHeaderView.contentInsets;
        inset.left = viewContentInset_left + TLI_checkBoxImage_margin + checkboxSize;
        cell.lineItemHeaderView.contentInsets = inset;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 1)
    {
        TicketLineItemCell* cell = [TicketLineItemCell dequeueFrom:tableView loadFromNib:@"TicketLineItemCell"];

        [cell updateCell];

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
    else
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
    
    rect_checkoutView.origin.x = 0;
    rect_checkoutView.origin.y = self.view.frame.size.height - (self.bottomTabView.frame.size.height + rect_checkoutView.size.height);
    rect_checkoutView.size.width = self.view.frame.size.width;
    
    self.checkoutView.frame = rect_checkoutView;
    
    [self.checkoutView layoutUI];
}

#pragma mark - UI Methods

- (CheckoutView *)checkoutView
{
    if (_checkoutView == nil)
    {
        __weak TicketViewController* weakSelf = self;
        
        CGRect rect = CGRectMake(0, self.view.frame.size.height - checkoutViewHeight, self.view.frame.size.width, checkoutViewHeight);
        _checkoutView = [[CheckoutView alloc] initWithFrame:rect];
        _checkoutView.checkoutTitle = @"Confirm Cart";
        [_checkoutView updateUI];
        _checkoutView.onCheckout = ^(id sender) {
            [weakSelf confirmOrder];
        };
        [self.view addSubview:_checkoutView];
    }
    return _checkoutView;
}

- (UIBarButtonItem *) bbiClear
{
    if (_bbiClear == nil)
    {
        _bbiClear = [[UIBarButtonItem alloc] initWithTitle:@"Clear Cart" style:UIBarButtonItemStylePlain target:self action:@selector(onbbiClear:)];
    }
    return _bbiClear;
}
- (void) onbbiClear:(UIBarButtonItem *)sender
{
    [self clearTicket];
}

@end
