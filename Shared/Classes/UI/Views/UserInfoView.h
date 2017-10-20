//
//  UserInfoView.h
//  ReddyIce
//
//  Created by Gagan on 13/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "LogoView.h"

@interface UserInfoView : BaseView

@property (nonatomic, strong) UILabel * lblWelcome;
@property (nonatomic, strong) LogoView* viewUserImage;
@property (nonatomic, strong) UILabel * lblUserName;
@property (nonatomic, strong) UILabel * lblDescription;

@end
