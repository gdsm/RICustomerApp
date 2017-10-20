//
//  BaseButton.h
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"

@interface BaseButton : UIButton

@property (nonatomic) BOOL canHighlight;

@property (nonatomic, strong) UIColor* bgNormalColor;
@property (nonatomic, strong) UIColor* bgHighlightedColor;
@property (nonatomic, strong) UIColor* bgSelectedColor;
@property (nonatomic, strong) UIColor* bgDisableColor;

@property (nonatomic, weak) UIColor* titleNormalColor;
@property (nonatomic, weak) UIColor* titleHighlightedColor;
@property (nonatomic, weak) UIColor* titleSelectedColor;
@property (nonatomic, weak) UIColor* titleDisableColor;

@property (nonatomic, weak) UIColor* borderNormalColor;
@property (nonatomic) CGFloat normalBorderWidth;
@property (nonatomic) CGFloat cornerRadius;

/// @brief This property is generic property. It allows to associate any NSObject with this button. Whenever a button needs to carry additional information use this property.
@property (nonatomic, strong) id associatedObject;

@end
