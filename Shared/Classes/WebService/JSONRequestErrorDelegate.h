//
//  JSONRequestErrorDelegate.h
//  Silver
//
//  Created by Dustin Burke on 3/10/14.
//
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
