//
//  ChangePasswordModelObject.m
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ChangePasswordModelObject.h"


NSString* const kExistingPassword = @"ExistingPassword";
NSString* const kLatestPassword = @"LatestPassword";
NSString* const kConfirmPassword = @"ConfirmPassword";

@implementation ChangePasswordModelObject

- (NSMutableArray *) allKeys
{
    if (_allKeys == nil)
    {
        _allKeys = [NSMutableArray new];
        [_allKeys addObject:kExistingPassword];
        [_allKeys addObject:kLatestPassword];
        [_allKeys addObject:kConfirmPassword];
    }
    return _allKeys;
}

- (NSString *) displayValueForKey:(NSString *)key
{
    NSString* retVal = nil;
    if ([key isEqualToString:kExistingPassword])
    {
        retVal = @"Existing Password";
    }
    else if ([key isEqualToString:kLatestPassword])
    {
        retVal = @"New Password";
    }
    else if ([key isEqualToString:kConfirmPassword])
    {
        retVal = @"Confirm Password";
    }
    return retVal;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary* dictionary = [NSMutableDictionary new];
    if (self.existingPassword != nil)
    {
        [dictionary setObject:self.existingPassword forKey:kExistingPassword];
    }
    if (self.latestPassword != nil)
    {
        [dictionary setObject:self.latestPassword forKey:kLatestPassword];
    }
    if (self.confirmPassword != nil)
    {
        [dictionary setObject:self.confirmPassword forKey:kConfirmPassword];
    }
    return dictionary;
}

- (NSDictionary *) nonnullDictionary
{
    NSMutableDictionary* dictionary = [NSMutableDictionary new];
    if (self.existingPassword != nil)
    {
        [dictionary setObject:self.existingPassword forKey:kExistingPassword];
    }
    else
    {
        [dictionary setObject:@"" forKey:kExistingPassword];
    }
    
    if (self.latestPassword != nil)
    {
        [dictionary setObject:self.latestPassword forKey:kLatestPassword];
    }
    else
    {
        [dictionary setObject:@"" forKey:kLatestPassword];
    }

    if (self.confirmPassword != nil)
    {
        [dictionary setObject:self.confirmPassword forKey:kConfirmPassword];
    }
    else
    {
        [dictionary setObject:@"" forKey:kConfirmPassword];
    }
    
    return dictionary;
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
    if (dictionary == nil)
    {
        return ;
    }
    
    self.latestPassword = [dictionary objectForKey:kLatestPassword];
    self.confirmPassword = [dictionary objectForKey:kConfirmPassword];
    self.existingPassword = [dictionary objectForKey:kExistingPassword];
}
@end
