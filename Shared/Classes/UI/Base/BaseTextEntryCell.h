//
//  BaseTextEntryCell.h
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol TextEntryDelegate
@optional
- (void) textFieldShouldReturn:(UITextField *)textField forIndexPath:(NSIndexPath *)indexPath inCell:(id)cell;
- (void)textFieldShouldBeginEditing:(UITextField *)textField forIndexPath:(NSIndexPath *)indexPath inCell:(id)cell;
- (void)textFieldDidBeginEditing:(UITextField *)textField forIndexPath:(NSIndexPath *)indexPath inCell:(id)cell;
- (void)textFieldShouldEndEditing:(UITextField *)textField forIndexPath:(NSIndexPath *)indexPath inCell:(id)cell;
- (void)textFieldDidEndEditing:(UITextField *)textField forIndexPath:(NSIndexPath *)indexPath inCell:(id)cell;
- (void)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string forIndexPath:(NSIndexPath *)indexPath inCell:(id)cell;
@end


@interface BaseTextEntryCell : BaseTableViewCell <UITextFieldDelegate>

- (void) updateWithDelegate:(id<TextEntryDelegate>)delegate dictionary:(NSMutableDictionary *)dict key:(NSString *)key keyboardType:(UIKeyboardType)keyboardType;

@property (nonatomic, weak) id<TextEntryDelegate> textEntryDelegate;
@property (nonatomic, strong) NSMutableDictionary* dictionary;
@property (nonatomic, strong) NSString* key;
@property (nonatomic) UIKeyboardType keyboardType;
@property (nonatomic) UIReturnKeyType returnKeyType;

@end
