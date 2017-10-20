//
//  IconTextField.h
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface IconTextField : BaseView


@property (nonatomic, strong) UILabel* lblIcon;
@property (nonatomic, strong) UIImageView* imgvIcon;
@property (nonatomic, strong) UITextField* textField;
@property (nonatomic, strong) BaseView* viewUnderLine;

@property (nonatomic, strong) NSString* imageName;
@property (nonatomic, strong) NSString* iconCode;
@property (nonatomic, strong) NSString* placeHolderText;

@property (nonatomic, readonly) BOOL isResponder;
@end
