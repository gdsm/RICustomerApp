//
//  JSONRequest.m
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "JSONRequest.h"
#import "Globals.h"
#import "Utilities.h"
#import "CoreService.h"
#import "NSDictionary+Additions.h"

const CGFloat JSONRequest_Timeout = 60.0;
const NSString* JSONRequest_kURLConnection = @"kURLConnection";


@interface JSONRequest () <NSURLSessionDataDelegate>
{
    NSInteger responseCode;
}
@property (nonatomic, strong) blk_responseCallback responseCallback;
@end


@implementation JSONRequest

@synthesize acctag = _acctag, data = _data, function = _function, parameters = _parameters, endPoint = _endPoint;

- (id) initWithEndPoint:(NSString *)endPoint
               function:(NSString *)function
             parameters:(NSDictionary *)parameters
{
    self = [super init];
    if (self != nil)
    {
        self.endPoint = endPoint;
        self.function = function;
        self.parameters = parameters;
        _timeout = JSONRequest_Timeout;
    }
    return self;
}

- (id) initWithEndPoint:(NSString *)endPoint
               function:(NSString *)function
             parameters:(NSDictionary *)parameters
             completion:(blk_responseCallback)completion
{
    self = [self initWithEndPoint:endPoint function:function parameters:parameters];
    if (self != nil)
    {
        self.responseCallback = completion;
    }
    return self;
}

- (NSURLSession *) session
{
    if (_session == nil)
    {
        _session = [NSURLSession sessionWithConfiguration:self.configuration delegate:self delegateQueue:nil];
    }
    return _session;
}

- (NSURLSessionConfiguration *) configuration
{
    if (_configuration == nil)
    {
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _configuration.timeoutIntervalForRequest = self.timeout;
    }
    return _configuration;
}

- (void) initConnection
{
    NSString* hostAddr = [CoreService shared].hostAddress;
    if ((hostAddr == nil) || (self.endPoint == nil) || (self.function == nil))
    {
        // TODO:[GM]: Log error here.
        // Cannot request connection with nil params.
        return;
    }
    NSString* strUrl = [NSString stringWithFormat:@"%@/%@/%@", hostAddr, self.endPoint, self.function];
    NSURL* url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:self.timeout];
    
    [request setHTTPMethod:@"POST"];
    
    if ([CoreService shared].sessionKey != nil)
	{
        [request setValue:[CoreService shared].sessionKey forHTTPHeaderField:@"TransportSessionKey"];
    }
    
    if (self.parameters)
    {
        NSError *error = nil;
        NSData *jsonData = [self.parameters jsonData:&error];
        if (!error)
        {
            [request setHTTPBody:jsonData];
        }
        else
        {
            NSLog(@"Error serializing request!: %@", [error description]);
        }
    }
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:[NSString stringWithFormat:@"%li", (unsigned long)[request.HTTPBody length]] forHTTPHeaderField:@"Content-Length"];
    
    NSURLSession* session = self.session;
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil)
        {
            [self performSelectorOnMainThread:@selector(connectionError:) withObject:error waitUntilDone:NO];
        }
        else
        {
            if (!self.data)
            {
                self.data = [NSMutableData data];
            }
            [self.data appendData:data];
            
            [self performSelectorOnMainThread:@selector(connectionFinished:) withObject:self.data waitUntilDone:NO];
        }
    }];
    
    [dataTask resume];
    self.dataTask = dataTask;
}

- (void) start
{
    [self initConnection];
}

- (void) cancel
{
    if (self.dataTask != nil)
    {
        [self.dataTask cancel];
        self.dataTask = nil;
    }
}

- (NSError *) translatedError:(NSError *)error
{
    if (self.errorDelegate)
    {
        NSError *translatedError = [self.errorDelegate jsonRequest:self translatedErrorFromError:error];
        if (translatedError)
        {
            return translatedError;
        }
    }
    
    NSMutableDictionary *userInfoDict = [[error userInfo] mutableCopy];
    
    if (!userInfoDict)
    {
        userInfoDict = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    
    if (error.domain == NSURLErrorDomain && error.code == NSURLErrorTimedOut)
    {
        [userInfoDict setObject:NSLocalizedString(lSS_Network_request_timed_out, "Network request timed out") forKey:NSLocalizedDescriptionKey];
    }
    
    return [NSError errorWithDomain:error.domain code:error.code userInfo:[NSDictionary dictionaryWithDictionary:userInfoDict]];
}

- (void) connectionFinished:(NSData *)data
{
    JSONResult *result = [[JSONResult alloc] initWithJSON:data request:self];
    result.HTTPStatusCode = responseCode;
    if (self.responseCallback)
    {
        self.responseCallback(result);
    }
}

- (void) connectionError:(NSError *)error
{
    NSError *translatedError = [self translatedError:error];
    
    JSONResult *result = [[JSONResult alloc] initWithJSON:nil request:self];
    result.FailureReason = JRFailureNetwork;
    result.URLErrorCode = [translatedError code];
    result.Message = [translatedError localizedDescription];
    if (self.responseCallback)
    {
        self.responseCallback(result);
    }
}


#pragma mark - Dealloc

-(void) dealloc
{
    [self cancel];
}

@end
