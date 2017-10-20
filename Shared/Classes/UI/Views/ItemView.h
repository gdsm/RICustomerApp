//
//  ItemView.h
//  ReddyIce
//
//  Created by Gagan on 15/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "ItemVariationView.h"

@interface ItemView : BaseView

@property (nonatomic, strong) UIImageView* imgvItem;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblPriceDescr;
@property (nonatomic, strong) UILabel *lblVariationDescr;
@property (nonatomic, strong) UILabel *lblCartQuantity;
@property (nonatomic, strong) ItemVariationView *itemVariationView;
@property (nonatomic, strong) BaseView* viewUnderLine;
@property (nonatomic, strong) blk_variationSelected varSelected;

@end
