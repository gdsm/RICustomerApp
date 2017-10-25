//
//  BaseViewController.h
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockUtils.h"
#import "LocalizedStrings.h"
#import "Globals.h"
#import "Utilities.h"
#import "IconFontCodes.h"
#import "BottomTabView.h"

extern const CGFloat BaseVC_BottomTabHeight;

@interface BaseViewController : UIViewController

/// @brief Method allows to setup any custom UI by ViewController.
- (void) setupUI;
@property (nonatomic) CGFloat navigationBarHeight;
@property (nonatomic) CGFloat statusBarHeight;
/// @brief Property will allow tableview to change content insets. By default this is true for iPhone.
@property (nonatomic) BOOL allowKeyboardNotifications;
- (void) keyboardDidShow:(nullable NSNotification *)notification;
- (void) keyboardDidHide:(nullable NSNotification *)notification;
- (CGSize) preferredContentSize;
- (void) dismissPopOversAnimated:(BOOL)animated;

@property (nonatomic, strong, nullable) UIImageView* bgImgv;
//@property (nonatomic, strong, nullable) UIBarButtonItem* bbiBack;
@property (nonatomic, strong, nullable) UIBarButtonItem* bbiCancel;
@property (nonatomic) BOOL showCancel;
- (void) onBBICancel:(nullable UIBarButtonItem *)sender;

@property (nonatomic, strong, nullable) BottomTabView* bottomTabView;

@property (nonatomic, strong, nullable) blk_completion removeCallback;


#pragma mark - Push/Present ViewControllers
/**
 * @brief This view controller is presented one or pushed one.
 * @return TRUE is presented FALSE if pushed
 */
- (BOOL) isPresentedViewController;
/**
 * @brief Navigation controller is presented one or pushed one.
 * @return TRUE is presented FALSE if pushed
 */
- (BOOL) isPresentedNavigationController;
/**
 * @brief Would push the new view controller on the navigation controller. With safe push. It would make some cross checks to avoid crashes.
 * @param viewController : The new ViewController to be pushed.
 * @param animated : The new viewcontroller need to be pushed with animation or not.
 */
- (void) safePush:(nonnull UIViewController *)viewController
         animated:(BOOL)animated;
/**
 * @brief This is simply the counter part of above method
 * @param viewController : The new ViewController to be pushed.
 * @param animated : The new viewcontroller need to be pushed with animation or not.
 */
- (void) unSafePush:(nonnull UIViewController *)viewController
           animated:(BOOL)animated;
/**
 * @brief Would present the new view controller on the navigation controller. With safe present. It would make some cross checks to avoid crashes.
 * @param onSelf : The new view controller to be presented on ViewController or on navigation Controller
 * @param callback : Completion Block
 */
- (void) safePresent:(nonnull UIViewController *)viewController
              onSelf:(BOOL)onSelf
            animated:(BOOL)animated
  callbackCompletion:(nullable blk_completion)callback;
/**
 * @brief This is simply the counter part of above method
 * @param onSelf : The new view controller to be presented on ViewController or on navigation Controller
 * @param callback : Completion Block
 */
- (void) unSafePresent:(nonnull UIViewController *)viewController
                onSelf:(BOOL)onSelf
              animated:(BOOL)animated
    callbackCompletion:(nullable blk_completion)callback;

/**
 * @brief Method would dismiss the presented view controller.
 * @param onSelf : true = self ; false = self.navigationController
 * @param animated : Dismiss with animation or not
 * @param callback : Completion Block
*/
- (BOOL) safeDismissViewControllerFromSelf:(BOOL)onSelf
                                  animated:(BOOL)animated
                        callbackCompletion:(nullable blk_completion)callback;

- (BOOL) unSafeDismissViewControllerFromSelf:(BOOL)onSelf
                                    animated:(BOOL)animated
                          callbackCompletion:(nullable blk_completion)callback;
@end
