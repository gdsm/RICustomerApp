//
//  HeaderInfoView.h
//  ReddyIce
//
//  Created by Gagan on 12/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"

@interface HeaderInfoView : BaseView

@property (nonatomic) CGFloat prefferedHeight;

@property (nonatomic, strong) UILabel * lblInfo;
@property (nonatomic) UIEdgeInsets contentInset;
@property (nonatomic) CGFloat topInset;
@property (nonatomic) CGFloat leftInset;
@property (nonatomic) CGFloat rightInset;
@property (nonatomic) CGFloat bottomInset;

@end
