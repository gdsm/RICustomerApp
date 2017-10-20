//
//  TouchIdView.h
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "LogoView.h"
#import "ColoredButton.h"
#import "BlockUtils.h"

@interface TouchIdView : BaseView

@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet LogoView *viewLogo;
@property (weak, nonatomic) IBOutlet ColoredButton *btnEnterPassword;
@property (weak, nonatomic) IBOutlet LogoView *viewReddyIceLogo;

@property (nonatomic, strong) blk_actionSender onEnterPassword;

@end
