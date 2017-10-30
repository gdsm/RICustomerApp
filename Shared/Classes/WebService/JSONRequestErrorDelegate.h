//
//  JSONRequestErrorDelegate.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSONRequest;

@protocol JSONRequestErrorDelegate <NSObject>

@required

/*! Implement this protocol in your class to have a chance to translate errors that the raw request may not take care of
 \param jsonRequest the request which has produced the error
 \param error the raw error
 \return Return your own error (can be the same error if no translation is necessary)
 */
- (NSError *) jsonRequest:(JSONRequest *)jsonRequest translatedErrorFromError:(NSError *)error;

@end
