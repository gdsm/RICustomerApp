//
//  ProblemSubmitConfirmationViewController.m
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ProblemSubmitConfirmationViewController.h"
#import "NotificationInfo.h"


@interface ProblemSubmitConfirmationViewController ()
@property (weak, nonatomic) IBOutlet BaseLabel *lblConfirmation;
@property (nonatomic, strong) UIBarButtonItem* bbiDone;
@end


@implementation ProblemSubmitConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupUI
{
    self.title = @"New Problem Request.";
    self.bgImgv.image = nil;
    self.bottomTabView.hidden = YES;
    
    self.navigationItem.backBarButtonItem = nil;
    
    [self.lblConfirmation defaultStyling];
    self.lblConfirmation.text = @"THANK YOU!\r\r\
    Your Equipment Service request is submitted successfully. One of our technician will contact you shortly.\r\
    If you would like immediate assistance, please call us at 1-000-000-0000.";
    self.navigationItem.rightBarButtonItem = self.bbiDone;
    
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) confirmationDone
{
    [[NSNotificationCenter defaultCenter] postNotificationName:noti_ProblemRequestSubmit object:nil userInfo:nil];
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
    [self confirmationDone];
}

@end
