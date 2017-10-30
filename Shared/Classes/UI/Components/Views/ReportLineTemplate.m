//
//  ReportLineTemplate.m
//  ReddyIce
//
//  Created by Gagan on 30/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ReportLineTemplate.h"
#import "Globals.h"
#import "Utilities.h"


@interface ReportLineTemplate()
@property (nonatomic, strong) NSMutableArray<UIView*>* views;
@property (nonatomic, strong) NSMutableArray<NSNumber*>* dividers;
@end


@implementation ReportLineTemplate

- (id) initWithDividers:(CGFloat *)dividers
                  count:(NSUInteger)count
       callbackTemplate:(blk_initTemplateView)callbackInit
         layoutTemplate:(blk_layoutTemplateView)callbackLayout
{
    self = [super init];
    if (self)
    {
        // Initialization code
        _dividers = [NSMutableArray arrayWithCapacity:count];
        _views = [NSMutableArray arrayWithCapacity:count];
        _callbackInitTemplateView = callbackInit;
        _callbackLayoutTemplateView = callbackLayout;

        [_dividers addObject:[NSNumber numberWithFloat:0.f]];
        
        for (NSInteger i = 0; i < count; i++)
        {
            if (i >= 1)
            {
                CGFloat f = dividers[i - 1];
                [_dividers addObject:[NSNumber numberWithFloat:f]];
            }
            
            if (_callbackInitTemplateView != nil)
            {
                UIView* v = _callbackInitTemplateView(i);
                [self addSubview:v];
                [self.views addObject:v];
            }
        }
    }
    return self;
}

- (UIView *) viewAtIndex:(NSUInteger)index
{
    UIView *retVal = [self.views objectAtIndex:index];
    return retVal;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    for (NSInteger i = 0; i < [_views count]; i++)
    {
        __weak UIView *v = [self viewAtIndex:i];
        
        CGFloat leftPct = [_dividers[i] floatValue];
        CGFloat rightPct = i == [_views count] - 1 ? 1.f : [_dividers[i + 1] floatValue];
        
        CGFloat width = CGRectGetWidth(self.frame) - self.padding * 2;
        
        CGFloat left = (NSInteger)(leftPct * width + self.padding) + (i == 0 ? 0 : self.controlOffsetMargin);
        CGFloat right = (NSInteger)(rightPct * width + self.padding);
        CGFloat top = 0;
        
        
        CGFloat allowedHeight = CGRectGetHeight(self.frame);
        
        CGRect rect_v = v.frame;
        if (i > 0){
            rect_v.origin.x = (left + (self.interMargins * 0.5));
        }
        else{
            rect_v.origin.x = left;
        }
        if (top < 1)
        {
            rect_v.origin.y = (CGRectGetHeight(self.frame) - allowedHeight) * 0.5;
        }
        else
        {
            rect_v.origin.y = top;
        }
        if (i > 0){
            rect_v.size.width = (right - left) - (self.interMargins * 0.5);
        }
        else{
            rect_v.size.width = (right - left);
        }
        rect_v.size.height = (NSInteger)(allowedHeight) - (2*top);
        
        v.frame = rect_v;
        
        if ([v isKindOfClass:[BaseView class]])
        {
            [((BaseView *)v) layoutUI];
        }
        
        if (self.callbackLayoutTemplateView != nil)
        {
            self.callbackLayoutTemplateView(i, v);
        }
    }
}

@end
