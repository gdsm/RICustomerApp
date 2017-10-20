//
//  DataSyncManager.m
//  ReddyIce
//
//  Created by Gagan on 18/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "DataSyncManager.h"

@implementation DataSyncManager

+ (DataSyncManager *) shared
{
    __strong static DataSyncManager * _dataSyncManager_sharedInstance = nil;
    
    static dispatch_once_t dataSyncManager_SharedDispatchOnceToken = 0;
    dispatch_once(&dataSyncManager_SharedDispatchOnceToken, ^{
        _dataSyncManager_sharedInstance = [DataSyncManager new];
    });
    
    return _dataSyncManager_sharedInstance;
}

@end
