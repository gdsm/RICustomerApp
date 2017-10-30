//
//  ItemDetailViewController.m
//  ReddyIce
//
//  Created by Gagan on 16/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "CheckoutView.h"
#import "SliderCell.h"
#import "EnterQuantityCell.h"
#import "ItemVariationCell.h"
#import "CategoryDetailCell.h"
#import "CrauselCell.h"
#import "CartView.h"


const CGFloat ItemDetailVC_Top_Margin = 20;
const CGFloat ItemDetailVC_ItmVar_TopInset = 0;
const CGFloat ItemDetailVC_ItmVar_BottomInset = 10;
const CGFloat ItemDetailVC_SliderCell_Height = 60;
const CGFloat ItemDetailVC_EnterQtyCell_Height = 40;
const CGFloat ItemDetailVC_ItmVarCell_Height = 50;
const CGFloat ItemDetailVC_ItmCostCell_Height = 40;
//const CGFloat ItemDetailVC_CrauselCell_Height = 300;
const CGFloat ItemDetailVC_VarBtn_width = 120;

typedef NS_ENUM(NSUInteger, ItemDetailVC_CellSequence)
{
    ItemDetailVC_CellSequence_ItmCrausel,
    ItemDetailVC_CellSequence_ItmCost,
    ItemDetailVC_CellSequence_ItmVar,
    ItemDetailVC_CellSequence_EnterQty,
    ItemDetailVC_CellSequence_Slider
};

@interface ItemDetailViewController ()
@property (nonatomic, strong) CheckoutView* checkoutView;
@property (nonatomic, strong) UIBarButtonItem* bbiCart;
@end

@implementation ItemDetailViewController
{
    BOOL doesViewRequiresScroll;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI
{
    //TODO:[GM]: Add localisation
    self.title = @"Detail";
    self.bgImgv.image = nil;
    
    CGFloat top = (self.navigationBarHeight + self.statusBarHeight);
    CGFloat bottom = self.bottomTabView.frame.size.height + self.checkoutView.frame.size.height;
    self.tableOffset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    CGFloat expctdTableHeight = self.view.frame.size.height - (top + bottom);
    CGFloat expctdViewHeight = (ItemDetailVC_SliderCell_Height + ItemDetailVC_EnterQtyCell_Height + ItemDetailVC_ItmVarCell_Height + ItemDetailVC_ItmCostCell_Height + top + bottom + (expctdTableHeight * 0.4));
    
    if (expctdViewHeight > self.view.frame.size.height)
    {
        doesViewRequiresScroll = YES;
    }

    self.tableView.scrollEnabled = doesViewRequiresScroll;
    self.allowKeyboardNotifications = YES;
    self.bgImgv.userInteractionEnabled = YES;

    self.navigationItem.rightBarButtonItem = self.bbiCart;
    self.bgImgv.userInteractionEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.bottomTabView.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Logical Flow

- (void) addToCart
{
    
}

- (void) itemQuantityChanged:(NSDecimalNumber *)qty
{
    
}

- (void) itemVariationSelected:(NSIndexPath *)indexPath
{
    
}

#pragma mark - TableViewMethods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak ItemDetailViewController* weakSelf = self;
    if (indexPath.row == ItemDetailVC_CellSequence_Slider)
    {
        SliderCell* cell = [SliderCell dequeueFrom:tableView loadFromNib:@"SliderCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.sliderView.onValueChangedCallback = ^(NSDecimalNumber *value) {
            [weakSelf itemQuantityChanged:value];
        };
        return cell;
    }
    else if (indexPath.row == ItemDetailVC_CellSequence_EnterQty)
    {
        EnterQuantityCell* cell = [EnterQuantityCell dequeueFrom:tableView loadFromNib:@"EnterQuantityCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCell];
        return cell;
    }
    else if (indexPath.row == ItemDetailVC_CellSequence_ItmCrausel)
    {
        CrauselCell* cell = [CrauselCell dequeueFrom:tableView loadFromNib:@"CrauselCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIEdgeInsets inset = cell.crauselView.contentInsets;
        inset.top = ItemDetailVC_Top_Margin;
        cell.crauselView.contentInsets = inset;
        
        [cell updateCell];
        return cell;
    }
    else if (indexPath.row == ItemDetailVC_CellSequence_ItmCost)
    {
        CategoryDetailCell* cell = [CategoryDetailCell dequeueFrom:tableView loadFromNib:@"CategoryDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCell];
        cell.category = @"Select your bag size";
        cell.detail = @"Cost per lb $0:00";
        return cell;
    }
    else if (indexPath.row == ItemDetailVC_CellSequence_ItmVar)
    {
        ItemVariationCell* cell = [ItemVariationCell dequeueFrom:tableView loadFromNib:@"ItemVariationCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UIEdgeInsets inset = cell.itemVariationView.contentInsets;
        inset.top = ItemDetailVC_ItmVar_TopInset;
        inset.bottom = ItemDetailVC_ItmVar_BottomInset;
        cell.itemVariationView.contentInsets = inset;

        [cell updateCell];

        cell.itemVariationView.bgHighColor = [Globals shared].themingAssistant.itemVariationButtonBGNormalColor;
        cell.itemVariationView.bgSelectedColor = [Globals shared].themingAssistant.itemVariationButtonBGNormalColor;
        cell.itemVariationView.bgNormalColor = [UIColor lightGrayColor];

        cell.itemVariationView.varSelected = ^(NSIndexPath *indexPath) {
            [weakSelf itemVariationSelected:indexPath];
        };
        return cell;
    }

    BaseTableViewCell* cell = [BaseTableViewCell blankCell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat retVal = 1;
    if (indexPath.row == ItemDetailVC_CellSequence_Slider)
    {
        retVal = ItemDetailVC_SliderCell_Height;
    }
    else if (indexPath.row == ItemDetailVC_CellSequence_EnterQty)
    {
        retVal = ItemDetailVC_EnterQtyCell_Height;
    }
    else if (indexPath.row == ItemDetailVC_CellSequence_ItmCost)
    {
        retVal = ItemDetailVC_ItmCostCell_Height;
    }
    else if (indexPath.row == ItemDetailVC_CellSequence_ItmVar)
    {
        retVal = ItemDetailVC_ItmVarCell_Height;
    }
    else if (indexPath.row == ItemDetailVC_CellSequence_ItmCrausel)
    {
        retVal = tableView.frame.size.height * 0.4;
    }
    return retVal;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[Utilities findFirstResonderIn:self.tableView] resignFirstResponder];
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
        __weak ItemDetailViewController* weakSelf = self;
        
        CGRect rect = CGRectMake(0, self.view.frame.size.height - checkoutViewHeight, self.view.frame.size.width, checkoutViewHeight);
        _checkoutView = [[CheckoutView alloc] initWithFrame:rect];
        _checkoutView.checkoutTitle = @"Add to Cart";
        [_checkoutView updateUI];
        _checkoutView.onCheckout = ^(id sender) {
            [weakSelf addToCart];
        };
        [self.view addSubview:_checkoutView];
    }
    return _checkoutView;
}

- (UIBarButtonItem *)bbiCart
{
    if (_bbiCart == nil)
    {
        _bbiCart = [[UIBarButtonItem alloc] initWithCustomView:[CartView instance]];
    }
    return _bbiCart;
}

@end
