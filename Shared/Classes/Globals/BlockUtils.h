//
//  BlockUtils.h
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^blk_completion)(void);
typedef void (^blk_actionSender)(id sender);
typedef void (^blk_callbackResponse)(NSDictionary* response);
typedef void (^blk_actionIndexPath)(NSIndexPath* sender);
typedef void (^blk_valueChanged)(NSDecimalNumber* value);

@interface BlockUtils : NSObject

@end
