//
//  HomeButton.m
//  ReddyIce
//
//  Created by Gagan on 12/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "HomeButton.h"
#import "Globals.h"

const CGFloat HomeButton_LeftMargin = 0;
const CGFloat HomeButton_TopMargin = 20;
const CGFloat HomeButton_ImgLblMargin = 5;
const CGFloat HomeButton_BottomMargin = 10;

@interface HomeButton ()
@property (nonatomic, strong) UIImageView* imgvTop;
@property (nonatomic, strong) UILabel* lblBottom;
@end

@implementation HomeButton

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.imgvTop.image = [UIImage imageNamed:imageName];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.lblBottom.text = title;
}

- (UIImageView *)imgvTop
{
    if (_imgvTop == nil)
    {
        _imgvTop = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgvTop.backgroundColor = [UIColor clearColor];
        _imgvTop.clipsToBounds = YES;
        _imgvTop.userInteractionEnabled = NO;
        _imgvTop.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imgvTop];
    }
    return _imgvTop;
}

- (UILabel *) lblBottom
{
    if (_lblBottom == nil)
    {
        _lblBottom = [[UILabel alloc] initWithFrame:self.bounds];
        _lblBottom.backgroundColor = [UIColor clearColor];
        _lblBottom.clipsToBounds = YES;
        _lblBottom.font = [Globals shared].defaultTextFont;
        _lblBottom.textColor = [Globals shared].themingAssistant.homeBtnTitleColor;
        _lblBottom.textAlignment = NSTextAlignmentCenter;
        _lblBottom.numberOfLines = 0;
        
        [self addSubview:_lblBottom];
    }
    return _lblBottom;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect_imgvTop = self.imgvTop.frame;
    CGRect rect_lblBottom = self.lblBottom.frame;

    CGFloat avlWid = self.frame.size.width;
    CGFloat avlHei = self.frame.size.height;
    CGFloat xOffset = HomeButton_LeftMargin;
    CGFloat yOffset = HomeButton_TopMargin;
    
    avlWid -= (2 * xOffset);
    avlHei -= ((2 * yOffset) + HomeButton_ImgLblMargin);

    rect_imgvTop.origin.x = xOffset;
    rect_imgvTop.origin.y = yOffset;
    rect_imgvTop.size.width = avlWid;
    rect_imgvTop.size.height = avlHei * 0.5;

    yOffset += (rect_imgvTop.size.height + HomeButton_ImgLblMargin);
    
    rect_lblBottom.origin.x = xOffset;
    rect_lblBottom.origin.y = yOffset;
    rect_lblBottom.size.width = avlWid;
    rect_lblBottom.size.height = avlHei * 0.5;

    self.imgvTop.frame = rect_imgvTop;
    self.lblBottom.frame = rect_lblBottom;
}

@end

//----> Old design code.
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    CGRect rect_imgvTop = self.imgvTop.frame;
//    CGRect rect_lblBottom = self.lblBottom.frame;
//
//    CGFloat avlWid = self.frame.size.width;
//    CGFloat avlHei = self.frame.size.height;
//    CGFloat xOffset = HomeButton_LeftMargin;
//    CGFloat yOffset = HomeButton_TopMargin;
//
//    avlWid -= (2 * xOffset);
//    avlHei -= ((2 * yOffset) + HomeButton_ImgLblMargin);
//
//    rect_imgvTop.origin.x = xOffset;
//    rect_imgvTop.origin.y = yOffset;
//    rect_imgvTop.size.width = self.imgvTop.image.size.width;
//    rect_imgvTop.size.height = avlHei * 0.5;
//
//    yOffset += (rect_imgvTop.size.height + HomeButton_ImgLblMargin);
//
//    rect_lblBottom.origin.x = xOffset;
//    rect_lblBottom.origin.y = yOffset;
//    rect_lblBottom.size.width = avlWid;
//    rect_lblBottom.size.height = avlHei * 0.5;
//
//    self.imgvTop.frame = rect_imgvTop;
//    self.lblBottom.frame = rect_lblBottom;
//}

