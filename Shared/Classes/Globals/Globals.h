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

extern const CGFloat seperatorHeight_1px;
extern const CGFloat borderWidth_1px;
extern const CGFloat viewHeight_20px;
extern const CGFloat viewHeight_40px;
extern const CGFloat viewHeight_60px;
extern const CGFloat viewHeight_150px;
extern const CGFloat viewWidth_160px;
extern const CGFloat topMargin_5px;
extern const CGFloat topMargin_20px;
extern const CGFloat topMargin_10px;
extern const CGFloat leftMargin_20px;
extern const CGFloat leftMargin_40px;
extern const CGFloat leftMargin_15px;
extern const CGFloat rightMargin_20px;
extern const CGFloat rightMargin_40px;
extern const CGFloat rightMargin_15px;
extern const CGFloat rightMargin_10px;
extern const CGFloat bottomMargin_5px;
extern const CGFloat bottomMargin_10px;
extern const CGFloat bottomMargin_20px;
extern const CGFloat cornerRadius_20px;
extern const CGFloat cornerRadius_6px;
extern const CGFloat cornerRadius_10px;
extern const CGFloat cellHeight_40px;
extern const CGFloat cellHeight_60px;
extern const CGFloat cellHeight_80px;
extern const CGFloat cellHeight_150px;
extern const CGFloat cartSize_44px;

@interface Globals : NSObject

+ (Globals *) shared;

@property (nonatomic, strong, readonly) NSString *documentsDirectory;
@property (nonatomic) BOOL anyActiveUser;
@property (nonatomic, readonly) BOOL isSessionExpired;
@property (nonatomic) BOOL registrationRequired;
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
