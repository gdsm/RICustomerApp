//
//  ReportLineTemplate.h
//  ReddyIce
//
//  Created by Gagan on 30/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"

typedef UIView* (^blk_initTemplateView)(NSUInteger index);
typedef void (^blk_layoutTemplateView)(NSUInteger index, UIView* view);

@interface ReportLineTemplate : BaseView

- (id) initWithDividers:(CGFloat *)dividers
                  count:(NSUInteger)count
       callbackTemplate:(blk_initTemplateView)callbackInit
         layoutTemplate:(blk_layoutTemplateView)callbackLayout;

@property (nonatomic, strong) blk_initTemplateView callbackInitTemplateView;
@property (nonatomic, strong) blk_layoutTemplateView callbackLayoutTemplateView;

- (UIView *) viewAtIndex:(NSUInteger)index;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) CGFloat interMargins;
@property (nonatomic, assign) CGFloat controlOffsetMargin;

@end
