//
//  ItemManager.m
//  ReddyIce
//
//  Created by Gagan on 13/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ItemManager.h"

@implementation ItemManager

+ (ItemManager *) shared
{
    __strong static ItemManager * _itemManager_sharedInstance = nil;
    
    static dispatch_once_t itemManager_SharedDispatchOnceToken = 0;
    dispatch_once(&itemManager_SharedDispatchOnceToken, ^{
        _itemManager_sharedInstance = [ItemManager new];
    });
    
    return _itemManager_sharedInstance;
}

@end
