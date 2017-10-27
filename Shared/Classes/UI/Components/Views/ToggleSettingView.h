//
//  ToggleSettingView.h
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "BlockUtils.h"

@interface ToggleSettingView : BaseView

+ (ToggleSettingView *) instance;

@property (weak, nonatomic) IBOutlet UISwitch *toggleSwitch;
@property (weak, nonatomic) IBOutlet BaseLabel *lblDescription;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constLeftLblDescr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constTopLblDescr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constRightSwitch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constBottomLbl;

@property (nonatomic, strong) blk_valueChanged onValueChanged;

@end
