//
//  NSCharacterSet+Additions.m
//  ReddyIce
//
//  Created by Gagan on 31/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "NSCharacterSet+Additions.h"

@implementation NSCharacterSet (Additions)

+ (NSCharacterSet *) phoneNumberCharacterSet
{
    NSCharacterSet* characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return characterSet;
}

@end
