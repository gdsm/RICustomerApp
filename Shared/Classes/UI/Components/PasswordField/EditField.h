//
//  PasswordField.h
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"

// This is not the best way making to much of heirarchy. But again limited time and high expectations. Can't think much.
typedef NS_ENUM(NSUInteger, EditFieldStyle) {
    EditFieldStyle_Hint_V_TextField,
    EditFieldStyle_Hint_H_TextField,
    EditFieldStyle_Split
};

@interface EditField : BaseView

@property (nonatomic) EditFieldStyle editFieldStyle;

@property (nonatomic, weak) BaseLabel* lblHint;
@property (nonatomic, weak) UITextField* textField;
@property (nonatomic, weak) BaseView* viewUnderLine;

@property (nonatomic, weak) UITextField* textField2;
@property (nonatomic, weak) BaseView* viewUnderLine2;
@property (nonatomic) BOOL hideField2;

@property (nonatomic, strong) NSString* hintText;
@property (nonatomic, strong) NSString* placeHolderText;
@property (nonatomic, strong) NSString* placeHolderText2; //have some better name. But due to limited time and high expectations can't think for this.

@property (nonatomic, readonly) BOOL isResponder;

@end
