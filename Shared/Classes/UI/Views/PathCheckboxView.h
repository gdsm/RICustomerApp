//
//  RouteCheckboxView.h
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "CheckBox.h"

@interface PathCheckboxView : BaseView

@property (nonatomic,strong) BaseView* viewUnderLine;
@property (nonatomic,strong) CheckBox* chkStart;
@property (nonatomic,strong) CheckBox* chkEnd;

@end
