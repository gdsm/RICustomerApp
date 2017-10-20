//
//  NSString+Additions.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSArray *) splitStringWithStartPattern:(NSString *)start endPattern:(NSString *)end shouldAddEndCharacter:(BOOL)addEndCharacter
{
    NSMutableArray *splitStrings = [[NSMutableArray alloc] init];
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    
    while (![scanner isAtEnd])
    {
        NSString *scannedString1 = nil;
        NSString *scannedString2 = nil;
        
        [scanner scanUpToString:start intoString:&scannedString1];
        [scanner scanUpToString:end intoString:&scannedString2];
        
        if (scannedString1 != nil)
        {
            [splitStrings addObject:scannedString1];
        }
        if (scannedString2 != nil)
        {
            if (addEndCharacter)
            {
                // Scanner will not add end character
                scannedString2 = [scannedString2 stringByAppendingString:end];
                if (![scanner isAtEnd])
                {
                    // If adding end character in NSString then increment scan location by 1. And make sure to not go out of bounds.
                    [scanner setScanLocation:([scanner scanLocation]+1)];
                }
            }
            [splitStrings addObject:scannedString2];
        }
    }
    return splitStrings;
}

- (NSDecimalNumber *) decimalNumberValue
{
    return [NSDecimalNumber decimalNumberWithString:self];
}

+ (NSMutableAttributedString *) attributedStrings:(NSArray *)strings withFonts:(NSArray *)fonts baselineAdjustment:(NSArray *)baseline textAlignment:(NSTextAlignment)alignment
{
    NSMutableAttributedString *retAttrStr = nil;
    if ((strings == nil) || (fonts == nil))
    {
        //Return if attributes are nil
        return retAttrStr;
    }
    
    NSInteger maxStrings = (strings.count < fonts.count) ? strings.count : fonts.count;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init] ;
    [paragraphStyle setAlignment:alignment];
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    for (int index = 0 ; index < maxStrings ; index++)
    {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[strings objectAtIndex:index] attributes:attributes];
        [attrStr addAttribute:NSFontAttributeName value:[fonts objectAtIndex:index] range:NSMakeRange(0, attrStr.string.length)];
        
        NSInteger baselineAdjustment = 0;
        if ((baseline != nil) && (baseline.count >= maxStrings))
        {
            // Acessing NSArry beyond limit result in crash. Check before accessing index.
            baselineAdjustment = [[baseline objectAtIndex:index] integerValue];
        }
        
        // As per observation in concatinating iconic font and normal text font there is mismatch in baseline. And mutable attributed string is drawed form bottom.
        [attrStr addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithInteger:baselineAdjustment] range:NSMakeRange(0, attrStr.string.length)];
        
        if (retAttrStr == nil)
        {
            retAttrStr = [[NSMutableAttributedString alloc] initWithAttributedString:attrStr];
        }
        else
        {
            [retAttrStr appendAttributedString:attrStr];
        }
    }
    
    return retAttrStr;
}

- (CGFloat) heightForFont:(UIFont *)font forMaxWidth:(CGFloat)width
{
    CGFloat retVal = 0.0;
    if (font == nil)
    {
        retVal = 1.0f;
        return retVal;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setValue:font forKey:NSFontAttributeName];
    [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    // Below iOS 9 there was a method sizeWithFont which returns the accurate result for height. But from iOS9 onwards method is depreciated but the new method boundToRect is not working perfectly. It leaves some space above and down. To avoid that difference height is calculated manually.
    // Tweak String is used to calculate a sample space height of string. Since Wy is suppossed to cover maximum gylph in any font so this is taken.
    // Basically Height is taken from Wy String and width is taken from actual string.
    NSString *tweakString = @"Wyg$";
    CGSize tweakStringSize = [tweakString sizeWithAttributes:attributes];
    CGFloat gylphHeight = tweakStringSize.height;
    
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    NSArray *lineSepStr = [self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSInteger numberOfLines = 0;
    CGSize stringSize;
    CGFloat stringWidth;
    
    for (NSString *string in lineSepStr)
    {
        // Handle number of lines for multiple line scenerio
        stringSize = [string sizeWithAttributes:attributes];
        stringWidth = stringSize.width;
        
        CGFloat lines = [NSString stringWithFormat:@"%.1f", (stringWidth/width)].floatValue;
        // We should go with bottom value + 1 because it will also count a line for newline chanracter.
        numberOfLines += floor(lines) + 1;
    }
    
    
    retVal = numberOfLines * gylphHeight;
    
    // remove un required allocations.
    attributes = nil;
    paragraphStyle = nil;
    return retVal;
}

- (NSUInteger) numberOfLinesWithFont:(UIFont *)font forMaxWidth:(CGFloat)width
{
    NSUInteger retVal = [self numberOfLinesWithFont:font forMaxWidth:width lineBreakMode:NSLineBreakByWordWrapping];
    return retVal;
}

- (NSUInteger) numberOfLinesWithFont:(UIFont *)font forMaxWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSUInteger retVal = 0;
    
    if ((font == nil) || (width <= 0.f))
    {
        // No calculation can be perfomed with required parameters.
        return retVal;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setValue:font forKey:NSFontAttributeName];
    [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    paragraphStyle.lineBreakMode = lineBreakMode;
    [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    NSArray *lineSepStr = [self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSInteger numberOfLines = 0;
    CGSize stringSize;
    CGFloat stringWidth;
    
    for (NSString *string in lineSepStr)
    {
        // Handle number of lines for multiple line scenerio
        stringSize = [string sizeWithAttributes:attributes];
        stringWidth = stringSize.width;
        
        CGFloat lines = [NSString stringWithFormat:@"%.1f", (stringWidth/width)].floatValue;
        // We should go with bottom value + 1 because it will also count a line for newline chanracter.
        numberOfLines += floor(lines) + 1;
    }
    retVal = numberOfLines;
    
    return retVal;
}

+ (CGFloat) heightForFont:(UIFont *)font
{
    CGFloat retVal = 0.0;
    if (font == nil)
    {
        retVal = 1.0f;
        return retVal;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setValue:font forKey:NSFontAttributeName];
    [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    // Below iOS 9 there was a method sizeWithFont which returns the accurate result for height. But from iOS9 onwards method is depreciated but the new method boundToRect is not working perfectly. It leaves some space above and down. To avoid that difference height is calculated manually.
    // Tweak String is used to calculate a sample space height of string. Since Wy is suppossed to cover maximum gylph in any font so this is taken.
    // Basically Height is taken form Wy String and width is taken from actual string.
    NSString *tweakString = @"Wyg$";
    CGSize tweakStringSize = [tweakString sizeWithAttributes:attributes];
    retVal = tweakStringSize.height;
    return retVal;
}

- (NSString*) trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (CGSize) silverSizeWithFont:(UIFont *)font
{
    if (!font)
    {
        return CGSizeZero;
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGSize size = [self sizeWithAttributes:attributes];
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

- (CGSize) silverSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    if (!font)
    {
        return CGSizeMake(0, 0);
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: font};
    
    CGSize calcSize = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil].size;
    
    return calcSize;// original does not make it into an integer? CGSizeMake(ceil(calcSize.width), ceil(calcSize.height));
}

- (CGSize) silverSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if (font == nil)
    {
        return CGSizeMake(0, 0);
    }
    
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = lineBreakMode;
    
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSParagraphStyleAttributeName: style};
    
    CGSize calcSize = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil].size;
    
    return calcSize;// original does not make it into an integer? CGSizeMake(ceil(calcSize.width), ceil(calcSize.height));
}

- (CGFloat) fontSize:(UIFont *)font
       textRectLimit:(CGSize)textRectLimit
        maxFontLimit:(CGFloat)maxFontSize
        minFontLimit:(CGFloat)minFontSize
{
    if ((textRectLimit.width <= 0.f) || (textRectLimit.height <= 0.f))
    {
        return 0.f;
    }
    if (font == nil)
    {
        // A default size
        font = [UIFont systemFontOfSize:17.0];
    }
    CGFloat retSize = [font pointSize];
    
    CGSize stringSize = [self silverSizeWithFont:font];
    
    while ((stringSize.width < textRectLimit.width) || (stringSize.height < textRectLimit.height))
    {
        if (retSize >= maxFontSize)
        {
            break;
        }
        // When using adjustsFontSizeToFitWidth method for textField it was not giving desired results. So handled the case manually.
        // This while Loop will increase the font Size to maximum.
        font = [font fontWithSize:++retSize];
        stringSize = [self silverSizeWithFont:font];
    }
    
    while ((stringSize.width >= textRectLimit.width) || (stringSize.height >= textRectLimit.height))
    {
        if (retSize < minFontSize)
        {
            // Minimum font size limit of method.
            break;
        }
        // This while Loop will decrease the font Size to minimum.
        font = [font fontWithSize:--retSize];
        stringSize = [self silverSizeWithFont:font];
    }
    return retSize;
}

- (CGFloat)cgFloatValue
{
#if CGFLOAT_IS_DOUBLE
    return self.doubleValue;
#else
    return self.floatValue;
#endif
}

@end
