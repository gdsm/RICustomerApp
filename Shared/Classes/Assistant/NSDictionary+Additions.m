//
//  NSDictionary+Additions.m
//  ReddyIce
//
//  Created by Gagan on 13/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)

- (NSString *) jsonString
{
    NSError* error = nil;
    NSString* json = nil;
    
    NSData* data = [self jsonData:&error];
    if (error != nil)
    {
        json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return json;
}

- (NSData *) jsonData:(NSError **)error
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:error];
    return jsonData;
}

@end
