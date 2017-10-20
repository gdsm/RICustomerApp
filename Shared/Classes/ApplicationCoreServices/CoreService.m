//
//  CoreService.m
//  ReddyIce
//
//  Created by Gagan on 13/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CoreService.h"

@implementation CoreService

+ (CoreService *) shared
{
    __strong static CoreService * _cs_sharedInstance = nil;
    
    static dispatch_once_t _cs_SharedDispatchOnceToken = 0;
    dispatch_once(&_cs_SharedDispatchOnceToken, ^{
        _cs_sharedInstance = [CoreService new];
    });
    
    return _cs_sharedInstance;
}

- (NSString *) hostAddress
{
    if (_hostAddress == nil)
    {
#ifdef DDEV_MODE
        _hostAddress = @"https://private-89e4d7-reddyice1.apiary-mock.com";
#endif
    }
    return _hostAddress;
}

- (NSString *)sessionKey
{
    if (_sessionKey == nil)
    {
    }
    return _sessionKey;
}

@end
