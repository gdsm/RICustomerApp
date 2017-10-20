//
//  BaseTextEntryCell.m
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTextEntryCell.h"

@implementation BaseTextEntryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) updateWithDelegate:(id<TextEntryDelegate>)delegate dictionary:(NSMutableDictionary *)dict key:(NSString *)key keyboardType:(UIKeyboardType)keyboardType
{
    self.textEntryDelegate = delegate;
    self.dictionary = dict;
    self.key = key;
    self.keyboardType = keyboardType;
}


@end
