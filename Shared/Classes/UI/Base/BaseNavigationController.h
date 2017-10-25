//
//  BaseNavigationController.h
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockUtils.h"

@interface BaseNavigationController : UINavigationController

/**
 * @brief Would push the new view controller on the navigation controller. With safe push. It would make some cross checks to avoid crashes.
 * @param viewController : The new ViewController to be pushed.
 * @param animated : The new viewcontroller need to be pushed with animation or not.
 */
- (void) safePush:(nonnull UIViewController *)viewController
         animated:(BOOL)animated;
/**
 * @brief This is simply the counter part of above method
 */
- (void) unSafePush:(nonnull UIViewController *)viewController
           animated:(BOOL)animated;
/**
 * @brief Would present the new view controller on the navigation controller. With safe present. It would make some cross checks to avoid crashes.
 * @param callback : Completion Block
 */
- (void) safePresent:(nonnull UIViewController *)viewController
            animated:(BOOL)animated
  callbackCompletion:(nullable blk_completion)callback;
/**
 * @brief This is simply the counter part of above method
 * @param callback : Completion Block
 */
- (void) unSafePresent:(nonnull UIViewController *)viewController
              animated:(BOOL)animated
    callbackCompletion:(nullable blk_completion)callback;
/**
 * @brief Method would dismiss the presented view controller.
 * @param animated : Dismiss with animation or not
 * @param callback : Completion Block
 */
- (BOOL) safeDismissViewControllerAnimated:(BOOL)animated
                        callbackCompletion:(nullable blk_completion)callback;
@end
