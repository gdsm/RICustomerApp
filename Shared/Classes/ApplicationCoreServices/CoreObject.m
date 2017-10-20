//
//  CoreObject.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CoreObject.h"

@implementation CoreObject

- (void)dealloc
{
    [self removeNotifications];
}

- (NSDictionary *) toDictionary
{
    // Child class should override this.
    NSDictionary* retVal = [NSDictionary new];
    return retVal;
}

- (NSDictionary *) nonnullDictionary
{
    // Child class should override this.
    NSDictionary* retVal = [NSDictionary new];
    return retVal;
}

- (void) updateWithDictionary:(NSDictionary *)dictionary
{
    // Child class should override this.
}

- (void) listenNotifications
{
    // Child class should override this.
}

- (void) removeNotifications
{
    // Child class should override this.
}

@end
