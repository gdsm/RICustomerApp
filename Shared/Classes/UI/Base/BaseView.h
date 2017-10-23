//
//  BaseView.h
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLabel.h"

extern const CGFloat viewContentInset_top;
extern const CGFloat viewContentInset_left;
extern const CGFloat viewContentInset_bottom;
extern const CGFloat viewContentInset_right;

@interface BaseView : UIView

/// @brief Method will layout the UI. Child Classes would use this to layout the UI.
- (void) layoutUI;
/// @brief Update any ui.
- (void) updateUI;
- (void) listenNotifications;
- (void) removeNotifications;

@property (nonatomic) UIEdgeInsets contentInsets;
@property (nonatomic) CGFloat contentWidth;
@property (nonatomic) CGFloat contentHeight;
- (BaseLabel *) getBaseLabel;
- (UILabel *) getLabel;

@end
