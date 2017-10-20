//
//  JSONRequest.h
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONResult.h"
#import "JSONRequestErrorDelegate.h"


#define NCRErrorServerMaintenance -503


typedef void (^blk_responseCallback)(JSONResult* sender);


@interface JSONRequest : NSObject

- (id) initWithEndPoint:(NSString *)endPoint function:(NSString *)function parameters:(NSDictionary *)parameters completion:(blk_responseCallback)completion;

- (void) start;
- (void) cancel;

@property (nonatomic, strong) NSString *endPoint;
@property (nonatomic, strong) NSString *function;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, assign) NSTimeInterval timeout;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSURLSessionConfiguration* configuration;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, assign) int acctag;

@property (nonatomic, weak) id<JSONRequestErrorDelegate> errorDelegate;

@property (nonatomic, assign) NSTimeInterval devFabricatedDelay;
@property (nonatomic, assign) NSUInteger devFabricatedURLError;



@end
