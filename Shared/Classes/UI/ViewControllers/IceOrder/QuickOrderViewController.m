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

const CGFloat QuickOrderVC_vartInfo_margin = 20;
const CGFloat QuickOrderVC_lblInfo_height = 100;
const CGFloat QuickOrderVC_btnDone_height = 60;

@interface QuickOrderViewController ()

@property (nonatomic, strong) CartView* viewCart;
@property (nonatomic, strong) BaseLabel* lblInfo;
@property (nonatomic, strong) ColoredButton* btnDone;
@property (nonatomic, strong) UIBarButtonItem* bbiCancel;

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
    
    self.bottomTabView.hidden = YES;
    [self.view addSubview:self.viewCart];
    [self.view addSubview:self.lblInfo];
    [self.view addSubview:self.btnDone];

    self.navigationItem.rightBarButtonItem = self.bbiCancel;
}


#pragma mark - Logical Methods

- (void) compelteQuickOrder
{
    OrderConfirmationViewController* view = [[OrderConfirmationViewController alloc] init];
    [self safePush:view animated:YES];
}


#pragma mark - UI Methods

- (CartView *)viewCart
{
    if (_viewCart == nil)
    {
        CGFloat top = (self.navigationBarHeight + self.statusBarHeight);
        CGFloat avlHei = self.view.frame.size.height - top;
        CGRect rect = CGRectMake((self.view.frame.size.width - cartSize_44px) * 0.5, avlHei * 0.2, cartSize_44px, cartSize_44px);
        _viewCart = [[CartView alloc] initWithFrame:rect];
        _viewCart.layer.cornerRadius = rect.size.width * 0.5;
        _viewCart.layer.borderColor = [Globals shared].themingAssistant.defaultBorderColor.CGColor;
        _viewCart.layer.borderWidth = 1;
        _viewCart.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        _viewCart.hideBadge = YES;
        [_viewCart updateUI];
    }
    return _viewCart;
}

- (BaseLabel *)lblInfo
{
    if (_lblInfo == nil)
    {
        CGFloat top = (self.viewCart.frame.origin.y + self.viewCart.frame.size.height + QuickOrderVC_vartInfo_margin);

        CGRect rect = CGRectMake(leftMargin_20px, top, self.view.frame.size.width - (leftMargin_20px + rightMargin_20px), QuickOrderVC_lblInfo_height);
        _lblInfo = [[BaseLabel alloc] initWithFrame:rect];
        _lblInfo.text = @"This action will submit new order.\rPlease Confirm !";
        _lblInfo.textAlignment = NSTextAlignmentCenter;
        [_lblInfo defaultStyling];
    }
    return _lblInfo;
}

- (ColoredButton *)btnDone
{
    if (_btnDone == nil)
    {
        CGRect rect = CGRectZero;
        rect.size.width = self.view.frame.size.width - (leftMargin_20px + rightMargin_20px);
        rect.size.height = QuickOrderVC_btnDone_height;
        rect.origin.x = leftMargin_20px;
        rect.origin.y = self.view.frame.size.height - (bottomMargin_20px + QuickOrderVC_btnDone_height);
        
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) onBtnTap:(ColoredButton *)sender
{
    [self compelteQuickOrder];
}

@end
