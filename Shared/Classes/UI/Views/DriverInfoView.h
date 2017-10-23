//
//  DriverInfoView.h
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"

@interface DriverInfoView : BaseView

+ (DriverInfoView *) instance;

@property (weak, nonatomic) IBOutlet BaseLabel *lblUserIcon;
@property (weak, nonatomic) IBOutlet UIImageView *imgvUserIcon;
@property (weak, nonatomic) IBOutlet BaseLabel *lblName;
@property (weak, nonatomic) IBOutlet BaseLabel *lblLicenseNo;
@property (weak, nonatomic) IBOutlet BaseLabel *lblPhone;

@end
