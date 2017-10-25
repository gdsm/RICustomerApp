//
//  PasswordField.h
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"

@interface EditField : BaseView

@property (nonatomic, strong) UILabel* lblHint;
@property (nonatomic, strong) UITextField* textField;
@property (nonatomic, strong) BaseView* viewUnderLine;

@property (nonatomic, strong) NSString* hintText;
@property (nonatomic, strong) NSString* placeHolderText;

@property (nonatomic, readonly) BOOL isResponder;

@end
