//
//  RegistrationConfirmationViewController.m
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "RegistrationConfirmationViewController.h"
#import "CustomerCareView.h"


@interface RegistrationConfirmationViewController ()

@property (nonatomic, strong) UIBarButtonItem* bbiDone;
@property (weak, nonatomic) IBOutlet BaseLabel *lblTitle;
@property (weak, nonatomic) IBOutlet BaseLabel *lblDescription;
@property (nonatomic, strong) CustomerCareView* viewCustomerCare;

@end


@implementation RegistrationConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI
{
    self.title = @"Registration Confirmation";
    self.bgImgv.image = nil;
    self.tableView.hidden = YES;
    
    CGFloat top = (self.navigationBarHeight + self.statusBarHeight + topMargin_20px);
    self.tableOffset = UIEdgeInsetsMake(top, 0, 0, 0);
    
    self.navigationItem.rightBarButtonItem = self.bbiDone;
    self.navigationItem.hidesBackButton = YES;
    
    [self.lblTitle defaultStyling];
    [self.lblDescription defaultStyling];

    self.lblTitle.text = @"Thank you for registering with ReddyIce.";
    self.lblTitle.font = [Globals shared].boldTextFont;
    self.lblDescription.text = @"We will send an email to emailid@domain.com with one time password to activate your account";

    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    self.lblDescription.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:self.viewCustomerCare];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Logical Flow Methods

- (void) makeCall
{
    
}

- (void) makeMessage
{
    
}

#pragma mark - UI Methods

- (CustomerCareView *)viewCustomerCare
{
    if (_viewCustomerCare == nil)
    {
        __weak RegistrationConfirmationViewController* weakSelf = self;
        CGFloat top = self.view.frame.size.height - (CustomerCareView_Height + bottomMargin_20px);
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

- (UIBarButtonItem *) bbiDone
{
    if (_bbiDone == nil)
    {
        _bbiDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(onbbiDone:)];
    }
    return _bbiDone;
}

- (void) onbbiDone:(UIBarButtonItem *)sender
{
    [Globals shared].registrationRequired = NO;
    [self safeDismissViewControllerFromSelf:NO animated:YES callbackCompletion:nil];
}


@end
