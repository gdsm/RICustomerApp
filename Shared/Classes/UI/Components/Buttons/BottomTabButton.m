//
//  BottomTabButton.m
//  ReddyIce
//
//  Created by Gagan on 13/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BottomTabButton.h"

const CGFloat BottomTabButton_LeftMargin = 10;
const CGFloat BottomTabButton_TopMargin = 5;
const CGFloat BottomTabButton_ImgLblMargin = 0;
const CGFloat BottomTabButton_BottomMargin = 5;
const CGFloat BottomTabButton_ImageWidth = 35;
const CGFloat BottomTabButton_ImageHeight = 35;


@interface BottomTabButton()

@property (nonatomic, strong) UIImageView* imgvTop;
@property (nonatomic, strong) UILabel* lblBottom;

@end

@implementation BottomTabButton

- (void) setNormalImageName:(NSString *)imageName
{
    _normalImageName = imageName;
    self.imgvTop.image = [UIImage imageNamed:_normalImageName];
}

- (void)setHighlightedImageName:(NSString *)highlightedImageName
{
    _highlightedImageName = highlightedImageName;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.lblBottom.text = title;
}

- (void) setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted)
    {
        self.imgvTop.image = [UIImage imageNamed:self.highlightedImageName];
    }
    else
    {
        if (self.isSelected)
        {
            self.imgvTop.image = [UIImage imageNamed:self.selectedImageName];
        }
        else
        {
            self.imgvTop.image = [UIImage imageNamed:self.normalImageName];
        }
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected)
    {
        self.imgvTop.image = [UIImage imageNamed:self.selectedImageName];
    }
    else
    {
        self.imgvTop.image = [UIImage imageNamed:self.normalImageName];
    }
}

#pragma mark - Layout Methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect_imgvTop = self.imgvTop.frame;
    CGRect rect_lblBottom = self.lblBottom.frame;
    
    CGFloat avlWid = self.frame.size.width;
    CGFloat avlHei = self.frame.size.height;
    CGFloat xOffset = BottomTabButton_LeftMargin;
    CGFloat yOffset = BottomTabButton_TopMargin;
    
    avlWid -= (2 * xOffset);
    avlHei -= ((2 * yOffset) + BottomTabButton_ImgLblMargin);
    
    CGFloat imgWidth = avlWid;
    CGFloat imgHeight = avlHei;
    CGFloat imgxOffset = xOffset;
    CGFloat imgyOffset = yOffset;
    if (imgWidth > BottomTabButton_ImageWidth)
    {
        imgxOffset += (avlWid - BottomTabButton_ImageWidth) * 0.5;
        imgWidth = BottomTabButton_ImageWidth;
    }
    if (imgHeight > BottomTabButton_ImageHeight)
    {
        imgyOffset += (avlHei - BottomTabButton_ImageHeight) * 0.5;
        imgHeight = BottomTabButton_ImageHeight;
    }

    rect_imgvTop.origin.x = imgxOffset;
    rect_imgvTop.origin.y = imgyOffset;
    rect_imgvTop.size.width = imgWidth;
    rect_imgvTop.size.height = imgHeight;
    
    yOffset += (rect_imgvTop.size.height + BottomTabButton_ImgLblMargin);
    
    rect_lblBottom.origin.x = xOffset;
    rect_lblBottom.origin.y = yOffset;
    rect_lblBottom.size.width = avlWid;
    rect_lblBottom.size.height = avlHei * 0.5;
    
    self.imgvTop.frame = rect_imgvTop;
    self.lblBottom.frame = rect_lblBottom;
    
//    self.imgvTop.backgroundColor = [UIColor blueColor];
//    self.backgroundColor = [UIColor redColor];
}

#pragma mark - UI Methods

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
        _lblBottom.clipsToBounds = YES;
        _lblBottom.font = [Globals shared].defaultTextFont;
        _lblBottom.textColor = [Globals shared].themingAssistant.homeBtnTitleColor;
        _lblBottom.backgroundColor = [Globals shared].themingAssistant.btmBarBtnTitleColor;
        _lblBottom.textAlignment = NSTextAlignmentCenter;
        _lblBottom.adjustsFontSizeToFitWidth = YES;
        _lblBottom.numberOfLines = 0;
        
//        [self addSubview:_lblBottom];
    }
    return _lblBottom;
}

@end
