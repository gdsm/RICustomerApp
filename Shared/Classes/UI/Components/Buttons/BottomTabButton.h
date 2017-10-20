//
//  BottomTabButton.h
//  ReddyIce
//
//  Created by Gagan on 13/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ColoredButton.h"

@interface BottomTabButton : ColoredButton

@property (nonatomic, strong) NSString* normalImageName;
@property (nonatomic, strong) NSString* highlightedImageName;
@property (nonatomic, strong) NSString* selectedImageName;
@property (nonatomic, strong) NSString* title;

@end
