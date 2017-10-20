//
//  CrauselView.m
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CrauselView.h"
#import "Globals.h"

const CGFloat CrauselView_PageControlHeight = 10;
const CGFloat CrauselView_ImagePageMargin = 20;

@interface CrauselView ()
@property (nonatomic, strong) UIImageView* imgv;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UILabel* lblDescription;
@end

@implementation CrauselView

- (void)updateUI
{
}

- (void) layoutUI
{
    CGRect rect_imgv = self.imgv.frame;
    CGRect rect_lblDescr = self.lblDescription.frame;
    CGRect rect_pageControl = self.pageControl.frame;

    CGFloat yOffset = self.contentInsets.top;
    CGFloat avlHeight = self.contentHeight - rect_pageControl.size.height - CrauselView_ImagePageMargin;
    
    
    rect_imgv.origin.x = self.contentInsets.left;
    rect_imgv.origin.y = yOffset;
    rect_imgv.size.width = self.contentWidth;
    if (self.lblDescription.hidden == YES)
    {
        rect_imgv.size.height = avlHeight;
    }
    else
    {
        rect_imgv.size.height = avlHeight * 0.6;
    }
    yOffset += rect_imgv.size.height;
    
    if (self.lblDescription.hidden == NO)
    {
        rect_lblDescr.origin.x = self.contentInsets.left;
        rect_lblDescr.origin.y = yOffset;
        rect_lblDescr.size.width = self.contentWidth;
        rect_lblDescr.size.height = avlHeight * 0.4;
        
        yOffset += rect_lblDescr.size.height;
    }
    
    rect_pageControl.origin.x = self.contentInsets.left;
    rect_pageControl.origin.y = (yOffset + CrauselView_ImagePageMargin);
    rect_pageControl.size.width = self.contentWidth;

    
    self.imgv.frame = rect_imgv;
    self.lblDescription.frame = rect_lblDescr;
    self.pageControl.frame = rect_pageControl;
}

- (UIImageView *) imgv
{
    if (_imgv == nil)
    {
        _imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prod_sample_0.png"]];
        _imgv.contentMode = UIViewContentModeScaleAspectFit;
        _imgv.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_imgv];
    }
    return _imgv;
}

- (UILabel *) lblDescription
{
    if (_lblDescription == nil)
    {
        _lblDescription = [[UILabel alloc] initWithFrame:self.bounds];
        _lblDescription.backgroundColor = [UIColor clearColor];
        _lblDescription.textAlignment = NSTextAlignmentCenter;
        _lblDescription.text = @"The humble ice cube; we’ve thought a lot about it, so yo don’t have to think about anything more than what size bag you’ll need. We’ve thought a lot about how to purify the water...";
        _lblDescription.textColor = [Globals shared].themingAssistant.itemTitleColor;
        _lblDescription.font = [Globals shared].defaultTextFont;
        _lblDescription.adjustsFontSizeToFitWidth = YES;
        _lblDescription.numberOfLines = 0;
        _lblDescription.hidden = YES;

        [self addSubview:_lblDescription];
    }
    return _lblDescription;
}

- (UIPageControl *) pageControl
{
    if (_pageControl == nil)
    {
        CGRect rect = self.bounds;
        rect.size.height = CrauselView_PageControlHeight;
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.numberOfPages = 3;
        _pageControl.pageIndicatorTintColor = [Globals shared].themingAssistant.crauselDotColor;

        [self addSubview:_pageControl];
    }
    return _pageControl;
}

@end
