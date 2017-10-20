//
//  JSONRequest.h
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "JSONResult.h"
#import "NSData+Additions.h"
#import "Globals.h"

@implementation JSONResult

@synthesize IsSuccessful = _IsSuccessful, ErrorCode = _ErrorCode, Message = _Message, Result = _Result, Request = _Request, FailureReason = _FailureReason;

- (id) initWithJSON:(NSData *)json request:(JSONRequest *)request
{
    if ((self = [super init]))
    {
        self.Request = request;
        NSError *error = nil;
        NSDictionary *dictionary = [json jsonDictionary:&error];
        if (!error)
        {
            self.IsSuccessful = [[dictionary objectForKey:@"IsSuccessful"] boolValue];
            self.ErrorCode = [[dictionary objectForKey:@"ErrorCode"] intValue];
            self.Message = [dictionary objectForKey:@"Message"];
            self.Result = dictionary;
            
            if ([dictionary objectForKey:@"IsSuccessful"])
            {
                // as long as this even includes an IsSuccessful, we know the server is awake and understood the request
                self.isProperlyFormatted = YES;
            }
        }
        else
        {
            @try
            {
                NSString *str = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
                
                if ([str rangeOfString:@"The server encountered an error processing the request"].location != NSNotFound)
                {
                    self.FailureReason = JRFailureWCFRequestError;
                }
                else
                {
                    self.Message = NSLocalizedString(lSS_There_was_an_error_on_the_server__Please_try_again_later, "There was an error on the server. Please try again later");
                }
            }
            @catch (NSException *ex)
            {
                //TODO:[GM]: Add logs
            }
        }
    }
    
    return self;
}

- (NSDictionary *) Entity
{
    return [self.Result objectForKey:@"Entity"];
}


@end
