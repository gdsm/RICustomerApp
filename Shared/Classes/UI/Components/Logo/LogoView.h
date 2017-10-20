//
//  LogoView.h
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

extern const CGFloat logoViewWidth;
extern const CGFloat logoViewHeight;

@interface LogoView : BaseView

@property (nonatomic, strong) NSString* imageName;
@property (nonatomic, strong) NSString* iconCode;

@end
