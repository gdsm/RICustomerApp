//
//  DeviceManager.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "DeviceManager.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface DeviceManager ()
@property (nonatomic, strong) LAContext* laContext;
@end

@implementation DeviceManager

+ (DeviceManager *) shared
{
    __strong static DeviceManager * _deviceManager_sharedInstance = nil;
    
    static dispatch_once_t deviceManager_SharedDispatchOnceToken = 0;
    dispatch_once(&deviceManager_SharedDispatchOnceToken, ^{
        _deviceManager_sharedInstance = [DeviceManager new];
    });
    
    return _deviceManager_sharedInstance;
}

#pragma mark - Fingure Print Scaning

- (BOOL) supportsFingureScanning
{
    BOOL retVal = NO;
    
    NSError* error = nil;
    if ([self.laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        retVal = YES;
    }
    
    return retVal;
}

- (void) scanFingurePrint:(blk_fingureScanResult)result
{
    __weak DeviceManager* weakSelf = self;
    NSString *reason = @"Touch ID to continue using this app";
    
    id reply = ^(BOOL success, NSError *error) {
        
        // Touch ID validation was successful
        if (success)
        {
            [weakSelf performSelectorOnMainThread:@selector(invalidateContext) withObject:nil waitUntilDone:NO];
        }
        result(error);

        // There shouldn't be any other potential errors, but just in case
        NSLog(@"%@", error.localizedDescription);
    };
    
    [self.laContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:reply];
}

- (void) invalidateContext
{
    [self.laContext invalidate];
    _laContext = nil;
}

- (LAContext *) laContext
{
    if (_laContext == nil)
    {
        _laContext = [[LAContext alloc] init];
    }
    return _laContext;
}

@end
