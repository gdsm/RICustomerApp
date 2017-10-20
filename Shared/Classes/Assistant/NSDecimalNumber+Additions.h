//
//  NSDecimalNumber+Additions.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (Additions)

/**
 * round to the nearest penny;
 */
+ (NSDecimalNumberHandler *)roundToPennies;

/**
 * Using Banker's Rounding to round to the nearest penny;
 */
+ (NSDecimalNumberHandler *) bankerRoundingToPennies;

/**
 * default number handler for Silver.
 * scale: 16
 * normal rounding
 * raise on all four exceptions.
 */
+ (NSDecimalNumberHandler *)defaultDecimalNumberHandler;

/**
 * the constant 0.01
 */
+ (NSDecimalNumber *)penny;

/**
 * the constant -0.01;
 */
+ (NSDecimalNumber *)negativePenny;

/**
 * the constant -1
 */
+ (NSDecimalNumber *)negativeOne;

/**
 * The constant 10
 */
+ (NSDecimalNumber *)ten;

/**
 * the constant 100
 */
+ (NSDecimalNumber *)hundred;

/**
 * Returns the result of raising the number @c a to the power @c b
 *
 * @param a The base
 * @param b The power
 *
 * @return @c a^b
 */
+ (NSDecimalNumber *)raise:(NSDecimalNumber*)a toThePowerOf:(NSUInteger)b;

/**
 * returns the decimal number represention of the float value.
 * this function first converts the float to a string due to a weird iOS bug around
 * float -> nsnumber -> nsdecimalnumber.
 *
 * defaults the rounding behavior to what is specified in defaultDecimalNumberHandler
 */
+ (NSDecimalNumber *)decimalNumberWithFloat:(float)floatValue;

/**
 * returns the decimal number represention of the float value.
 * this function first converts the float to a string due to a weird iOS bug around
 * float -> nsnumber -> nsdecimalnumber.
 *
 * it will do rounding/scale based on the given behavior
 */
+ (NSDecimalNumber *)decimalNumberWithFloat:(float)floatValue withBehavior:(NSDecimalNumberHandler *)behavior;

/**
 * returns YES if the decimal number is negative
 */
- (BOOL) isNegative;

/**
 * retunn YES if Decimal number is Not a Number
 */
- (BOOL) isNan;

/**
 * Returns the absolute value of this number.
 */
- (NSDecimalNumber *)absoluteValue;

/**
 * returns the negated value.
 *  if it is negative, it will return the positive value.
 *  if it is positive, it will return the negative value.
 */
- (NSDecimalNumber *)negatedValue;

/**
 * Compares this number to the given one on a hundredths-level precision. That is, imagining that this is a price in
 * US Dollars, there must be at @em least a 1¢ difference in these two numbers to result in a return value other than
 * @c NSOrderedSame
 *
 * @param otherDecimalNumber The number to compare to this one
 *
 * @return @c NSOrderedSame iff the two values are the same, to the precision of one hundredth. Otherwise,
 *         @c NSOrderedAscending or @c NSOrderedDescending
 */
- (NSComparisonResult)pennyCompare:(NSDecimalNumber*)otherDecimalNumber;

/**
 * @brief MAX(self, minimum)
 * If this number is less than @c minimum , returns @c minumum . Else, returns this number.
 */
- (NSDecimalNumber *)noLessThan:(NSNumber*)minimum;
/**
 * @brief MIN(self, maximum)
 * If this number is greater than @c maximum , returns @c maxumum . Else, returns this number.
 */
- (NSDecimalNumber *)noMoreThan:(NSNumber*)maximum;

/**
 * @return A string version of this number formatted as a string, like @c 1.23
 */
- (NSString *) stringWithFractionTwoDigits;

/**
 * @param precision the number of decimal places
 *
 * @return A string version of this number formatted as a string, like @c 1.2
 */
- (NSString *) stringWithFractionPrecision:(NSUInteger)precision;

/**
 * @brief method return string which fulfills minimum mantissa digis requirment.
 * @param minMantisa : Number of mantisa digits required.
 * @return String with minimum Mantissa digits.
 */
- (NSString *) stringWithMinMantisaDigits:(NSInteger)minMantisa;

/**
 * helper functions
 */
- (NSDecimalNumber *)decimalNumberByAddingFloat:(float)floatValue;
- (NSDecimalNumber *)decimalNumberBySubtractingFloat:(float)floatValue;

- (NSDecimalNumber *)decimalNumberWithPennyRoundingPlusFloat:(float)floatValue;

- (NSDecimalNumber *)decimalNumberByAddingFloat:(float)floatValue withBehavior:(NSDecimalNumberHandler *)behavior;
- (NSDecimalNumber *)decimalNumberBySubtractingFloat:(float)floatValue withBehavior:(NSDecimalNumberHandler *)behavior;

/**
 * compare functions
 */
- (BOOL) isGreaterThanZero;
- (BOOL) isGreaterThan:(NSDecimalNumber *)rightOperand;

- (BOOL) isLessThanZero;
- (BOOL) isLessThan:(NSDecimalNumber *)rightOperand;

- (BOOL) isEqualToZero;
- (BOOL) isEqualToDecimalNumber:(NSDecimalNumber *)rightOperand;

/**
 * <li> Mathematical Functions
 *
 * formula :    dividend = (quotient * divider) + remainder;
 *              remainder = dividend - (quotient * divider);
 * dividend = self;
 * divisor = divider(param)
 */
- (NSDecimalNumber *) remainderFromDivider:(NSDecimalNumber *)divider;

@end
