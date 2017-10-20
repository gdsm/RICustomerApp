//
//  IconFontCodes.m
//  ReddyIce
//
//  Created by Gagan on 12/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "IconFontCodes.h"

@implementation IconFontCodes

+ (IconFontCodes *) shared
{
    __strong static IconFontCodes * _iconFontCodes_sharedInstance = nil;
    
    static dispatch_once_t _iconFontCode_SharedDispatchOnceToken = 0;
    dispatch_once(&_iconFontCode_SharedDispatchOnceToken, ^{
        _iconFontCodes_sharedInstance = [IconFontCodes new];
    });
    
    return _iconFontCodes_sharedInstance;
}

- (NSString *) lock
{
    return @"\uF191";
}

- (NSString *) user
{
    return @"\uf207";
}
- (NSString *) userCircle
{
    return @"\uF205";
}

- (NSString *) userProfile
{
    return @"\uE853";
}

- (NSString *) fingurePrint
{
    return @"\uE90D";
}

- (NSString *)fileText
{
    return @"\uF222";
}

- (NSString *)check
{
    return @"\uF26B";
}

- (NSString *) barcode
{
    return @"\uf317";
}

- (NSString *) cart
{
    return @"\uf1ca";
}

- (NSString *)calendar
{
    return @"\uf32f";
}

- (NSString *) share
{
    return @"\uf35b";
}

@end