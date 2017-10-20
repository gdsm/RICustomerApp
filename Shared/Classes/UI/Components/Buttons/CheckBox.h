//
//  CheckBox.h
//  ReddyIce
//
//  Created by Gagan on 18/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "BlockUtils.h"

@interface CheckBox : BaseView

@property (nonatomic, strong) blk_actionSender onCheckboxCallback;
@property (nonatomic, getter=isSelected) BOOL selected;

@end
