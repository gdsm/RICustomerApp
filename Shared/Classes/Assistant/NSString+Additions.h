//
//  NSString+Additions.h
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Additions)

/**
 * @brief This method splits NSString based upon some pattern. Splitted string is converted into Array and return to parent method. This method uses NSScanner to scan string.
 * @param start : Starting pattern to be searched in string.
 * @param end : End pattern where to stop search in string.
 * @param addEndCharacter : A bool value indicating that end character needs to included or not.
 */
- (NSArray *) splitStringWithStartPattern:(NSString *)start endPattern:(NSString *)end shouldAddEndCharacter:(BOOL)addEndCharacter;

/// Returns the @c NSDecimalNumber version of this string
- (NSDecimalNumber *) decimalNumberValue;

+ (NSMutableAttributedString *) attributedStrings:(NSArray *)strings withFonts:(NSArray *)fonts baselineAdjustment:(NSArray *)baseline textAlignment:(NSTextAlignment)alignment;

/// Trims whitespace from the ends of this string
- (CGFloat) heightForFont:(UIFont *)font forMaxWidth:(CGFloat)width;
/**
 * @brief Method would return the number of lines required for the string with provided width
 * <li> @param font : Font for which calculation needs to be performed.
 * <li> @param width : Constrained width
 * <li> @return If sucessfull then number of lines other wise 0;
 */
- (NSUInteger) numberOfLinesWithFont:(UIFont *)font forMaxWidth:(CGFloat)width;
/**
 * @brief Method would return the number of lines required for the string with provided width
 * <li> @param font : Font for which calculation needs to be performed.
 * <li> @param width : Constrained width
 * <li> @param lineBreakMode : Line line break mode calculation needs to be performed.
 * <li> @return If sucessfull then number of lines other wise 0;
 */
- (NSUInteger) numberOfLinesWithFont:(UIFont *)font forMaxWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 * @brief This method work as independently to calculate string height. Method is used static string "Wy", because Wy is supposed to cover maximum gylph in any font so this is taken.
 * @param font : Font value that used for string height calculation.
 
 */
+  (CGFloat) heightForFont:(UIFont *)font;

- (NSString*) trim;

/// ios7 deprecated functions
- (CGSize) silverSizeWithFont:(UIFont *)font;
- (CGSize) silverSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize) silverSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 * @brief With NumberPad adjustsFontSizeToFitWidth(iOS native method) not working properly. So created external method to calculate Font Size.
 * @remarks This method returns the font size not the rect size.
 * @param font : Existing font.
 * @param textRectLimit : Limit of text in bounds
 * @param maxFontSize : Maximum font size which can to raised.
 * @param minFontSize : Mininmum font size which can be decreased.
 */
- (CGFloat) fontSize:(UIFont *)font
       textRectLimit:(CGSize)textRectLimit
        maxFontLimit:(CGFloat)maxFontSize
        minFontLimit:(CGFloat)minFontSize;

/// @return the @c CGFloat form of this @c NSString
- (CGFloat)cgFloatValue;

+ (NSString *) stringFromIndexPath:(NSIndexPath *)indexPath;
@end
