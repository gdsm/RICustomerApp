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

const CGFloat QuickOrderVC_QuickOrderViewHeight = 200;
const CGFloat QuickOrderVC_vartInfo_margin = 20;
const CGFloat QuickOrderVC_lblInfo_height = 100;
const CGFloat QuickOrderVC_btnDone_height = 60;

@interface QuickOrderViewController ()

@property (nonatomic, strong) QuickOrderView* viewQuickOrder;
@property (nonatomic, strong) ColoredButton* btnDone;

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
    
    [self.view addSubview:self.viewQuickOrder];
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

        [self.view addSubview:_viewQuickOrder];
    }
    return _viewQuickOrder;
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

- (void) onBBICancel:(UIBarButtonItem *)sender
{
    [self safeDismissViewControllerFromSelf:NO animated:YES callbackCompletion:nil];
}

- (void) onBtnTap:(ColoredButton *)sender
{
    [self compelteQuickOrder];
}

@end
