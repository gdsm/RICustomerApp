//
//  MainViewController.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "MainViewController.h"
#import "ItemViewController.h"
#import "TicketViewController.h"
#import "DeliveryOrderViewController.h"
#import "ReportProblemViewController.h"
#import "QuickOrderViewController.h"
#import "UserOptionsViewController.h"
#import "ChangePasswordViewController.h"
#import "ProblemCategoryViewController.h"
#import "FeedbackViewController.h"

#import "HomeButtonsView.h"
#import "QuickOrderView.h"
#import "TitleCell.h"
#import "UserInfoView.h"
#import "CartView.h"

#import "UserManager.h"
#import "NotificationInfo.h"

const CGFloat MainVC_BarcodeBtnHeight = 44;
const CGFloat MainVC_BarcodeBtnWidth = 44;
const CGFloat MainVC_BarcodeHomeBtnOverlap = 10;
const CGFloat MainVC_TableLeftMargin = 40;
const CGFloat MainVC_TableRightMargin = 40;
const CGFloat MainVC_TableHeight = 120;
const CGFloat MainVC_UserViewTopMargin = 10;
const CGFloat MainVC_UserViewLeftMargin = 40;
const CGFloat MainVC_UserViewRightMargin = 40;
const CGFloat MainVC_UserViewHeight = 160;


@interface MainViewController ()
@property (nonatomic, strong) HomeButtonsView* homeButtonView;
@property (nonatomic, strong) UserInfoView* userInfoView;
@property (nonatomic, strong) QuickOrderView* viewQuickOrder;
@property (nonatomic, strong) UIButton* btnBarcode;
@property (nonatomic, strong) UIBarButtonItem* bbiUser;
@property (nonatomic, strong) UIBarButtonItem* bbiBarcode;
@end


@implementation MainViewController


#pragma mark - UILife Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self listenNotifications];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.bottomTabView.hidden = NO;
}

- (void)setupUI
{
    __weak MainViewController* weakSelf = self;

    self.navigationItem.hidesBackButton = YES;
    self.title = @"ReddyIce";
    
    self.navigationItem.leftBarButtonItem = self.bbiUser;
    self.navigationItem.rightBarButtonItem = self.bbiBarcode;

    self.tableView.scrollEnabled = NO;
    self.tableView.hidden = YES;

    self.bgImgv.image = [UIImage imageNamed:@"HomeBG.png"];
    
    self.bottomTabView.hidden = NO;
    self.bottomTabView.btnHome.selected = YES;
    self.bottomTabView.callbackHome = ^(id sender) {
        [weakSelf setHomeTab];
    };
    
    self.bottomTabView.callbackHome = ^(id sender) {
        [weakSelf setHomeTab];
    };

    self.bottomTabView.callbackDeliveryHistory = ^(id sender) {
        [weakSelf deliveryHistory];
    };
    
    self.bottomTabView.callbackPlaceOrder = ^(id sender) {
        [weakSelf placeAnOrder];
    };
    
    self.bottomTabView.callbackReportAProblem = ^(id sender) {
        [weakSelf reportAProblem];
    };
    
    self.bottomTabView.callbackShareFeedback = ^(id sender) {
        [weakSelf shareFeedback];
    };
    
    [CartView instance].onCartCallback = ^(id sender) {
        [weakSelf showTicket];
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) listenNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearTicketDone:) name:noti_ClearTicketDone object:nil];
}

- (void) removeNotifications
{
    // Child class should override this.
}

- (void)dealloc
{
    [self removeNotifications];
}


#pragma mark - Logical Flow Methods

- (void) unselectAllTabs
{
    [self.bottomTabView unselectBottomTabs];
    [self safeDismissViewControllerFromSelf:NO animated:NO callbackCompletion:nil];
    [self safePopToController:self animated:NO];
}

- (void) setHomeTab
{
    [self unselectAllTabs];
    self.bottomTabView.btnHome.selected = YES;
}

- (void) deliveryHistory
{
    [self unselectAllTabs];
    self.bottomTabView.btnDeliveryHistory.selected = YES;

    DeliveryOrderViewController* view = [[DeliveryOrderViewController alloc] init];
    [self safePush:view animated:NO];
}

- (void) reportAProblem
{
    [self unselectAllTabs];
    self.bottomTabView.btnReportAProb.selected = YES;

    ProblemCategoryViewController* view = [[ProblemCategoryViewController alloc] init];
    [self safePush:view animated:NO];
}

- (void) shareFeedback
{
    [self unselectAllTabs];
    self.bottomTabView.btnShareFeedback.selected = YES;

    FeedbackViewController* view = [[FeedbackViewController alloc] init];
    [self safePush:view animated:NO];
}

- (void) placeAnOrder
{
    [self unselectAllTabs];
    self.bottomTabView.btnPlaceOrder.selected = YES;

    ItemViewController* view = [[ItemViewController alloc] initWithStyle:UITableViewStylePlain];
    [self safePush:view animated:NO];
}

- (void) placeQuickOrder
{
    [self unselectAllTabs];
    self.bottomTabView.btnPlaceOrder.selected = YES;

    QuickOrderViewController* view = [[QuickOrderViewController alloc] init];
    [self safePresent:view onSelf:NO animated:YES callbackCompletion:nil];
}

- (void) showUserInfo
{
    __weak MainViewController* weakSelf = self;
    
    UserOptionsViewController* view = [[UserOptionsViewController alloc] init];
    view.callbackLogout = ^{
        [weakSelf performSelectorOnMainThread:@selector(logoutUser) withObject:nil waitUntilDone:NO];
    };
    view.callbackMyProfile = ^{
        [weakSelf performSelectorOnMainThread:@selector(userProfile) withObject:nil waitUntilDone:NO];
    };
    view.callbackChangePassword = ^{
        [weakSelf performSelectorOnMainThread:@selector(changePassword) withObject:nil waitUntilDone:NO];
    };

    if ([Utilities isiPad])
    {
        [view popoverPresentation:nil barButton:self.bbiUser sourceRect:CGRectZero];
    }
    else
    {
        view.removeCallback = ^{
            [weakSelf safeDismissViewControllerFromSelf:NO animated:YES callbackCompletion:nil];
        };
    }
    [self safePresent:view onSelf:NO animated:YES callbackCompletion:nil];
}

- (void) barcodeScanner
{
    
}

- (void) showTicket
{
    TicketViewController* view = [[TicketViewController alloc] initWithStyle:UITableViewStylePlain];
    [self safePush:view animated:YES];
}

- (void) logoutUser
{
    [UserManager shared].activeUser.userLoggedInState = UserLoggedInState_LoggedOut;
    [self dismissPopOversAnimated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) userProfile
{
    [self dismissPopOversAnimated:NO];
}

- (void) changePassword
{
    __weak MainViewController* weakSelf = self;

    [self dismissPopOversAnimated:NO];
    ChangePasswordViewController* view = [[ChangePasswordViewController alloc] init];
    view.showCancel = YES;
    view.removeCallback = ^{
        [weakSelf safeDismissViewControllerFromSelf:NO animated:YES callbackCompletion:nil];
    };
    
    [self safePresent:view onSelf:NO animated:YES callbackCompletion:nil];
}


#pragma mark - Listener Methods

- (void) clearTicketDone:(NSNotification *)sender
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    [self performSelectorOnMainThread:@selector(setHomeTab) withObject:nil waitUntilDone:NO];
}


#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (MainVC_TableHeight * 0.5);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCell* cell = [TitleCell dequeueFrom:tableView loadFromNib:@"TitleCell"];
    [cell updateCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0)
    {
        cell.lblTitle.text = @"Your Order #3333 planned for delivery today.";
        cell.viewSeperator.hidden = NO;
        cell.btnInfo.hidden = YES;
    }
    else if (indexPath.row == 1)
    {
        cell.lblTitle.text = @"Last order delivered on 27 Sept 2017 15:30.";
        cell.viewSeperator.hidden = YES;
        cell.btnInfo.hidden = NO;
        [cell.btnInfo setTitle:[IconFontCodes shared].fileText forState:UIControlStateNormal];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self deliveryHistory];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [Globals shared].themingAssistant.whiteHigh;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Layout Methods

- (void) layoutSubViews
{
    [super layoutSubviews];
    
    CGRect rect_homeButtonView = self.homeButtonView.frame;
    CGRect rect_tableView = self.tableView.frame;
    CGRect rect_quickOrderView = self.viewQuickOrder.frame;

//    rect_btnBarcode.origin.x = (self.view.frame.size.width - rect_btnBarcode.size.width) * 0.5;
//    rect_btnBarcode.origin.y = self.view.frame.size.height - rect_btnBarcode.size.height;
    
    rect_homeButtonView.origin.x = 0;
    rect_homeButtonView.size.width = self.view.frame.size.width;
    rect_homeButtonView.size.height = [self.homeButtonView estimatedSize].height;
    rect_homeButtonView.origin.y = self.view.frame.size.height - (rect_homeButtonView.size.height + self.bottomTabView.frame.size.height + MainVC_BarcodeHomeBtnOverlap);
//    rect_homeButtonView.origin.y = self.view.frame.size.height - (rect_homeButtonView.size.height + MainVC_BarcodeBtnHeight - MainVC_BarcodeHomeBtnOverlap);
//    rect_homeButtonView.origin.y = self.view.frame.size.height - (rect_homeButtonView.size.height + rect_btnBarcode.size.height - MainVC_BarcodeHomeBtnOverlap);

    rect_tableView.size.height = MainVC_TableHeight;
    rect_tableView.size.width = self.view.frame.size.width - (MainVC_TableLeftMargin + MainVC_TableRightMargin);
    rect_tableView.origin.x = MainVC_TableLeftMargin;
    rect_tableView.origin.y = rect_homeButtonView.origin.y - (MainVC_TableHeight + bottomMargin_20px);

    rect_quickOrderView.size.width = self.view.frame.size.width - (MainVC_UserViewLeftMargin + MainVC_UserViewRightMargin);
    rect_quickOrderView.origin.x = MainVC_UserViewLeftMargin;
    rect_quickOrderView.origin.y = self.navigationBarHeight + self.statusBarHeight +  QuickOrderViewTopMargin;


    
    self.homeButtonView.frame = rect_homeButtonView;
    self.tableView.frame = rect_tableView;
    self.viewQuickOrder.frame = rect_quickOrderView;

    [self.homeButtonView layoutUI];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self layoutSubViews];
}

#pragma mark - UI Methods

- (UIBarButtonItem *) bbiUser
{
    if (_bbiUser == nil)
    {
        _bbiUser = [[UIBarButtonItem alloc] initWithTitle:[IconFontCodes shared].userCircle style:UIBarButtonItemStylePlain target:self action:@selector(onbbiUser:)];
        [_bbiUser setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[Globals shared].bbiIconFont, NSFontAttributeName, [Globals shared].themingAssistant.defaultIconColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    }
    return _bbiUser;
}

- (UIBarButtonItem *) bbiBarcode
{
    if (_bbiBarcode == nil)
    {
        _bbiBarcode = [[UIBarButtonItem alloc] initWithCustomView:self.btnBarcode];
//        _bbiBarcode = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barcode.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onbbiBarcode:)];
    }
    return _bbiBarcode;
}

- (void) onbbiUser:(UIBarButtonItem *)sender
{
    [self showUserInfo];
}

- (void) onbbiBarcode:(UIBarButtonItem *)sender
{
    [self barcodeScanner];
}

- (UIButton *) btnBarcode
{
    if (_btnBarcode == nil)
    {
        _btnBarcode = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBarcode.frame = CGRectMake(0, 0, MainVC_BarcodeBtnWidth, MainVC_BarcodeBtnHeight);
        [_btnBarcode setImage:[UIImage imageNamed:@"barcode.png"] forState:UIControlStateNormal];
        _btnBarcode.backgroundColor = [UIColor clearColor];
        
        [_btnBarcode addTarget:self action:@selector(onBtnBarcode:) forControlEvents:UIControlEventTouchUpInside];
        
//        [self.view addSubview:_btnBarcode];
    }
    return _btnBarcode;
}

- (void) onBtnBarcode:(UIButton *)sender
{
    [self barcodeScanner];
}

- (HomeButtonsView *)homeButtonView
{
    if (_homeButtonView == nil)
    {
        __weak MainViewController* weakSelf = self;
        
        _homeButtonView = [[HomeButtonsView alloc] initWithFrame:self.view.frame];
        _homeButtonView.backgroundColor = [UIColor clearColor];

        _homeButtonView.callbackDeliveryHistory = ^(id sender) {
            [weakSelf deliveryHistory];
        };

        _homeButtonView.callbackPlaceOrder = ^(id sender) {
            [weakSelf placeAnOrder];
        };

        _homeButtonView.callbackReportAProblem = ^(id sender) {
            [weakSelf reportAProblem];
        };

        _homeButtonView.callbackShareFeedback = ^(id sender) {
            [weakSelf shareFeedback];
        };

        _homeButtonView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_homeButtonView];
    }
    return _homeButtonView;
}

- (UserInfoView *)userInfoView
{
    if (_userInfoView == nil)
    {
        CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 200);
        _userInfoView = [[UserInfoView alloc] initWithFrame:rect];
        _userInfoView.lblWelcome.text = @"Welcome";
        _userInfoView.viewUserImage.imageName = @"ProfilePic.png";
        _userInfoView.lblUserName.text = [Globals shared].userName;
        _userInfoView.lblDescription.text = @"Walmart SuperCenter(D)";//
        [_userInfoView updateUI];
        _userInfoView.hidden = YES;

        [self.view addSubview:_userInfoView];
    }
    return _userInfoView;
}

- (QuickOrderView *)viewQuickOrder
{
    if (_viewQuickOrder == nil)
    {
        __weak MainViewController* weakSelf = self;
        
        CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, QuickOrderViewHeight);
        _viewQuickOrder = [[QuickOrderView alloc] initWithFrame:rect];
        [_viewQuickOrder updateUI];
        _viewQuickOrder.onQuickCheckout = ^(id sender) {
            [weakSelf placeQuickOrder];
        };
        [self.view addSubview:_viewQuickOrder];
    }
    return _viewQuickOrder;
}

@end







// ---> Old Code : After changes with business mettings
//- (void) layoutSubViews
//{
//    [super layoutSubviews];
//
//    CGRect rect_homeButtonView = self.homeButtonView.frame;
//    //    CGRect rect_btnBarcode = self.btnBarcode.frame;
//    CGRect rect_tableView = self.tableView.frame;
//    CGRect rect_userInfoView = self.userInfoView.frame;
//
//    //    rect_btnBarcode.origin.x = (self.view.frame.size.width - rect_btnBarcode.size.width) * 0.5;
//    //    rect_btnBarcode.origin.y = self.view.frame.size.height - rect_btnBarcode.size.height;
//
//    rect_homeButtonView.origin.x = 0;
//    rect_homeButtonView.size.width = self.view.frame.size.width;
//    rect_homeButtonView.size.height = [self.homeButtonView estimatedSize].height;
//    rect_homeButtonView.origin.y = self.view.frame.size.height - (rect_homeButtonView.size.height + self.bottomTabView.frame.size.height + MainVC_BarcodeHomeBtnOverlap);
//    //    rect_homeButtonView.origin.y = self.view.frame.size.height - (rect_homeButtonView.size.height + MainVC_BarcodeBtnHeight - MainVC_BarcodeHomeBtnOverlap);
//    //    rect_homeButtonView.origin.y = self.view.frame.size.height - (rect_homeButtonView.size.height + rect_btnBarcode.size.height - MainVC_BarcodeHomeBtnOverlap);
//
//    rect_tableView.size.height = MainVC_TableHeight;
//    rect_tableView.size.width = self.view.frame.size.width - (MainVC_TableLeftMargin + MainVC_TableRightMargin);
//    rect_tableView.origin.x = MainVC_TableLeftMargin;
//    rect_tableView.origin.y = rect_homeButtonView.origin.y - (MainVC_TableHeight + bottomMargin_20px);
//
//    rect_userInfoView.size.height = MainVC_UserViewHeight;
//    rect_userInfoView.size.width = self.view.frame.size.width - (MainVC_UserViewLeftMargin + MainVC_UserViewRightMargin);
//    rect_userInfoView.origin.x = MainVC_UserViewLeftMargin;
//    rect_userInfoView.origin.y = self.navigationBarHeight + self.statusBarHeight +  MainVC_UserViewTopMargin;
//
//
//
//    self.homeButtonView.frame = rect_homeButtonView;
//    //    self.btnBarcode.frame = rect_btnBarcode;
//    self.tableView.frame = rect_tableView;
//    self.userInfoView.frame = rect_userInfoView;
//
//    [self.homeButtonView layoutUI];
//    [self.userInfoView layoutUI];
//}

