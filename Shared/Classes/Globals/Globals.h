//
//  Globals.h
//  ReddyIce
//
//  Created by Gagan on 09/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemingAssistant.h"
#import "LocalizedStrings.h"

/**
 * @brief Class will store the Global access objects, properties.
 */

extern const CGFloat seperatorHeight;

@interface Globals : NSObject

+ (Globals *) shared;

@property (nonatomic, strong, readonly) NSString *documentsDirectory;
@property (nonatomic, readonly) BOOL anyActiveUser;
@property (nonatomic, readonly) BOOL isSessionExpired;
@property (nonatomic, weak, readonly) NSString* userName;
@property (nonatomic, strong) ThemingAssistant* themingAssistant;
@property (nonatomic, strong) UINavigationController* appNavigationController;

@property (nonatomic, strong) UIFont* defaultTextFont;
@property (nonatomic, strong) UIFont* defaultInfoFont;
@property (nonatomic, strong) UIFont* defaultIconFont;
@property (nonatomic, strong) UIFont* enterQtyFont;
@property (nonatomic, strong) UIFont* checkoutTotalFont;
@property (nonatomic, strong) UIFont* boldTextFont;
@property (nonatomic, strong) UIFont* bbiIconFont;
@property (nonatomic, strong) UIFont* badgeFont;
@property (nonatomic, strong) UIFont* itemViewCartInfoFont;

- (UIFont *) iconFont:(CGFloat)size;
- (UIFont *) helveticaNeue:(CGFloat)size;
- (UIFont *) helveticaNeueThin:(CGFloat)size;
- (UIFont *) helveticaNeueThinItalic:(CGFloat)size;
- (UIFont *) helveticaNeueLight:(CGFloat)size;
- (UIFont *) helveticaNeueLightItalic:(CGFloat)size;
- (UIFont *) helveticaNeueMedium:(CGFloat)size;
- (UIFont *) helveticaNeueItalic:(CGFloat)size;
- (UIFont *) helveticaNeueBold:(CGFloat)size;
@end
