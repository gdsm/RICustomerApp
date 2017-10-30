//
//  LaunchViewController.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "LaunchViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "TOPasscodeViewController.h"
#import "RegistrationViewController.h"
#import "Globals.h"
#import "TouchIdView.h"
#import "DeviceManager.h"
#import "UserManager.h"

@interface LaunchViewController () <TOPasscodeViewControllerDelegate>
@property (strong, nonatomic) TouchIdView *viewTouchId;
@end

@implementation LaunchViewController
{
    BOOL checkFreshnessOnce;
}

#pragma mark - View Life Cycle Method

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (checkFreshnessOnce == NO)
    {
        checkFreshnessOnce = YES;
        [self checkAppFreshness];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) checkAppFreshness
{
    if (0)//([Globals shared].registrationRequired)
    {
        [self showRegistration];
        checkFreshnessOnce = NO;
    }
    else if (![Globals shared].anyActiveUser)
    {
        [self enterPassword];
    }
    else if ([Globals shared].isSessionExpired && [UserManager shared].activeUser.hasAdditionalSecurity)
    {
        [self showAdditionalSecurity];
    }
    else
    {
        [self enterMainScreen];
    }
}


#pragma mark - Logical Flow

- (void) enterPassword
{
    __weak LaunchViewController* weakSelf = self;

    LoginViewController* view = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
    view.onSuccessfullLogin = ^{
        [weakSelf performSelectorOnMainThread:@selector(enterMainScreen) withObject:nil waitUntilDone:NO];
    };
    [self safePresent:view onSelf:NO animated:NO callbackCompletion:nil];
}

- (void) enterMainScreen
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    MainViewController* view = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
    [self safePush:view animated:YES];
}

- (void) showAdditionalSecurity
{
    switch ([UserManager shared].activeUser.userSecurityType)
    {
        case UserAdditionalSecurityType_Passcode:{
            [self showPascode];
        }break;
        case UserAdditionalSecurityType_Fingure:{
            [self showTouchID];
        }break;
        default:{
        }break;
    }
}

- (void) showTouchID
{
    //TODO:[GM]: localisation;
    self.viewTouchId.hidden = NO;
    self.title = @"Touch ID";
    [self layoutUI];
    
    [[DeviceManager shared] scanFingurePrint:^(NSError* error) {
        NSLog(@"Passcode Success : %@", error);
        // The user hit 'Enter Password'. This should probably do nothing

//        if (error.code == kLAErrorUserFallback)
//        {
//            NSLog(@"User tapped 'Enter Password'");
//            return;
//        }
//        // The user hit the 'Cancel' button in the Touch ID dialog.
//        // At this point, you could either simply return the user to the passcode controller,
//        if (error.code == LAErrorUserCancel)
//        {
//            NSLog(@"User tapped cancel.");
//            return;
//        }
    }];
}

- (void) showRegistration
{
    RegistrationViewController* view = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:nil];
    [self unSafePresent:view onSelf:NO animated:YES callbackCompletion:nil];
}

- (void) showPascode
{
    TOPasscodeViewController *view = [[TOPasscodeViewController alloc] initWithStyle:TOPasscodeViewStyleOpaqueLight passcodeType:TOPasscodeTypeFourDigits];
    view.delegate = self;
    view.allowBiometricValidation = NO;
    [self unSafePresent:view onSelf:YES animated:YES callbackCompletion:nil];
}


#pragma mark - Passcode Delegate

- (BOOL) passcodeViewController:(TOPasscodeViewController *)passcodeViewController isCorrectCode:(NSString *)code
{
    return [code isEqualToString:[UserManager shared].activeUser.passcode];
}

- (void)didInputCorrectPasscodeInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController
{
    __weak LaunchViewController* weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [weakSelf enterMainScreen];
    }];
}

- (void)didTapCancelInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController
{
    __weak LaunchViewController* weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        [weakSelf enterPassword];
    }];
}

#pragma mark - UI Elements

- (TouchIdView *)viewTouchId
{
    if (_viewTouchId == nil)
    {
        __weak LaunchViewController* weakSelf = self;
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"TouchIdView" owner:self options:nil];
        if ((views != nil) && (views.count > 0))
        {
            _viewTouchId = [views objectAtIndex:0];
            [_viewTouchId updateUI];
            _viewTouchId.hidden = YES;
            _viewTouchId.backgroundColor = [UIColor clearColor];
            _viewTouchId.onEnterPassword = ^(id sender) {
                [weakSelf enterPassword];
            };
            
            [self.view addSubview:_viewTouchId];
        }
    }
    return _viewTouchId;
}


#pragma mark - Layout Methods

- (void) layoutUI
{
    CGRect rect_viewTouchId = self.viewTouchId.frame;
    rect_viewTouchId = self.view.bounds;
    rect_viewTouchId.origin.y = (self.navigationBarHeight + self.statusBarHeight);
    rect_viewTouchId.size.height = self.view.frame.size.height - rect_viewTouchId.origin.y;
    self.viewTouchId.frame = rect_viewTouchId;
    
    [self.viewTouchId layoutUI];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self layoutUI];
}


@end
