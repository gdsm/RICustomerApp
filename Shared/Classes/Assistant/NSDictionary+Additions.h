//
//  NSDictionary+Additions.h
//  ReddyIce
//
//  Created by Gagan on 13/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

- (NSString *) jsonString;
- (NSData *) jsonData:(NSError **)error;

@end
