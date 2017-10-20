//
//  JSONRequest.h
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JRFailureReason) {
    JRFailureOther = 0,
    JRFailureNetwork,
    JRFailureWCFRequestError
} ;

@class JSONRequest;

@interface JSONResult : NSObject

- (id) initWithJSON:(NSData *)json request:(JSONRequest *)request;

@property (nonatomic, assign) BOOL IsSuccessful;
@property (nonatomic, assign) JRFailureReason FailureReason;
@property (nonatomic, assign) NSUInteger URLErrorCode;
@property (nonatomic, assign) NSInteger HTTPStatusCode;
@property (nonatomic, assign) NSInteger ErrorCode;
@property (nonatomic, strong) NSString *Message;
@property (nonatomic, readonly) NSDictionary *Entity;
@property (nonatomic, strong) NSDictionary *Result;
@property (nonatomic, weak) JSONRequest *Request;
@property (nonatomic, assign) BOOL isProperlyFormatted;

@end
