//
//  LogoView.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "LogoView.h"
#import "Globals.h"


const CGFloat logoViewWidth = 165;
const CGFloat logoViewHeight = 56;


@interface LogoView ()
@property (nonatomic, strong) UIImageView* imgv;
@property (nonatomic, strong) UILabel* lblIcon;
@end


@implementation LogoView

- (void) setImageName:(NSString *)imageName
{
    _imageName = imageName;
    UIImage* image = [UIImage imageNamed:_imageName];
    self.imgv.image = image;

    self.lblIcon.hidden = YES;
    self.imgv.hidden = NO;
}

- (void)setIconCode:(NSString *)iconCode
{
    _iconCode = iconCode;
    self.lblIcon.text = iconCode;
    
    self.lblIcon.hidden = NO;
    self.imgv.hidden = YES;
}

- (UIImageView *)imgv
{
    if (_imgv == nil)
    {
        _imgv = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgv.backgroundColor = [UIColor clearColor];
        _imgv.contentMode = UIViewContentModeScaleAspectFit;
        _imgv.clipsToBounds = YES;
        _imgv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:_imgv];
    }
    return _imgv;
}

- (UILabel *)lblIcon
{
    if (_lblIcon == nil)
    {
        _lblIcon = [[UILabel alloc] initWithFrame:self.frame];
        _lblIcon.backgroundColor = [UIColor clearColor];
        _lblIcon.textColor = [Globals shared].themingAssistant.defaultIconColor;
        _lblIcon.textAlignment = NSTextAlignmentCenter;
        _lblIcon.contentMode = UIViewContentModeScaleAspectFill;
        _lblIcon.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _lblIcon.clipsToBounds = YES;
        _lblIcon.font = [Globals shared].defaultIconFont;
        
        [self addSubview:_lblIcon];
    }
    return _lblIcon;
}

@end
