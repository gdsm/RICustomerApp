//
//  NSData+Additions.m
//  ReddyIce
//
//  Created by Gagan on 13/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "NSData+Additions.h"

@implementation NSData (Additions)

- (NSDictionary *) jsonDictionary:(NSError **)error
{
    NSDictionary* retVal = nil;
    retVal = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:error];
    return retVal;
}

@end
