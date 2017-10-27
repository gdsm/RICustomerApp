//
//  EditFieldStyleSplit.h
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "UnderlineTextField.h"

@interface EditFieldStyleSplit : BaseView

+ (EditFieldStyleSplit *) instance;

@property (weak, nonatomic) IBOutlet BaseLabel *lblHint;
@property (weak, nonatomic) IBOutlet UnderlineTextField *viewTextFieldLeft;
@property (weak, nonatomic) IBOutlet UnderlineTextField *viewTextFieldRight;


@end
