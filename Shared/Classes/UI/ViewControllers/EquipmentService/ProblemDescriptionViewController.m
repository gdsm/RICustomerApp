//
//  ProblemDescriptionViewController.m
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ProblemDescriptionViewController.h"
#import "ProblemSubmitConfirmationViewController.h"
#import "OrderConfirmationViewController.h"
#import "CategoryDetailView.h"

const CGFloat ProblemDescrVC_equipment_height = 50;
const CGFloat ProblemDescrVC_category_height = 50;

@interface ProblemDescriptionViewController ()
@property (nonatomic, strong) CategoryDetailView* viewEquipment;
@property (nonatomic, strong) CategoryDetailView* viewCategory;
@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) UIBarButtonItem* bbiSubmit;
@property (nonatomic, strong) UIBarButtonItem* bbiCamera;
@end

@implementation ProblemDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI
{
    self.title = @"New Problem Request.";
    self.bgImgv.image = nil;
    self.bottomTabView.hidden = YES;
    
    [self.view addSubview:self.viewEquipment];
    [self.view addSubview:self.viewCategory];
    [self.view addSubview:self.textView];
    
    self.navigationItem.rightBarButtonItem = self.bbiSubmit;
    self.allowKeyboardNotifications = YES;
}

#pragma mark - Logical Flow Methods

- (void) submitProblem
{
    // Equipment repair is also an order.
    OrderConfirmationViewController* view = [[OrderConfirmationViewController alloc] initWithNibName:@"OrderConfirmationViewController" bundle:nil];
    [self safePresent:view onSelf:NO animated:YES callbackCompletion:nil];
    view.equipmentRepair = YES;
//    ProblemSubmitConfirmationViewController* view = [[ProblemSubmitConfirmationViewController alloc] init];
//    [self safePush:view animated:YES];
}

#pragma mark - Notification Methods

- (void) keyboardDidShow:(nullable NSNotification *)notification
{
    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self layoutTextView:keyBoardFrame.size.height];

//    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
//    [keyboardToolbar sizeToFit];
//    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
//                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                      target:nil action:nil];
//    keyboardToolbar.items = @[flexBarButton, self.bbiCamera];
//    self.textView.inputAccessoryView = keyboardToolbar;
}

- (void) keyboardDidHide:(nullable NSNotification *)notification
{
    [self layoutTextView:bottomMargin_20px];
}

#pragma mark - Layout Methods

- (void) layoutTextView:(CGFloat)bottomMargin
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect_textView = self.textView.frame;
        rect_textView.size.height = (self.view.frame.size.height - (rect_textView.origin.y + bottomMargin));
        self.textView.frame = rect_textView;
    }];
}

#pragma mark - UI Methods

- (CategoryDetailView *) viewEquipment
{
    if (_viewEquipment == nil)
    {
        CGFloat top = (self.navigationBarHeight + self.statusBarHeight);
        CGRect rect = CGRectMake(0, top, self.view.frame.size.width, ProblemDescrVC_equipment_height);
        _viewEquipment = [[CategoryDetailView alloc] initWithFrame:rect];
        _viewEquipment.category = @"Equipment";
        _viewEquipment.detail = @"Reason";
        _viewEquipment.lblCategory.textColor = [UIColor lightGrayColor];
        _viewEquipment.lblDetail.textColor = [UIColor lightGrayColor];
        _viewEquipment.lblCategory.textAlignment = NSTextAlignmentLeft;
        _viewEquipment.lblDetail.textAlignment = NSTextAlignmentRight;
        _viewEquipment.backgroundColor = [Globals shared].themingAssistant.blueNorm;
        _viewEquipment.lblCategory.font = [Globals shared].defaultInfoFont;
        _viewEquipment.lblDetail.font = [Globals shared].defaultInfoFont;
        
        _viewEquipment.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [_viewEquipment updateUI];
    }
    return _viewEquipment;
}

- (CategoryDetailView *) viewCategory
{
    if (_viewCategory == nil)
    {
        CGFloat top = (self.viewEquipment.frame.origin.y + self.viewEquipment.frame.size.height);
        CGRect rect = CGRectMake(0, top, self.view.frame.size.width, ProblemDescrVC_equipment_height);
        _viewCategory = [[CategoryDetailView alloc] initWithFrame:rect];
        _viewCategory.category = @"In Line Freezer";
        _viewCategory.detail = @"Equipment repair";
        _viewCategory.lblCategory.textColor = [UIColor whiteColor];
        _viewCategory.lblDetail.textColor = [UIColor whiteColor];
        _viewCategory.lblCategory.textAlignment = NSTextAlignmentLeft;
        _viewCategory.lblDetail.textAlignment = NSTextAlignmentRight;
        _viewCategory.backgroundColor = [Globals shared].themingAssistant.blueNorm;
        
        _viewCategory.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [_viewCategory updateUI];
    }
    return _viewCategory;
}

- (UITextView *)textView
{
    if (_textView == nil)
    {
        CGFloat top = (self.viewCategory.frame.origin.y + self.viewCategory.frame.size.height + topMargin_20px);
        CGRect rect = CGRectMake(leftMargin_20px, top, self.view.frame.size.width - (leftMargin_20px + rightMargin_20px), self.view.frame.size.height - (top + bottomMargin_20px));
        _textView = [[UITextView alloc] initWithFrame:rect];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.layer.borderColor = [Globals shared].themingAssistant.defaultBorderColor.CGColor;
        _textView.layer.borderWidth = 1;
        _textView.font = [Globals shared].defaultTextFont;
        _textView.layer.cornerRadius = cornerRadius_20px;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    }
    return _textView;
}

- (UIBarButtonItem *) bbiSubmit
{
    if (_bbiSubmit == nil)
    {
        _bbiSubmit = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(onbbiSubmit:)];
    }
    return _bbiSubmit;
}

- (UIBarButtonItem *) bbiCamera
{
    if (_bbiCamera == nil)
    {
        _bbiCamera = [[UIBarButtonItem alloc] initWithTitle:@"Camera" style:UIBarButtonItemStylePlain target:self action:@selector(onbbiCamera:)];
    }
    return _bbiCamera;
}

- (void) onbbiSubmit:(UIBarButtonItem *)sender
{
    [self submitProblem];
}

- (void) onbbiCamera:(UIBarButtonItem *)sender
{
    
}

@end
