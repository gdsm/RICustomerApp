//
//  IconFontCodes.h
//  ReddyIce
//
//  Created by Gagan on 12/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IconFontCodes : NSObject

+ (IconFontCodes *) shared;

@property (nonatomic, weak, readonly) NSString* lock;
@property (nonatomic, weak, readonly) NSString* user;
@property (nonatomic, weak, readonly) NSString* userCircle;
@property (nonatomic, weak, readonly) NSString* userProfile;
@property (nonatomic, weak, readonly) NSString* fingurePrint;
@property (nonatomic, weak, readonly) NSString* fileText;
@property (nonatomic, weak, readonly) NSString* check;
@property (nonatomic, weak, readonly) NSString* barcode;
@property (nonatomic, weak, readonly) NSString* cart;
@property (nonatomic, weak, readonly) NSString* calendar;
@property (nonatomic, weak, readonly) NSString* share;
@property (nonatomic, weak, readonly) NSString* search;
@property (nonatomic, weak, readonly) NSString* image;
@property (nonatomic, weak, readonly) NSString* comment_text;
@end
