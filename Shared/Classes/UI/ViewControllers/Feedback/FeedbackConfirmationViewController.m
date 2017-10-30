//
//  ConfirmationViewController.m
//  ReddyIce
//
//  Created by Gagan on 27/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "FeedbackConfirmationViewController.h"
#import "CustomerCareView.h"
#import "CategoryDetailView.h"

const CGFloat ConfirmVC_Title_Height = 60;
const CGFloat ConfirmVC_Descr_Height = 80;
const CGFloat ConfirmVC_SLA_Height = 100;

@interface FeedbackConfirmationViewController ()

@property (nonatomic, strong) UIBarButtonItem* bbiShare;
@property (nonatomic, strong) BaseLabel *lblTitle;
@property (nonatomic, strong) BaseLabel *lblDescription;
@property (nonatomic, strong) ColoredButton *btnDone;
@property (nonatomic, strong) CustomerCareView* viewCustomerCare;
@property (nonatomic, strong) CategoryDetailView* viewEarliestDate;
@property (nonatomic, strong) CategoryDetailView* viewLatestDate;
@end


@implementation FeedbackConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.bottomTabView.hidden = YES;
}

- (void)setupUI
{
    self.title = @"Confirmation";
    self.bgImgv.image = nil;
    self.tableView.hidden = YES;
    
    self.navigationItem.rightBarButtonItem = self.bbiShare;
    self.navigationItem.hidesBackButton = YES;
    
    self.lblTitle.text = @"Reddy Ice";
    self.lblDescription.text = @"Thanks for connecting with ReddyIce";
    
    [self.view addSubview:self.lblTitle];
    [self.view addSubview:self.lblDescription];
    [self.view addSubview:self.viewCustomerCare];
    [self.view addSubview:self.btnDone];
    [self.view addSubview:self.viewLatestDate];
    [self.view addSubview:self.viewEarliestDate];
}

- (void) setNavTitle:(NSString *)navTitle title:(NSString *)title description:(NSString *)description
{
    self.title = navTitle;
    self.lblTitle.text = title;
    self.lblDescription.text = description;
}


#pragma mark - Logical Flow Methods

- (void) makeCall
{
    
}

- (void) makeMessage
{
    
}


#pragma mark - Layout Methods

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.viewEarliestDate layoutUI];
    [self.viewLatestDate layoutUI];
}

#pragma mark - UI Methods

- (BaseLabel *) lblTitle
{
    if (_lblTitle == nil)
    {
        CGRect rect = CGRectZero;
        rect.origin.x = leftMargin_20px;
        rect.origin.y = topMargin_20px + self.navigationBarHeight + self.statusBarHeight;
        rect.size.width = self.view.frame.size.width - (leftMargin_20px + rightMargin_20px);
        rect.size.height = ConfirmVC_Title_Height;
        
        _lblTitle = [[BaseLabel alloc] initWithFrame:rect];
        [_lblTitle defaultStyling];
        _lblTitle.font = [Globals shared].boldTextFont;
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _lblTitle;
}

- (BaseLabel *) lblDescription
{
    if (_lblDescription == nil)
    {
        CGRect rect = CGRectZero;
        rect.origin.x = leftMargin_20px;
        rect.origin.y = topMargin_20px + self.lblTitle.frame.origin.y + self.lblTitle.frame.size.height;
        rect.size.width = self.view.frame.size.width - (leftMargin_20px + rightMargin_20px);
        rect.size.height = ConfirmVC_Descr_Height;
        
        _lblDescription = [[BaseLabel alloc] initWithFrame:rect];
        [_lblDescription defaultStyling];
        _lblDescription.textAlignment = NSTextAlignmentCenter;
        _lblDescription.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _lblDescription;
}

- (CategoryDetailView *) viewEarliestDate
{
    if (_viewEarliestDate == nil)
    {
        CGRect rect = CGRectZero;
        rect.origin.x = 0;
        rect.origin.y = topMargin_20px + self.lblDescription.frame.origin.y + self.lblDescription.frame.size.height;
        rect.size.width = self.view.frame.size.width * 0.5;
        rect.size.height = ConfirmVC_SLA_Height;

        _viewEarliestDate = [[CategoryDetailView alloc] initWithFrame:rect];
        _viewEarliestDate.categoryDetailStyle = CategoryDetailStyle_Vertical;
        [_viewEarliestDate updateUI];
        _viewEarliestDate.category = @"Earliest By:";
        _viewEarliestDate.detail = @"MM/DD/YYYY";
        _viewEarliestDate.lblCategory.textAlignment = NSTextAlignmentLeft;
        _viewEarliestDate.lblDetail.textAlignment = NSTextAlignmentLeft;
        _viewEarliestDate.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _viewEarliestDate;
}

- (CategoryDetailView *) viewLatestDate
{
    if (_viewLatestDate == nil)
    {
        CGRect rect = CGRectZero;
        rect.origin.x = self.viewEarliestDate.frame.origin.x + self.viewEarliestDate.frame.size.width;
        rect.origin.y = self.viewEarliestDate.frame.origin.y;
        rect.size.width = self.view.frame.size.width * 0.5;
        rect.size.height = ConfirmVC_SLA_Height;
        
        _viewLatestDate = [[CategoryDetailView alloc] initWithFrame:rect];
        _viewLatestDate.categoryDetailStyle = CategoryDetailStyle_Vertical;
        [_viewLatestDate updateUI];
        _viewLatestDate.category = @"Latest By:";
        _viewLatestDate.detail = @"MM/DD/YYYY";
        _viewLatestDate.lblCategory.textAlignment = NSTextAlignmentRight;
        _viewLatestDate.lblDetail.textAlignment = NSTextAlignmentRight;
        _viewLatestDate.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _viewLatestDate;
}

- (CustomerCareView *) viewCustomerCare
{
    if (_viewCustomerCare == nil)
    {
        __weak FeedbackConfirmationViewController* weakSelf = self;
        CGFloat top = self.btnDone.frame.origin.y - (CustomerCareView_Height + bottomMargin_20px);
        CGRect rect = CGRectMake(0, top, self.view.frame.size.width, CustomerCareView_Height);
        
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

- (ColoredButton *)btnDone
{
    if (_btnDone == nil)
    {
        CGRect rect = CGRectZero;
        rect.size.width = self.view.frame.size.width - (leftMargin_20px + rightMargin_20px);
        rect.size.height = viewHeight_40px;
        rect.origin.x = leftMargin_20px;
        rect.origin.y = self.view.frame.size.height - (rect.size.height + bottomMargin_20px);

        _btnDone = [ColoredButton coloredButtonType:ColoredButtonType_Blue frame:rect];
        _btnDone.layer.cornerRadius = cornerRadius_6px;
        [_btnDone setTitle:@"Done" forState:UIControlStateNormal];
        [_btnDone addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDone;
}

- (void) onBtnTap:(ColoredButton *)sender
{
    if (self.onDone != nil)
    {
        self.onDone();
    }
}

- (UIBarButtonItem *)bbiShare
{
    if (_bbiShare == nil)
    {
        _bbiShare = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(onbbiShare:)];
    }
    return _bbiShare;
}

- (void) onbbiShare:(UIBarButtonItem *)sender
{
    
}

@end
