//
//  DeviceManager.h
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^blk_fingureScanResult)(NSError* error);

@interface DeviceManager : NSObject

+ (DeviceManager *) shared;

- (BOOL) supportsFingureScanning;
- (void) scanFingurePrint:(blk_fingureScanResult)result;
- (void) invalidateContext;

@end
