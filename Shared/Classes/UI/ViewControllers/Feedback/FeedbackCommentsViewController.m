//
//  FeedbackCommentsViewController.m
//  ReddyIce
//
//  Created by Gagan on 27/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "FeedbackCommentsViewController.h"
#import "FeedbackConfirmationViewController.h"
#import "NotificationInfo.h"

@interface FeedbackCommentsViewController ()
@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) UIBarButtonItem* bbiSubmit;
@property (nonatomic, strong) UIBarButtonItem* bbiCamera;
@end

@implementation FeedbackCommentsViewController

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
    self.title = @"Optional Comments.";
    self.bgImgv.image = nil;
    self.bottomTabView.hidden = YES;
    
    [self.view addSubview:self.textView];
    
    self.navigationItem.rightBarButtonItem = self.bbiSubmit;
    self.navigationItem.backBarButtonItem = self.bbiBack;
    self.allowKeyboardNotifications = YES;
}

#pragma mark - Logical Flow Methods

- (void) submitFeedback
{
    FeedbackConfirmationViewController* view = [[FeedbackConfirmationViewController alloc] initWithStyle:UITableViewStylePlain];
    view.onDone = ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:noti_FeedbackRequestSubmit object:nil userInfo:nil];
    };
    
    [self safePush:view animated:YES];

    [view setNavTitle:@"Feedback Confirmation" title:@"Thank You" description:@"Thanks again for your participation.Your feedback will be incredibly useful in improving our product & services"];
}


#pragma mark - Notification Methods

- (void) keyboardDidShow:(nullable NSNotification *)notification
{
    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self layoutTextView:keyBoardFrame.size.height];
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

- (UITextView *)textView
{
    if (_textView == nil)
    {
        CGFloat top = self.navigationBarHeight + self.statusBarHeight + topMargin_20px;
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
    [self submitFeedback];
}

- (void) onbbiCamera:(UIBarButtonItem *)sender
{
    
}

@end
