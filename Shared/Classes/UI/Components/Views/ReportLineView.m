//
//  ReportLineView.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ReportLineView.h"
#import "Globals.h"
#import "Utilities.h"
#import "NSString+Additions.h"

@interface ReportLineView ()
{
    NSMutableArray *_dividers;
    NSMutableArray *_labels;
    NSMutableArray *_doubleLabels;
}
@end


@implementation ReportLineView
{
    UIEdgeInsets _labelInsetMargins;
}

- (id)initWithDividers:(CGFloat *)dividers count:(NSUInteger)count
{
    self = [super init];
    if (self) {
        // Initialization code
        _dividers = [NSMutableArray arrayWithCapacity:count];
        _labels = [NSMutableArray arrayWithCapacity:count];
        _doubleLabels = [NSMutableArray arrayWithCapacity:count];
        
        [_dividers addObject:[NSNumber numberWithFloat:0.f]];
        
        self.labelInsetMargins = UIEdgeInsetsMake(0, 0, 0, 0);

        for (NSInteger i = 0; i < count; i++)
        {
            if (i >= 1)
            {
                CGFloat f = dividers[i - 1];
                [_dividers addObject:[NSNumber numberWithFloat:f]];
            }
            
            BaseLabel *label = [[BaseLabel alloc] init];
            [label setFont:[[Globals shared] defaultTextFont]];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [Globals shared].themingAssistant.defaultTextColor;
            label.contentInsets = self.labelInsetMargins;
            label.numberOfLines = 0;
            [self addSubview:label];
            [_labels addObject:label];
            
            [_doubleLabels addObject:[NSNull null]];
        }
    }
    return self;
}

- (BaseLabel *) labelAtIndex:(NSUInteger)index
{
    BaseLabel *retVal = [_labels objectAtIndex:index];
    return retVal;
}

- (void) setTitles:(NSString *)firstObj, ...
{
    va_list args;
    va_start(args, firstObj);
    
    NSInteger cnt = 0;
    for (NSString *arg = firstObj; arg != nil; arg = va_arg(args, NSString *))
    {
        [self labelAtIndex:cnt].text = arg;
        cnt++;
    }
    va_end(args);
}

- (void) setFontSizeAndRemoveAttrForAllLabels:(CGFloat)fontSize
{
    if (!fontSize)
    {
        return;
    }
    
    for (NSInteger i = 0; i < [_labels count]; i++)
    {
        UILabel *lbl = [self labelAtIndex:i];
        lbl.font = [UIFont systemFontOfSize:fontSize];
    }
    
    for (NSInteger i = 0; i < [_doubleLabels count]; i++)
    {
        id obj = [_doubleLabels objectAtIndex:i];
        if ([obj isKindOfClass:[UILabel class]])
        {
            UILabel *lbl = obj;
            lbl.font = [UIFont systemFontOfSize:fontSize];
        }
    }
}

- (void) setBold:(NSNumber *)firstObj, ...
{
    va_list args;
    va_start(args, firstObj);
    
    NSInteger cnt = 0;
    for (NSNumber *arg = firstObj; arg != nil; arg = va_arg(args, NSNumber *))
    {
        if ([arg boolValue])
        {
            UILabel *lbl = [self labelAtIndex:cnt];
            [lbl setFont:[[Globals shared] helveticaNeue:lbl.font.pointSize]];
        }
        cnt++;
    }
    va_end(args);
}

- (void) setHeaderFont:(NSNumber *)firstObj, ...
{
    va_list args;
    va_start(args, firstObj);
    
    NSInteger cnt = 0;
    for (NSNumber *arg = firstObj; arg != nil; arg = va_arg(args, NSNumber *))
    {
        if ([arg boolValue])
        {
            UILabel *lbl = [self labelAtIndex:cnt];
            [lbl setFont:[[Globals shared] boldTextFont]];
            lbl.textColor = [Globals shared].themingAssistant.defaultTextColor;
        }
        cnt++;
    }
    va_end(args);
}

- (void) addDoubleLabel:(UILabel *)label atIndex:(NSUInteger)index
{
    [_doubleLabels replaceObjectAtIndex:index withObject:label];
    [label setFont:[[Globals shared] defaultInfoFont]];
    [self addSubview:label];
    [self layoutSubviews];
}

- (void) setLabelInsetMargins:(UIEdgeInsets)labelInsetMargins
{
    _labelInsetMargins = labelInsetMargins;
    for (NSInteger i = 0; i < [_labels count]; i++)
    {
        __weak BaseLabel *lbl = [self labelAtIndex:i];
        lbl.contentInsets = labelInsetMargins;
    }
}

- (UIEdgeInsets) labelInsetMargins
{
    return _labelInsetMargins;
}

- (void) layoutSubviews
{
    [super layoutSubviews];

    for (NSInteger i = 0; i < [_labels count]; i++)
    {
        __weak BaseLabel *lbl = [self labelAtIndex:i];
        id doubleLbl = [_doubleLabels objectAtIndex:i];
        
        CGFloat leftPct = [_dividers[i] floatValue];
        CGFloat rightPct = i == [_labels count] - 1 ? 1.f : [_dividers[i + 1] floatValue];
        
        CGFloat width = CGRectGetWidth(self.frame) - self.padding * 2;
        
        CGFloat left = (NSInteger)(leftPct * width + self.padding) + (i == 0 ? 0 : self.controlOffsetMargin);
        CGFloat right = (NSInteger)(rightPct * width + self.padding);
        CGFloat top = lbl.contentInsets.top;
        
  
        CGFloat allowedHeight = CGRectGetHeight(self.frame);
        
        if (![doubleLbl isKindOfClass:[NSNull class]])
        {
            allowedHeight = [lbl.text heightForFont:[Globals shared].defaultInfoFont forMaxWidth:width] * 2;
            allowedHeight = allowedHeight / 2;
            
            top = 1;
            UILabel *dblLbl = doubleLbl;
            dblLbl.frame = CGRectMake(left, 0, right - left, (NSInteger)allowedHeight);
        }
        
        
        CGRect rect_lbl = lbl.frame;
        rect_lbl.origin.x = left;
        if (top < 1)
        {
            rect_lbl.origin.y = (CGRectGetHeight(self.frame) - allowedHeight) * 0.5;
        }
        else
        {
            rect_lbl.origin.y = top;
        }
        rect_lbl.size.width = right - left;
        rect_lbl.size.height = (NSInteger)(allowedHeight) - (2*top);
        
        lbl.frame = rect_lbl;
    }
}

@end
