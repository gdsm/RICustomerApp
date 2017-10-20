//
//  ItemVariationView.h
//  ReddyIce
//
//  Created by Gagan on 15/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"

typedef void (^blk_variationSelected)(NSIndexPath* indexPath);


@interface ItemVariationView : BaseView

@property (nonatomic) NSUInteger numberOfVariations;
@property (nonatomic) BOOL hideCheckMark;
@property (nonatomic) CGFloat maxButtonWidth;
@property (nonatomic, strong) blk_variationSelected varSelected;

@property (nonatomic, weak) UIColor* bgNormalColor;
@property (nonatomic, weak) UIColor* bgHighColor;
@property (nonatomic, weak) UIColor* bgSelectedColor;

@end
