//
//  NSDecimalNumber+Additions.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "NSDecimalNumber+Additions.h"

@implementation NSDecimalNumber (Additions)

+ (NSDecimalNumber *)decimalNumberWithFloat:(float)floatValue
{
    return [NSDecimalNumber decimalNumberWithFloat:floatValue withBehavior:[NSDecimalNumber defaultDecimalNumberHandler]];
}

+ (NSDecimalNumber *)decimalNumberWithFloat:(float)floatValue withBehavior:(NSDecimalNumberHandler *)behavior
{
    NSString *stringRepresentationOfFloat = [NSString stringWithFormat:@"%f", floatValue];
    return [[NSDecimalNumber decimalNumberWithString:stringRepresentationOfFloat] decimalNumberByRoundingAccordingToBehavior:behavior];
}

+ (NSDecimalNumber *)penny
{
    static NSDecimalNumber* penny;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        penny = [NSDecimalNumber decimalNumberWithString:@"0.01"];
    });
    return penny;
}

+ (NSDecimalNumber *)negativePenny
{
    static NSDecimalNumber* negativePenny;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        negativePenny = [NSDecimalNumber decimalNumberWithString:@"-0.01"];
    });
    return negativePenny;
}

+ (NSDecimalNumber *)ten
{
    static NSDecimalNumber* ten;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ten = [NSDecimalNumber decimalNumberWithString:@"10"];
    });
    return ten;
}

+ (NSDecimalNumber *)hundred
{
    static NSDecimalNumber* hundred;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hundred = [NSDecimalNumber decimalNumberWithString:@"100"];
    });
    return hundred;
}

+ (NSDecimalNumber *) raise:(NSDecimalNumber *)a toThePowerOf:(NSUInteger)b
{
    return [a decimalNumberByRaisingToPower:b];
}

+ (NSDecimalNumberHandler *) defaultDecimalNumberHandler
{
    static NSDecimalNumberHandler* DEFAULT_DECIMAL_NUMBER_HANDLER;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DEFAULT_DECIMAL_NUMBER_HANDLER = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                                scale:16
                                                                                     raiseOnExactness:YES
                                                                                      raiseOnOverflow:YES
                                                                                     raiseOnUnderflow:YES
                                                                                  raiseOnDivideByZero:YES];
    });
    return DEFAULT_DECIMAL_NUMBER_HANDLER;
}

+ (NSDecimalNumberHandler *) roundToPennies
{
    static NSDecimalNumberHandler* ROUND_TO_PENNIES;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ROUND_TO_PENNIES = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                  scale:2
                                                                       raiseOnExactness:YES
                                                                        raiseOnOverflow:YES
                                                                       raiseOnUnderflow:YES
                                                                    raiseOnDivideByZero:YES];
    });
    return ROUND_TO_PENNIES;
}

+ (NSDecimalNumberHandler *) bankerRoundingToPennies
{
    static NSDecimalNumberHandler* BANKERS_ROUNDING_TO_PENNIES;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BANKERS_ROUNDING_TO_PENNIES = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                             scale:2
                                                                                  raiseOnExactness:YES
                                                                                   raiseOnOverflow:YES
                                                                                  raiseOnUnderflow:YES
                                                                               raiseOnDivideByZero:YES];
    });
    return BANKERS_ROUNDING_TO_PENNIES;
}

+ (NSDecimalNumber *) negativeOne
{
    static NSDecimalNumber* NSDECIMALNUMBER_NEGATIVE_ONE;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDECIMALNUMBER_NEGATIVE_ONE = [NSDecimalNumber decimalNumberWithMantissa:1
                                                                         exponent:0
                                                                       isNegative:YES];
    });
    return NSDECIMALNUMBER_NEGATIVE_ONE;
}

- (NSDecimalNumber *) negatedValue;
{
    return [self decimalNumberByMultiplyingBy:NSDecimalNumber.negativeOne];
}

- (NSDecimalNumber *) absoluteValue
{
    // From http://stackoverflow.com/a/4045284/4479896
    
    if ([self compare:[NSDecimalNumber zero]] == NSOrderedAscending) {
        // Number is negative. Multiply by -1
        return [self decimalNumberByMultiplyingBy:NSDecimalNumber.negativeOne
                                     withBehavior:self.class.defaultDecimalNumberHandler];
    }
    else
    {
        return self.copy;
    }
}

- (BOOL) isNegative
{
    return ([NSDecimalNumber.zero compare:self] == NSOrderedDescending);
}

- (BOOL) isNan
{
    BOOL retVal = [self.stringValue isEqualToString:@"NaN"];
    return retVal;
}

- (NSComparisonResult) pennyCompare:(NSDecimalNumber*)otherDecimalNumber
{
    return [[self decimalNumberByRoundingAccordingToBehavior:self.class.roundToPennies]
            compare:[otherDecimalNumber decimalNumberByRoundingAccordingToBehavior:self.class.roundToPennies]];
}

- (NSDecimalNumber *) noLessThan:(NSNumber*)minimum
{
    if ([self compare:minimum] == NSOrderedAscending)
    {
        return [NSDecimalNumber decimalNumberWithDecimal:minimum.decimalValue];
    }
    return self;
}

- (NSDecimalNumber *) noMoreThan:(NSNumber *)maximum
{
    if ([self compare:maximum] == NSOrderedDescending)
    {
        return [NSDecimalNumber decimalNumberWithDecimal:maximum.decimalValue];
    }
    return self;
}

- (NSString *) stringWithFractionTwoDigits
{
    return [self stringWithFractionPrecision:2];
}

- (NSString *) stringWithFractionPrecision:(NSUInteger)precision
{
    return [self stringFormatWithStyle:NSNumberFormatterNoStyle precision:precision];
}

- (NSString *) stringFormatWithStyle:(NSNumberFormatterStyle)style precision:(NSUInteger)precision
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = style;
    formatter.minimumFractionDigits = precision;
    formatter.maximumFractionDigits = precision;
    formatter.minimumIntegerDigits = 1;
    // try to keep this and the decimal rounding in sync... in the above roundToPennies
    formatter.roundingMode = NSNumberFormatterRoundHalfUp;
    return [formatter stringFromNumber:self];
}


- (NSString *) stringWithMinMantisaDigits:(NSInteger)minMantisa
{
    NSString *retVal = nil;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterNoStyle;
    formatter.roundingMode = NSNumberFormatterRoundHalfUp;
    formatter.minimumIntegerDigits = minMantisa;
    
    retVal = [formatter stringFromNumber:self];
    
    return retVal;
}

- (NSDecimalNumber *)decimalNumberByAddingFloat:(float)floatValue
{
    return [self decimalNumberByAddingFloat:floatValue withBehavior:[NSDecimalNumber defaultDecimalNumberHandler]];
}

- (NSDecimalNumber *)decimalNumberByAddingFloat:(float)floatValue withBehavior:(NSDecimalNumberHandler *)behavior;
{
    return [self decimalNumberByAdding:[NSDecimalNumber decimalNumberWithFloat:floatValue] withBehavior:behavior];
}

- (NSDecimalNumber *)decimalNumberBySubtractingFloat:(float)floatValue
{
    return [self decimalNumberBySubtractingFloat:floatValue withBehavior:[NSDecimalNumber defaultDecimalNumberHandler]];
}

- (NSDecimalNumber *)decimalNumberWithPennyRoundingPlusFloat:(float)floatValue
{
    return [self decimalNumberByAddingFloat:floatValue withBehavior:NSDecimalNumber.roundToPennies];
}

- (NSDecimalNumber *)decimalNumberBySubtractingFloat:(float)floatValue withBehavior:(NSDecimalNumberHandler *)behavior;
{
    return [self decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithFloat:floatValue] withBehavior:behavior];
}

- (BOOL) isGreaterThanZero
{
    return [self isGreaterThan:NSDecimalNumber.zero];
}

- (BOOL) isGreaterThan:(NSDecimalNumber *)rightOperand
{
    return [self compare:rightOperand] == NSOrderedDescending;
}

- (BOOL) isLessThanZero;
{
    return [self isLessThan:NSDecimalNumber.zero];
}

- (BOOL) isLessThan:(NSDecimalNumber *)rightOperand
{
    return [self compare:rightOperand] == NSOrderedAscending;
}

- (BOOL) isEqualToZero
{
    return [self compare:NSDecimalNumber.zero] == NSOrderedSame;
}

- (BOOL) isEqualToDecimalNumber:(NSDecimalNumber *)rightOperand
{
    return [self compare:rightOperand] == NSOrderedSame;
}

- (NSDecimalNumber *) remainderFromDivider:(NSDecimalNumber *)divider
{
    NSDecimalNumber *remainder = NSDecimalNumber.zero;
    if ( (divider == nil) || (divider.isEqualToZero) || (divider.isNan) )
    {
        return remainder;
    }
    
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                             scale:0
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:NO];
    
    NSDecimalNumber *quotient = [self decimalNumberByDividingBy:divider
                                                   withBehavior:handler];
    
    NSDecimalNumber *quot_div = [quotient decimalNumberByMultiplyingBy:divider];
    
    remainder = [self decimalNumberBySubtracting:quot_div];
    
    return remainder;
}

@end
