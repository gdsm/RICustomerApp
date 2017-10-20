//
//  LandingViewController.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "LoginViewController.h"
#import "LogoView.h"
#import "IconTextField.h"
#import "AdditionalSecurityButtons.h"
#import "UserManager.h"
#import "ChangePasswordViewController.h"



const CGFloat loginVC_verticalMargin = 20;
const CGFloat loginVC_verticalLogoUserNameMargin = 30;
const CGFloat loginVC_verticalUserNamePwdMargin = 10;
const CGFloat loginVC_verticalPwdInfoMargin = 30;
const CGFloat loginVC_verticalInfoSecurityBtnsMargin = 10;
const CGFloat loginVC_horizontalMargin = 40;
const CGFloat loginVC_viewHeight = 50;
const CGFloat loginVC_infoHeight = 20;
const CGFloat loginVC_additionalInfoHeight = 44;
const CGFloat loginVC_usernameIconSize = 32;
const CGFloat loginVC_passwordIconSize = 26;



@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet LogoView *viewLogo;
@property (weak, nonatomic) IBOutlet IconTextField *iconFieldUserName;
@property (weak, nonatomic) IBOutlet IconTextField *iconFieldPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet AdditionalSecurityButtons *viewAdditionalSecurity;

@property (strong, nonatomic) ColoredButton* btnLogin;
@property (strong, nonatomic) UIBarButtonItem* bbiForgotPassword;
@end


@implementation LoginViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.allowKeyboardNotifications = YES;
    [self layoutLoginButton:loginVC_verticalMargin];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.allowKeyboardNotifications = NO;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) setupUI
{
    __weak LoginViewController* weakSelf = self;
    
    self.title = NSLocalizedString(lSS_Login, "Login");
    
    _viewLogo.backgroundColor = [UIColor clearColor];
    _viewLogo.imageName = @"RILogo.png";
    
    _iconFieldUserName.iconCode = [IconFontCodes shared].user;
    _iconFieldUserName.backgroundColor = [UIColor clearColor];
    _iconFieldUserName.textField.returnKeyType = UIReturnKeyNext;
    _iconFieldUserName.textField.delegate = self;
    _iconFieldUserName.placeHolderText = @"UserName";
    _iconFieldUserName.layer.borderColor = [Globals shared].themingAssistant.defaultBorderColor.CGColor;
    _iconFieldUserName.layer.borderWidth = 1;
    _iconFieldUserName.layer.cornerRadius = 5;
    _iconFieldUserName.lblIcon.font = [[Globals shared] iconFont:loginVC_usernameIconSize];

    _iconFieldPassword.iconCode = [IconFontCodes shared].lock;
    _iconFieldPassword.backgroundColor = [UIColor clearColor];
    _iconFieldPassword.textField.returnKeyType = UIReturnKeyDone;
    _iconFieldPassword.textField.delegate = self;
    _iconFieldPassword.placeHolderText = @"Password";
    _iconFieldPassword.layer.borderColor = [Globals shared].themingAssistant.defaultBorderColor.CGColor;
    _iconFieldPassword.layer.borderWidth = 1;
    _iconFieldPassword.layer.cornerRadius = 5;
    _iconFieldPassword.lblIcon.font = [[Globals shared] iconFont:loginVC_passwordIconSize];
    _iconFieldPassword.textField.secureTextEntry = YES;

    _lblInfo.text = @"Enable Security Authentication";
    _lblInfo.font = [[Globals shared] defaultInfoFont];
    _lblInfo.textColor = [Globals shared].themingAssistant.defaultTextColor;
    
    if ([UserManager shared].activeUser.hasAdditionalSecurity)
    {
        [_viewAdditionalSecurity layoutUI];
        
        _viewAdditionalSecurity.backgroundColor = [UIColor clearColor];
        _viewAdditionalSecurity.layer.borderColor = [Globals shared].themingAssistant.defaultBorderColor.CGColor;
        _viewAdditionalSecurity.layer.borderWidth = 1;
        _viewAdditionalSecurity.layer.cornerRadius = 5;
        _viewAdditionalSecurity.clipsToBounds = YES;

        _viewAdditionalSecurity.onPassCode = ^{
            [weakSelf showPasscode];
        };
        _viewAdditionalSecurity.onFingureScan = ^{
            [weakSelf showFingureScan];
        };
    }
    
    // currently login button is not there.
//    [self.view addSubview:self.btnLogin];
    
    self.navigationItem.rightBarButtonItem = self.bbiForgotPassword;
}


#pragma mark - Logical Flow

- (void) doLoginAttemp
{
    NSString* error = [[UserManager shared] attempLoginForUser:self.iconFieldUserName.textField.text
                                                  withPassword:self.iconFieldPassword.textField.text];
    
    if (error != nil)
    {
        [[Utilities shared] showToast:error onView:self.view timeDuration:2];
        return;
    }
    
    if (self.onSuccessfullLogin != nil)
    {
        self.onSuccessfullLogin();
    }
}

- (void) showPasscode
{
    
}

- (void) showFingureScan
{
    
}

- (void) forgotPassword
{
//    [[Utilities shared] showToast:@"Reset email send to your account" onView:self.view timeDuration:2];
    ChangePasswordViewController* view = [[ChangePasswordViewController alloc] initWithStyle:UITableViewStylePlain];
    [self safePush:view animated:YES];
}


#pragma mark - Layout UI

- (void) layoutUI
{
    CGRect rect_viewLogo = self.viewLogo.frame;
    CGRect rect_iconFieldUserName = self.iconFieldUserName.frame;
    CGRect rect_iconFieldPassword = self.iconFieldPassword.frame;
    CGRect rect_lblInfo = self.lblInfo.frame;
    CGRect rect_viewAdditionalSecurity = self.viewAdditionalSecurity.frame;

    CGFloat offsetY = loginVC_verticalMargin + self.navigationBarHeight + self.statusBarHeight;
    
    rect_viewLogo.origin.x = (self.view.frame.size.width - rect_viewLogo.size.width) * 0.5;
    rect_viewLogo.origin.y = offsetY;
    rect_viewLogo.size.width = logoViewWidth;
    rect_viewLogo.size.height = logoViewHeight;
    offsetY += (rect_viewLogo.size.height + loginVC_verticalLogoUserNameMargin);
    
    rect_iconFieldUserName.origin.x = loginVC_horizontalMargin;
    rect_iconFieldUserName.origin.y = offsetY;
    rect_iconFieldUserName.size.width = self.view.frame.size.width - (2*loginVC_horizontalMargin);
    rect_iconFieldUserName.size.height = loginVC_viewHeight;
    offsetY += (rect_iconFieldUserName.size.height + loginVC_verticalUserNamePwdMargin);

    rect_iconFieldPassword.origin.x = loginVC_horizontalMargin;
    rect_iconFieldPassword.origin.y = offsetY;
    rect_iconFieldPassword.size.width = self.view.frame.size.width - (2*loginVC_horizontalMargin);
    rect_iconFieldPassword.size.height = loginVC_viewHeight;
    offsetY += (rect_iconFieldPassword.size.height + loginVC_verticalPwdInfoMargin);

    rect_lblInfo.origin.x = loginVC_horizontalMargin;
    rect_lblInfo.origin.y = offsetY;
    rect_lblInfo.size.width = self.view.frame.size.width - (2*loginVC_horizontalMargin);
    rect_lblInfo.size.height = loginVC_infoHeight;
    offsetY += (rect_lblInfo.size.height + loginVC_verticalInfoSecurityBtnsMargin);

    rect_viewAdditionalSecurity.size.width = additionalSecurityButtons_width;
    rect_viewAdditionalSecurity.size.height = loginVC_additionalInfoHeight;
    rect_viewAdditionalSecurity.origin.x = (self.view.frame.size.width - rect_viewAdditionalSecurity.size.width) * 0.5;
    rect_viewAdditionalSecurity.origin.y = offsetY;
    offsetY += (rect_viewAdditionalSecurity.size.height + loginVC_verticalMargin);
    
    self.viewLogo.frame = rect_viewLogo;
    self.iconFieldUserName.frame = rect_iconFieldUserName;
    self.iconFieldPassword.frame = rect_iconFieldPassword;
    self.lblInfo.frame = rect_lblInfo;
    self.viewAdditionalSecurity.frame = rect_viewAdditionalSecurity;
}

- (void) layoutLoginButton:(CGFloat)bottomMargin
{
    CGRect rect_btnLogin = self.btnLogin.frame;

    rect_btnLogin.origin.x = loginVC_horizontalMargin;
    rect_btnLogin.origin.y = self.view.frame.size.height - rect_btnLogin.size.height - bottomMargin;
    rect_btnLogin.size.width = self.view.frame.size.width - (2*loginVC_horizontalMargin);
    rect_btnLogin.size.height = loginVC_viewHeight;
    
    self.btnLogin.frame = rect_btnLogin;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    [self layoutUI];
    
    [self.iconFieldPassword layoutUI];
    [self.iconFieldUserName layoutUI];
    [self.viewAdditionalSecurity layoutUI];
}

- (ColoredButton *) btnLogin
{
    if (_btnLogin == nil)
    {
        _btnLogin = [ColoredButton coloredButtonType:ColoredButtonType_Green frame:CGRectMake(0, 500, loginVC_viewHeight, loginVC_viewHeight)];
        [_btnLogin setTitle:@"Login" forState:UIControlStateNormal];
        [_btnLogin addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLogin;
}

- (UIBarButtonItem *)bbiForgotPassword
{
    if (_bbiForgotPassword == nil)
    {
        _bbiForgotPassword = [[UIBarButtonItem alloc] initWithTitle:@"Forgot ?" style:UIBarButtonItemStylePlain target:self action:@selector(onbbiForgotPassword:)];
    }
    return _bbiForgotPassword;
}

#pragma mark - Listeners

- (void)keyboardDidHide:(NSNotification *)notification
{
    [self layoutLoginButton:loginVC_verticalMargin];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self layoutLoginButton:keyBoardFrame.size.height + loginVC_verticalMargin];
}

- (void) onbbiForgotPassword:(UIBarButtonItem *)bbi
{
    [self forgotPassword];
}

- (void) onBtnTap:(ColoredButton *)sender
{
    if ([sender isEqual:self.btnLogin])
    {
        [self doLoginAttemp];
    }
}

#pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([textField isEqual:self.iconFieldUserName.textField])
    {
        [self.iconFieldPassword.textField becomeFirstResponder];
    }
    else if ([textField isEqual:self.iconFieldPassword.textField])
    {
        [self doLoginAttemp];
    }
    return YES;
}

@end
