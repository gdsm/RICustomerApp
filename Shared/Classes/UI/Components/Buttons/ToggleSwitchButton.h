//
//  ToggleSwitchButton.h
//  ReddyIce
//
//  Created by Gagan on 15/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "BlockUtils.h"

@interface ToggleSwitchButton : BaseView

@property (nonatomic) BOOL selected;
@property (nonatomic, strong) NSIndexPath* indexPath;
@property (nonatomic) BOOL hideCheckMark;
@property (nonatomic, strong) blk_actionSender actionCallback;
@property (nonatomic, strong) NSString* title;

@property (nonatomic, strong) UIColor* bgNormalColor;
@property (nonatomic, strong) UIColor* bgHighColor;
@property (nonatomic, strong) UIColor* bgSelectedColor;

@end
