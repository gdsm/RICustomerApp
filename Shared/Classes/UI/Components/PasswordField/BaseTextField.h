//
//  BaseTextField.h
//  ReddyIce
//
//  Created by Gagan on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^blk_textFieldValueChanged)(NSString* value);


typedef NS_ENUM(NSUInteger, TextFieldMode){
    TextFieldMode_Unknown,
    TextFieldMode_PhoneNumber
};

@interface BaseTextField : UITextField

@property (nonatomic) NSUInteger numerOfCharacters;
@property (nonatomic) TextFieldMode textFieldMode;

- (void) defaultStyling;
- (void) phoneNumberMode;

@end
