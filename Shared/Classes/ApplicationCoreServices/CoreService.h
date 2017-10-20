//
//  CoreService.h
//  ReddyIce
//
//  Created by Gagan on 13/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreService : NSObject

+ (CoreService *) shared;

@property (nonatomic, strong) NSString* hostAddress;
@property (nonatomic, strong) NSString* sessionKey;

- (void) initializeListeners;

@end
