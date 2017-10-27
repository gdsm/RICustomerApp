//
//  EditFieldStyleLeftHintRightField.h
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"

@interface EditFieldStyleLeftHintRightField : BaseView

+ (EditFieldStyleLeftHintRightField *) instance;

@property (weak, nonatomic) IBOutlet BaseLabel *lblHint;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet BaseView *viewUnderline;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constLblTfMargin;

@end
