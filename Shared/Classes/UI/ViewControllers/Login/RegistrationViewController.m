//
//  RegistrationViewController.m
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "RegistrationViewController.h"
#import "UserProfileViewController.h"
#import "IconTextField.h"
#import "UserManager.h"
#import "UserSummary.h"

@interface RegistrationViewController ()

@property (nonatomic, strong) BaseLabel* lblInfo;
@property (nonatomic, strong) IconTextField* tfPhoneNumber;
@property (weak, nonatomic) IBOutlet BaseView *viewBottom;
@property (weak, nonatomic) IBOutlet BaseView *viewContinue;
@property (weak, nonatomic) IBOutlet BaseView *viewRegister;

@property (strong, nonatomic) ColoredButton *btnRegister;
@property (strong, nonatomic) ColoredButton *btnContinue;
@property (strong, nonatomic) UIBarButtonItem* bbiLogin;

@property (strong, nonatomic) UserSummary* userSummary;

@end


@implementation RegistrationViewController

#pragma mark - View Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) setupUI
{
    self.title = @"Registration";

    CGFloat top = (self.tfPhoneNumber.frame.origin.y + self.tfPhoneNumber.frame.size.height + topMargin_20px);
    CGFloat bottom = 0;//self.bottomTabView.frame.size.height + self.checkoutView.frame.size.height;
    self.tableOffset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    self.allowKeyboardNotifications = YES;
    
    UIEdgeInsets inset = self.viewRegister.contentInsets;
    inset.left = self.view.frame.size.width * 0.1;
    inset.right = self.view.frame.size.width * 0.1;
    self.viewRegister.contentInsets = inset;

    inset = self.viewContinue.contentInsets;
    inset.left = self.view.frame.size.width * 0.1;
    inset.right = self.view.frame.size.width * 0.1;
    self.viewContinue.contentInsets = inset;

    self.btnRegister.coloredButtonType = ColoredButtonType_Blue;
    self.viewBottom.backgroundColor = [UIColor clearColor];
    self.viewContinue.backgroundColor = [UIColor clearColor];
    self.viewRegister.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.lblInfo];
    [self.view addSubview:self.tfPhoneNumber];
    [self.viewContinue addSubview:self.btnContinue];
    [self.viewRegister addSubview:self.btnRegister];
    
    [self blueTheme];
    
    self.navigationItem.leftBarButtonItem = self.bbiLogin;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tfPhoneNumber.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UserSummary *)userSummary
{
    if (_userSummary == nil){
        _userSummary = [UserManager shared].activeUser;
    }
    return _userSummary;
}


#pragma mark - Notification Methods

- (void) keyboardDidShow:(nullable NSNotification *)notification
{
    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self layoutBottomView:keyBoardFrame.size.height];
}

- (void) keyboardDidHide:(nullable NSNotification *)notification
{
    [self layoutBottomView:0];
}


#pragma mark - Logical Flow Methods

- (void) userProfileFlowConfirmed
{
    UserProfileViewController* view = [[UserProfileViewController alloc] initWithStyle:UITableViewStylePlain];
    view.isNewUser = YES;
    [self safePush:view animated:YES];
}

- (void) continueLoginFlow
{
    __weak RegistrationViewController* weakSelf = self;
    
    NSString* err = [[UserManager shared] registerUserWithPhone:self.userSummary callback:^(UserSummary *user, NSString *error) {
        [weakSelf hideHUD];
        if (error != nil){
            [weakSelf showToast:error];
        }
        else{
            [weakSelf userProfileFlowConfirmed];
        }
    }];
    
    if (err != nil){
        [self showToast:err];
    }
    else{
        [self showHUD:@"Registering User"];
    }
}

- (void) registerUser
{
    [self userProfileFlowConfirmed];
}


#pragma mark - Layout Methods

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.tfPhoneNumber layoutUI];
    [self.viewRegister layoutUI];
}

- (void) layoutBottomView:(CGFloat)bottomMargin
{
    CGRect rect_btm = self.viewBottom.frame;
    rect_btm.origin.y = self.view.frame.size.height - (bottomMargin + rect_btm.size.height);
    self.viewBottom.frame = rect_btm;
}

#pragma mark - UI Methods

- (BaseLabel *) lblInfo
{
    if (_lblInfo == nil)
    {
        CGFloat top = (self.navigationBarHeight + self.statusBarHeight + topMargin_20px);
        CGRect rect = CGRectMake(leftMargin_20px, top, self.view.frame.size.width - (leftMargin_20px + rightMargin_20px), viewHeight_60px);
        
        _lblInfo = [[BaseLabel alloc] initWithFrame:rect];
        _lblInfo.text = @"Please enter your registered store phone number with ReddyIce to continue registration.";
        _lblInfo.textAlignment = NSTextAlignmentCenter;
        _lblInfo.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [_lblInfo defaultStyling];
    }
    return _lblInfo;
}

- (IconTextField *) tfPhoneNumber
{
    if (_tfPhoneNumber == nil)
    {
        CGFloat top = (self.lblInfo.frame.origin.y + self.lblInfo.frame.size.height + topMargin_20px);
        CGRect rect = CGRectMake(leftMargin_20px, top, self.view.frame.size.width - (leftMargin_20px + rightMargin_20px), viewHeight_60px);

        __weak RegistrationViewController* weakSelf = self;
        
        _tfPhoneNumber = [[IconTextField alloc] initWithFrame:rect];
        [_tfPhoneNumber.lblIcon defaultStyling];
        _tfPhoneNumber.iconCode = @"+1";
        _tfPhoneNumber.viewUnderLine.hidden = NO;
        [_tfPhoneNumber.textField phoneNumberMode];
        _tfPhoneNumber.backgroundColor = [UIColor clearColor];
        _tfPhoneNumber.placeHolderText = @"Enter Registered Phone Number";
        _tfPhoneNumber.textField.keyboardType = UIKeyboardTypePhonePad;
        _tfPhoneNumber.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        
        _tfPhoneNumber.valueChanged = ^(NSString *value) {
            weakSelf.userSummary.phoneNumber = value;
        };
    }
    return _tfPhoneNumber;
}

- (ColoredButton *) btnContinue
{
    if (_btnContinue == nil)
    {
        CGRect rect = CGRectMake(self.viewContinue.contentInsets.left, self.viewContinue.contentInsets.top, self.viewContinue.contentWidth, self.viewContinue.contentHeight);
        
        _btnContinue = [ColoredButton coloredButtonType:ColoredButtonType_Blue frame:rect];
        [_btnContinue updateUI];
        _btnContinue.titleLabel.font = [Globals shared].defaultTextFont;
        _btnContinue.layer.cornerRadius = cornerRadius_6px;
        [_btnContinue setTitle:@"Continue." forState:UIControlStateNormal];
        _btnContinue.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_btnContinue addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnContinue;
}

- (ColoredButton *)btnRegister
{
    if (_btnRegister == nil)
    {
        CGRect rect = CGRectMake(self.viewRegister.contentInsets.left, self.viewRegister.contentInsets.top, self.viewRegister.contentWidth, self.viewRegister.contentHeight);

        _btnRegister = [ColoredButton coloredButtonType:ColoredButtonType_Blue frame:rect];
        [_btnRegister updateUI];
        [_btnRegister setTitle:@"Registered store phone number not avaliable ?" forState:UIControlStateNormal];
        _btnRegister.titleLabel.font = [Globals shared].defaultTextFont;
        _btnRegister.layer.cornerRadius = cornerRadius_6px;
        _btnRegister.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_btnRegister addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRegister;
}

- (UIBarButtonItem *)bbiLogin
{
    if (_bbiLogin == nil){
        _bbiLogin = [[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(onbbiLogin:)];
    }
    return _bbiLogin;
}

- (void) onBtnTap:(ColoredButton *)sender
{
    if ([sender isEqual:self.btnContinue])
    {
        [self continueLoginFlow];
    }
    else if ([sender isEqual:self.btnRegister])
    {
        [self registerUser];
    }
}

- (void) onbbiLogin:(UIBarButtonItem *)sender
{
    if (self.onLogin != nil)
    {
        self.onLogin();
    }
}

@end
