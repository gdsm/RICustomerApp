//
//  EnterQuantityView.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"

@interface EnterQuantityView : BaseView

@property (nonatomic, strong) UILabel* lblTitle;
@property (nonatomic, strong) UILabel* lblQty;
@property (nonatomic, strong) UITextField* textField;
@property (nonatomic, strong) BaseView* viewUnderLine;

@end
