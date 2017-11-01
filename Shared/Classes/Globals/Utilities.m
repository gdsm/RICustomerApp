//
//  Utilities.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "Utilities.h"
#import "MBProgressHUD.h"

@implementation Utilities

+ (Utilities *) shared
{
    __strong static Utilities * _utilities_sharedInstance = nil;
    
    static dispatch_once_t utilitiesSharedDispatchOnceToken = 0;
    dispatch_once(&utilitiesSharedDispatchOnceToken, ^{
        _utilities_sharedInstance = [[self alloc] init];
    });
    
    return _utilities_sharedInstance;
}

+ (BOOL) isiPad
{
    static BOOL isIPad = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    });
    return isIPad;
}

+ (UIView *)findFirstResonderIn:(UIView *)view
{
    if (view.isFirstResponder) {
        return view;
    }
    
    for (UIView *subView in view.subviews) {
        UIView *firstResponder = [Utilities findFirstResonderIn:subView];
        
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}


#pragma mark - Color

- (UIColor *) colorFromFloatRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    UIColor *retColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return retColor;
}
- (UIColor *) colorFromRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha
{
    UIColor *retColor = [self colorFromFloatRed:(((CGFloat)red)/255.0) green:(((CGFloat)green)/255.0) blue:(((CGFloat)blue)/255.0) alpha:(((CGFloat)alpha)/255.0)];
    return retColor;
}
- (UIColor *) colorFromHexRed:(NSString *)red green:(NSString *)green blue:(NSString *)blue alpha:(NSString *)alpha
{
    UIColor *retColor = [self colorFromRed:[self floatFromHex:red] green:[self floatFromHex:green] blue:[self floatFromHex:blue] alpha:[self floatFromHex:alpha]];
    return retColor;
}
- (unsigned) integerFromHex:(NSString *)hex
{
    unsigned retVal = 0;
    
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner scanHexInt:&retVal];
    scanner = nil;
    return retVal;
}
- (float) floatFromHex:(NSString *)hex
{
    float retVal = 0;
    if (![hex containsString:@"0x"])
    {
        hex = [NSString stringWithFormat:@"0x%@",hex];
    }
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner scanHexFloat:&retVal];
    scanner = nil;
    return retVal;
}


#pragma mark - MBProgressHud

- (void) showHud:(NSString *)msg onView:(UIView *)view
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    [MBProgressHUD HUDForView:view].mode = MBProgressHUDModeIndeterminate;
    [MBProgressHUD HUDForView:view].detailsLabelText = msg;
}

- (void) hideHudFromView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

- (void) showToast:(NSString *)msg onView:(UIView *)view timeDuration:(CGFloat)time
{
    [MBProgressHUD hideHUDForView:view animated:NO];
    
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    [MBProgressHUD HUDForView:view].mode = MBProgressHUDModeText;
    [MBProgressHUD HUDForView:view].detailsLabelText = msg;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * time), dispatch_get_main_queue(), ^{
        [self hideHudFromView:view];
    });
}

#pragma mark - Stirngs

- (NSUInteger) maxPhoneNumberDigits
{
    return 10;
}

@end
