//
//  CoreObject.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreObject : NSObject

- (NSDictionary *) toDictionary;
/// @brief converts the properties into dictionary and nil values to some safe value.
- (NSDictionary *) nonnullDictionary;
- (void) updateWithDictionary:(NSDictionary *)dictionary;

@end
