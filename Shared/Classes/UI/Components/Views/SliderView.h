//
//  SliderView.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "BlockUtils.h"

@interface SliderView : BaseView

@property (nonatomic, strong) UIColor *thumbColor;
@property (nonatomic, strong) UIColor *leftBarColor;
@property (nonatomic, strong) UIColor *rightBarColor;;

@property (nonatomic, strong) blk_valueChanged onValueChangedCallback;

@end
