//
//  Utilities.h
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utilities : NSObject

+ (Utilities *) shared;

+ (BOOL) isiPad;

+ (UIView *)findFirstResonderIn:(UIView *)view;

+ (BOOL) demoMode;


#pragma mark - Color

- (UIColor *) colorFromFloatRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *) colorFromRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha;
- (UIColor *) colorFromHexRed:(NSString *)red green:(NSString *)green blue:(NSString *)blue alpha:(NSString *)alpha;

#pragma mark - MBProgressHud

- (void) showHud:(NSString *)msg onView:(UIView *)view;
- (void) hideHudFromView:(UIView *)view;
- (void) showToast:(NSString *)msg onView:(UIView *)view timeDuration:(CGFloat)time;

#pragma mark - Stirngs

- (NSUInteger) maxPhoneNumberDigits;

@end
