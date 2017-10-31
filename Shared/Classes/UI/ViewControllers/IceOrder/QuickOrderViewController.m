//
//  QuickOrderViewController.m
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "QuickOrderViewController.h"
#import "OrderConfirmationViewController.h"
#import "CartView.h"
#import "QuickOrderView.h"
#import "CategoryDetailView.h"
#import "ReportLineCell.h"
#import "ReportLineTemplateCell.h"
#import "CheckBox.h"

const CGFloat QuickOrderVC_QuickOrderViewHeight = 200;
const CGFloat QuickOrderVC_vartInfo_margin = 20;
const CGFloat QuickOrderVC_lblInfo_height = 100;
const CGFloat QuickOrderVC_viewAddress_height = 100;

@interface QuickOrderViewController ()

@property (nonatomic, strong) BaseLabel* lblTitle;
@property (nonatomic, strong) CategoryDetailView* viewAddress;
@property (nonatomic, strong) QuickOrderView* viewQuickOrder;
@property (nonatomic, strong) ColoredButton* btnDone;
@property (nonatomic, strong) UIBarButtonItem* bbiRemove;

@end


@implementation QuickOrderViewController


#pragma mark - View Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) setupUI
{
    //TODO:[GM]: Add localisation
    self.title = @"Quick Order";
    self.bgImgv.image = nil;
    
//    [self.view addSubview:self.viewQuickOrder];
    [self.view addSubview:self.lblTitle];
    [self.view addSubview:self.viewAddress];
    [self.view addSubview:self.btnDone];

    CGFloat top = (self.viewAddress.frame.origin.y + self.viewAddress.frame.size.height + topMargin_20px);
    CGFloat bottom = self.btnDone.frame.size.height;
    self.tableOffset = UIEdgeInsetsMake(top, 0, bottom, 0);

    self.navigationItem.leftBarButtonItem = self.bbiCancel;
    self.navigationItem.rightBarButtonItem = self.bbiRemove;
}


#pragma mark - Logical Methods

- (void) compelteQuickOrder
{
    OrderConfirmationViewController* view = [[OrderConfirmationViewController alloc] init];
    [self safePush:view animated:YES];
}

- (void) removeSelectedItem
{
    
}


#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight_60px;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak QuickOrderViewController* weakSelf = self;
    CGFloat div1 = self.tableView.frame.size.width - (viewContentInset_left + viewContentInset_right);
    div1 = (cellHeight_40px / div1);
    
    if (indexPath.row == 0)
    {
        ReportLineCell* cell = [ReportLineCell dequeueFrom:tableView loadFromNib:@"ReportLineCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.viewUnderLine.hidden = NO;
        
        CGFloat div[] = {div1, 0.35f, 0.65f, 0.8f};
        [cell initWithDividers:div count:5];
        [cell.reportLineView setTitles:@"", @"Product", @"Unit Price", @"Units", @"Amount", nil];
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
        
        CGFloat div[] = {div1, 0.35f, 0.65f, 0.8f};
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
                    [weakSelf removeSelectedItem];
                };
                retView = cb;
            }
            else if (index == 1){
                BaseLabel* lbl = [[BaseLabel alloc] init];
                [lbl defaultStyling];
                lbl.text = @"Product Name";
                retView = lbl;
            }
            else if (index == 2){
                BaseLabel* lbl = [[BaseLabel alloc] init];
                [lbl defaultStyling];
                lbl.textAlignment = NSTextAlignmentCenter;
                lbl.text = @"$00.00";
                retView = lbl;
            }
            else if (index == 3){
                BaseLabel* lbl = [[BaseLabel alloc] init];
                [lbl defaultStyling];
                lbl.textAlignment = NSTextAlignmentCenter;
                lbl.text = @"00";
                retView = lbl;
            }
            else if (index == 4){
                BaseLabel* lbl = [[BaseLabel alloc] init];
                [lbl defaultStyling];
                lbl.textAlignment = NSTextAlignmentRight;
                lbl.text = @"$00.00";
                retView = lbl;
            }
            return retView;
        } layoutTemplate:nil];
        return cell;
    }
    
    return nil;
}


#pragma mark - Layout Methods

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.viewAddress layoutUI];
}


#pragma mark - UI Methods

- (QuickOrderView *)viewQuickOrder
{
    if (_viewQuickOrder == nil)
    {
        CGFloat top = (self.navigationBarHeight + self.statusBarHeight + QuickOrderViewTopMargin);
        CGRect rect = CGRectMake(0, top, self.view.frame.size.width, QuickOrderVC_QuickOrderViewHeight);
        _viewQuickOrder = [[QuickOrderView alloc] initWithFrame:rect];

        _viewQuickOrder.contentMargin = topMargin_10px;
        
        _viewQuickOrder.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;

        [_viewQuickOrder updateUI];
        _viewQuickOrder.lblInfo.text = @"This action will submit new order.\rPlease Confirm !";
    }
    return _viewQuickOrder;
}

- (BaseLabel *) lblTitle
{
    if (_lblTitle == nil)
    {
        CGFloat top = (self.navigationBarHeight + self.statusBarHeight + topMargin_20px);
        CGRect rect = CGRectMake(leftMargin_20px, top, self.view.frame.size.width - (leftMargin_20px + rightMargin_20px), viewHeight_40px);

        _lblTitle = [[BaseLabel alloc] initWithFrame:rect];
        [_lblTitle defaultStyling];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        
        _lblTitle.text = @"Would to like to repeat the last order?";
    }
    return _lblTitle;
}

- (CategoryDetailView *) viewAddress
{
    if (_viewAddress == nil)
    {
        CGFloat top = (self.lblTitle.frame.origin.y + self.lblTitle.frame.size.height + topMargin_20px);
        CGRect rect = CGRectMake(0, top, self.view.frame.size.width, QuickOrderVC_viewAddress_height);

        _viewAddress = [[CategoryDetailView alloc] initWithFrame:rect];
        [_viewAddress updateUI];
        _viewAddress.dividerRatio = 0.3;
        _viewAddress.category = @"Delivery To";
        _viewAddress.detail = @"WHATABURGER\r#108113933 E SAM\rHOUSTON PKWAY, NHOUSTON,TX 77044";
        _viewAddress.lblCategory.textAlignment = NSTextAlignmentLeft;
        _viewAddress.lblDetail.textAlignment = NSTextAlignmentLeft;
        _viewAddress.lblCategory.font = [Globals shared].defaultInfoFont;
        _viewAddress.lblDetail.font = [Globals shared].defaultTextFont;
        _viewAddress.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _viewAddress;
}

- (ColoredButton *)btnDone
{
    if (_btnDone == nil)
    {
        CGRect rect = CGRectZero;
        rect.size.width = self.view.frame.size.width * 0.8;
        rect.size.height = viewHeight_40px;
        rect.origin.x = (self.view.frame.size.width - rect.size.width) * 0.5;
        rect.origin.y = self.view.frame.size.height - (bottomMargin_20px + rect.size.height);
        
        _btnDone = [ColoredButton coloredButtonType:ColoredButtonType_Blue frame:rect];
        _btnDone.borderNormalColor = [Globals shared].themingAssistant.defaultBorderColor;
        _btnDone.normalBorderWidth = borderWidth_1px;
        _btnDone.layer.cornerRadius = cornerRadius_6px;
        [_btnDone setTitle:@"Confirm Quick Order" forState:UIControlStateNormal];
        _btnDone.titleNormalColor = [UIColor whiteColor];
        _btnDone.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        
        [_btnDone addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDone;
}

- (void) onBBICancel:(UIBarButtonItem *)sender
{
    [self safeDismissViewControllerFromSelf:NO animated:YES callbackCompletion:nil];
}

- (void) onBtnTap:(ColoredButton *)sender
{
    [self compelteQuickOrder];
}

- (UIBarButtonItem *) bbiRemove
{
    if (_bbiRemove == nil)
    {
        _bbiRemove = [[UIBarButtonItem alloc] initWithTitle:@"Remove" style:UIBarButtonItemStylePlain target:self action:@selector(onbbiRemove:)];
    }
    return _bbiRemove;
}
- (void) onbbiRemove:(UIBarButtonItem *)sender
{
    [self removeSelectedItem];
}

@end
