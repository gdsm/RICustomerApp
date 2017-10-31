//
//  Globals.m
//  ReddyIce
//
//  Created by Gagan on 09/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "Globals.h"
#import "UserManager.h"

const CGFloat seperatorHeight_1px = 1.0;
const CGFloat borderWidth_1px = 1.0;
const CGFloat viewHeight_20px = 20.0;
const CGFloat viewHeight_40px = 40.0;
const CGFloat viewHeight_60px = 60.0;
const CGFloat viewHeight_150px = 150.0;
const CGFloat viewWidth_160px = 160.0;
const CGFloat topMargin_5px = 5.0;
const CGFloat topMargin_10px = 10.0;
const CGFloat topMargin_20px = 20.0;
const CGFloat leftMargin_20px = 20.0;
const CGFloat leftMargin_40px = 40.0;
const CGFloat leftMargin_15px = 15.0;
const CGFloat rightMargin_20px = 20.0;
const CGFloat rightMargin_40px = 40.0;
const CGFloat rightMargin_15px = 15.0;
const CGFloat rightMargin_10px = 10.0;
const CGFloat bottomMargin_5px = 5.0;
const CGFloat bottomMargin_10px = 10.0;
const CGFloat bottomMargin_20px = 20.0;
const CGFloat cornerRadius_20px = 20.0;
const CGFloat cornerRadius_10px = 10.0;
const CGFloat cornerRadius_6px = 6.0;
const CGFloat cellHeight_40px = 40.0;
const CGFloat cellHeight_60px = 60.0;
const CGFloat cellHeight_80px = 80.0;
const CGFloat cellHeight_150px = 150.0;
const CGFloat cartSize_44px = 44.0f;

@interface Globals()

@end


@implementation Globals
{
    NSString* _documentsDirectory;
}

+ (Globals *) shared
{
    __strong static Globals * _globals_sharedInstance = nil;
    
    static dispatch_once_t _globals_SharedDispatchOnceToken = 0;
    dispatch_once(&_globals_SharedDispatchOnceToken, ^{
        _globals_sharedInstance = [Globals new];
    });
    
    return _globals_sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        _registrationRequired = YES;
        _anyActiveUser = NO;
    }
    return self;
}

- (NSString *) documentsDirectory
{
    if (_documentsDirectory == nil)
    {
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _documentsDirectory = [documentPaths objectAtIndex:0];
    }
    return _documentsDirectory;
}

//- (BOOL) anyActiveUser
//{
//    BOOL retVal = ([UserManager shared].activeUser != nil);
//    return retVal;
//}

- (BOOL) isSessionExpired
{
//    BOOL retVal = NO;
    BOOL retVal = YES;
    return retVal;
}

- (NSString *) userName
{
    return [UserManager shared].activeUser.name;
}

- (ThemingAssistant *)themingAssistant
{
    if (_themingAssistant == nil)
    {
        _themingAssistant = [ThemingAssistant new];
    }
    return _themingAssistant;
}

- (UINavigationController *) appNavigationController
{
    UINavigationController *appNavCtrl = nil;
    id rootController = [[UIApplication sharedApplication].delegate window].rootViewController;
    
    if ([rootController isKindOfClass:[UINavigationController class]])
    {
        appNavCtrl = (UINavigationController *)rootController;
    }
    
    return appNavCtrl;
}

- (UIFont *) defaultInfoFont
{
    if (_defaultInfoFont == nil)
    {
        _defaultInfoFont = [self helveticaNeue:16];
    }
    return _defaultInfoFont;
}

- (UIFont *) defaultIconFont
{
    if (_defaultIconFont == nil)
    {
        _defaultIconFont = [self iconFont:40];
    }
    return _defaultIconFont;
}

- (UIFont *) bbiIconFont
{
    if (_bbiIconFont == nil)
    {
        _bbiIconFont = [self iconFont:32];
    }
    return _bbiIconFont;
}

- (UIFont *) badgeFont
{
    if (_badgeFont == nil)
    {
        _badgeFont = [self helveticaNeue:12];
    }
    return _badgeFont;
}

- (UIFont *) defaultTextFont
{
    if (_defaultTextFont == nil)
    {
        _defaultTextFont = [self helveticaNeue:19];
    }
    return _defaultTextFont;
}

- (UIFont *) checkoutTotalFont
{
    if (_checkoutTotalFont == nil)
    {
        _checkoutTotalFont = [self helveticaNeue:28];
    }
    return _checkoutTotalFont;
}

- (UIFont *) enterQtyFont
{
    if (_enterQtyFont == nil)
    {
        _enterQtyFont = [self helveticaNeue:22];
    }
    return _enterQtyFont;
}

- (UIFont *) boldTextFont
{
    if (_boldTextFont == nil)
    {
        _boldTextFont = [self helveticaNeueBold:19];
    }
    return _boldTextFont;
}

- (UIFont *) itemViewCartInfoFont
{
    if (_itemViewCartInfoFont == nil)
    {
        _itemViewCartInfoFont = [self helveticaNeue:14];
    }
    return _itemViewCartInfoFont;
}

- (UIFont *) iconFont:(CGFloat)size
{
    NSString *fontName = @"Material-Design-Iconic-Font";
    UIFont *font = [UIFont fontWithName:fontName size:size];
    return font;
}

- (UIFont *) helveticaNeue:(CGFloat)size
{
    NSString *fontName = @"HelveticaNeue";
    UIFont *font = [UIFont fontWithName:fontName size:size];
    return font;
}

- (UIFont *) helveticaNeueThin:(CGFloat)size
{
    NSString *fontName = @"HelveticaNeue-Thin";
    UIFont *font = [UIFont fontWithName:fontName size:size];
    return font;
}

- (UIFont *) helveticaNeueThinItalic:(CGFloat)size
{
    NSString *fontName = @"HelveticaNeue-ThinItalic";
    UIFont *font = [UIFont fontWithName:fontName size:size];
    return font;
}

- (UIFont *) helveticaNeueLight:(CGFloat)size
{
    NSString *fontName = @"HelveticaNeue-Light";
    UIFont *font = [UIFont fontWithName:fontName size:size];
    return font;
}

- (UIFont *) helveticaNeueLightItalic:(CGFloat)size
{
    NSString *fontName = @"HelveticaNeue-LightItalic";
    UIFont *font = [UIFont fontWithName:fontName size:size];
    return font;
}

- (UIFont *) helveticaNeueMedium:(CGFloat)size
{
    NSString *fontName = @"HelveticaNeue-Medium";
    UIFont *font = [UIFont fontWithName:fontName size:size];
    return font;
}

- (UIFont *) helveticaNeueItalic:(CGFloat)size
{
    NSString *fontName = @"HelveticaNeue-Italic";
    
    UIFont *font = [UIFont fontWithName:fontName size:size];
    if (font == nil)
    {
        font = [UIFont fontWithName:@"HelveticaNeue-ItalicM3" size:size];
    }
    return font;
}

- (UIFont *) helveticaNeueBold:(CGFloat)size
{
    NSString *fontName = @"HelveticaNeue-Bold";
    UIFont *font = [UIFont fontWithName:fontName size:size];
    return font;
}

@end
