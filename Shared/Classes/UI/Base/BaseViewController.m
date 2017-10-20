//
//  BaseViewController.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "Utilities.h"

const CGFloat BaseVC_BottomTabHeight = 60;
static BottomTabView* _static_btmTabView = nil;

@interface BaseViewController ()
@end

@implementation BaseViewController
{
    BOOL _keyboardListenersAdded;
    BOOL _allowKeyboardNotifications;
}


#pragma mark - View Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [Globals shared].themingAssistant.defaultViewBGColor;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupUI
{
    // child class override this.
}

- (CGFloat) navigationBarHeight
{
    CGFloat retVal = self.navigationController.navigationBar.frame.size.height;
    return retVal;
}

- (CGFloat) statusBarHeight
{
    CGFloat retVal = 20;
    return retVal;
}


#pragma mark - Listeners

- (void) addKeyboardListeners
{
    if (!_keyboardListenersAdded)
    {
        _keyboardListenersAdded = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
        if (self.allowKeyboardNotifications)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        }
    }
}

- (void) removeKeyboardNotifications
{
    _keyboardListenersAdded = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

- (void) setAllowKeyboardNotifications:(BOOL)allowKeyboardNotifications
{
    _allowKeyboardNotifications = allowKeyboardNotifications;
    [self removeKeyboardNotifications];
    if (_allowKeyboardNotifications)
    {
        [self addKeyboardListeners];
    }
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    // child class use this.
}

- (void) keyboardDidHide:(NSNotification *)notification
{
    // child class use this.
}


#pragma mark - Layout Methods

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (self.bgImgv.hidden == NO)
    {
        self.bgImgv.frame = self.view.bounds;
    }
    
    if ((_bottomTabView != nil) && (_bottomTabView.hidden == NO))
    {
        CGRect rect_bottomTabView = _bottomTabView.frame;

        rect_bottomTabView.origin.y = self.view.frame.size.height - rect_bottomTabView.size.height;
        rect_bottomTabView.size.width = self.view.frame.size.width;

        _bottomTabView.frame = rect_bottomTabView;
        [_bottomTabView layoutUI];
    }
}


#pragma mark - UI Methods

- (UIImageView *)bgImgv
{
    if (_bgImgv == nil)
    {
        _bgImgv = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _bgImgv.contentMode = UIViewContentModeScaleAspectFill;
        _bgImgv.clipsToBounds = YES;
        _bgImgv.image = [UIImage imageNamed:@"Background.png"];
        _bgImgv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _bgImgv.backgroundColor = [Globals shared].themingAssistant.itemVCBgColor;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [_bgImgv addGestureRecognizer:tap];
        [self.view insertSubview:_bgImgv atIndex:0];
    }
    return _bgImgv;
}

- (void) onTap:(UITapGestureRecognizer *)sender
{
    [[Utilities findFirstResonderIn:self.view] resignFirstResponder];
}

- (BottomTabView *) bottomTabView
{
    if (_bottomTabView == nil)
    {
        if (_static_btmTabView == nil)
        {
            CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, BaseVC_BottomTabHeight);
            _static_btmTabView = [[BottomTabView alloc] initWithFrame:rect];
            [_static_btmTabView updateUI];
        }
        _bottomTabView = _static_btmTabView;
        _bottomTabView.backgroundColor = [UIColor whiteColor];
        _bottomTabView.layer.shadowColor = [UIColor blackColor].CGColor;
        _bottomTabView.layer.shadowOffset = CGSizeMake(0, -1);
        _bottomTabView.layer.shadowRadius = 2;
        _bottomTabView.layer.shadowOpacity = 0.5;
        _bottomTabView.hidden = YES;

        [self.navigationController.view addSubview:_bottomTabView];
    }
    return _bottomTabView;
}


#pragma mark - Push/Present ViewControllers

- (void) safePush:(UIViewController *)view
         animated:(BOOL)animated
{
    UINavigationController* navController = self.navigationController;
    if ([navController isKindOfClass:[BaseNavigationController class]])
    {
        BaseNavigationController* baseNav = (BaseNavigationController *)navController;
        [baseNav safePush:view animated:animated];
    }
    else
    {
        [navController pushViewController:view animated:animated];
    }
}

- (void) unSafePush:(UIViewController *)view
           animated:(BOOL)animated
{
    UINavigationController* navController = self.navigationController;
    if ([navController isKindOfClass:[BaseNavigationController class]])
    {
        BaseNavigationController* baseNav = (BaseNavigationController *)navController;
        [baseNav unSafePush:view animated:animated];
    }
    else
    {
        [navController pushViewController:view animated:animated];
    }
}

- (void) safePresent:(UIViewController *)view
              onSelf:(BOOL)onSelf
            animated:(BOOL)animated
  callbackCompletion:(blk_completion)callback
{
    if (onSelf)
    {
        [self presentViewController:view animated:animated completion:callback];
    }
    else
    {
        UINavigationController* navController = self.navigationController;
        if ([navController isKindOfClass:[BaseNavigationController class]])
        {
            BaseNavigationController* baseNav = (BaseNavigationController *)navController;
            [baseNav safePresent:view animated:animated callbackCompletion:callback];
        }
        else
        {
            [navController presentViewController:view animated:animated completion:callback];
        }
    }
}

- (void) unSafePresent:(nonnull UIViewController *)view
                onSelf:(BOOL)onSelf
              animated:(BOOL)animated
    callbackCompletion:(nullable blk_completion)callback
{
    if (onSelf)
    {
        [self presentViewController:view animated:animated completion:callback];
    }
    else
    {
        UINavigationController* navController = self.navigationController;
        if ([navController isKindOfClass:[BaseNavigationController class]])
        {
            BaseNavigationController* baseNav = (BaseNavigationController *)navController;
            [baseNav unSafePresent:view animated:animated callbackCompletion:callback];
        }
        else
        {
            [navController presentViewController:view animated:animated completion:callback];
        }
    }
}

@end
