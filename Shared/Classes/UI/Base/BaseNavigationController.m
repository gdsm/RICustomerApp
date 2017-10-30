//
//  BaseNavigationController.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseNavigationController.h"
#import "Utilities.h"
#import "Globals.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) safePush:(UIViewController *)view
         animated:(BOOL)animated
{
    if (view == nil)
    {
        return;
    }
    // [TODO] : Handling required to make it safe.
    if ([NSStringFromClass([view class]) isEqualToString:NSStringFromClass([self.topViewController class])])
    {
        // cannot push viewcontroller belong to same class.
        return;
    }
    [self pushViewController:view animated:animated];
}

- (void) unSafePush:(UIViewController *)view
           animated:(BOOL)animated
{
    [self pushViewController:view animated:animated];
}

- (void) safePresent:(UIViewController *)view
            animated:(BOOL)animated
  callbackCompletion:(blk_completion)callback
{
    if (view == nil)
    {
        return;
    }
    // [TODO] : Handling required to make it safe.
    BaseNavigationController* nav = [[BaseNavigationController alloc] initWithRootViewController:view];
    [self presentViewController:nav animated:animated completion:callback];
}

- (void) unSafePresent:(UIViewController *)view
              animated:(BOOL)animated
    callbackCompletion:(blk_completion)callback
{
    BaseNavigationController* nav = [[BaseNavigationController alloc] initWithRootViewController:view];
    [self presentViewController:nav animated:animated completion:callback];
}

- (BOOL) safeDismissViewControllerAnimated:(BOOL)animated
                        callbackCompletion:(nullable blk_completion)callback
{
    BOOL isSuccess = NO;
    UIViewController* view = self.presentedViewController;

    if ([view isKindOfClass:[UIAlertController class]])
    {
        return isSuccess;
    }
    else if (view.modalPresentationStyle == UIModalPresentationPopover)
    {
        return isSuccess;
    }
    
    [self dismissViewControllerAnimated:animated completion:callback];

    isSuccess = YES;
    return isSuccess;
}

@end
