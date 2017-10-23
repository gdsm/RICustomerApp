//
//  ReportLineView.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "BaseLabel.h"

@interface ReportLineView : BaseView

- (id) initWithDividers:(CGFloat *)dividers count:(NSUInteger)count;

- (void) setTitles:(NSString *)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

- (void) setFontSizeAndRemoveAttrForAllLabels:(CGFloat)fontSize;

- (void) setBold:(NSNumber *)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
/**
 * @brief This Method is used for set fonts in table header view labels 
 */
- (void) setHeaderFont:(NSNumber *)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

- (void) addDoubleLabel:(UILabel *)label atIndex:(NSUInteger)index;

@property (nonatomic, assign) CGFloat padding;

@property (nonatomic, assign) CGFloat controlOffsetMargin; //Spacing between two labels in report line view

@property (nonatomic) BOOL top,down,side; //Indicate which side border has been added

- (BaseLabel *) labelAtIndex:(NSUInteger)index;

@property (nonatomic) UIEdgeInsets labelInsetMargins;

@property (nonatomic) BOOL isHighlighted; // Background is highlighted or normal

@end
