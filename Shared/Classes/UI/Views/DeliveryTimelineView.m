//
//  DeliveryTimelineView.m
//  ReddyIce
//
//  Created by Gagan on 19/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "DeliveryTimelineView.h"
#import "Globals.h"
#import "IconFontCodes.h"

const CGFloat DeliveryTimelineView_calendarIcon_width = 44;
const CGFloat DeliveryTimelineView_iconTitle_margin = 5;
const CGFloat DeliveryTimelineView_deliveryTimeIcon_margin = 5;

@interface DeliveryTimelineView()
@property (nonatomic, strong) UIImageView* imgvIcon;
@property (nonatomic, strong) UILabel* lblTitle;
@property (nonatomic, strong) UILabel* lblDeliveryTime;
@property (nonatomic, strong) UILabel* lblCalenderIcon;
@end

@implementation DeliveryTimelineView

- (void)updateUI
{
    self.backgroundColor = [Globals shared].themingAssistant.deliveryTimelineViewBgColor;
    [self layoutUI];
}

#pragma mark - Layout Methds

- (void)layoutUI
{
    CGRect rect_imgvIcon = self.imgvIcon.frame;
    CGRect rect_lblTitle = self.lblTitle.frame;
    CGRect rect_lblDeliveryTime = self.lblDeliveryTime.frame;
    CGRect rect_lblIcon = self.lblCalenderIcon.frame;

    CGFloat xOffset = self.contentInsets.left;
    
    rect_imgvIcon.origin.x = xOffset;
    rect_imgvIcon.origin.y = self.contentInsets.top;
    rect_imgvIcon.size.width = MIN(self.contentHeight, self.imgvIcon.image.size.width);
    rect_imgvIcon.size.height = MIN(self.contentHeight, self.imgvIcon.image.size.height);

    rect_lblIcon.origin.x = (self.contentWidth + self.contentInsets.left - DeliveryTimelineView_calendarIcon_width);
    rect_lblIcon.origin.y = self.contentInsets.top;
    rect_lblIcon.size.height = self.contentHeight;

    xOffset += (DeliveryTimelineView_iconTitle_margin + rect_imgvIcon.size.width);
    CGFloat avlWidth = self.contentWidth - (rect_imgvIcon.size.width + rect_lblIcon.size.width + DeliveryTimelineView_iconTitle_margin + DeliveryTimelineView_deliveryTimeIcon_margin);
    
    rect_lblTitle.origin.x = xOffset;
    rect_lblTitle.origin.y = self.contentInsets.top;
    rect_lblTitle.size.width = avlWidth * 0.4;
    rect_lblTitle.size.height = self.contentHeight;

    xOffset += (rect_lblTitle.size.width);

    rect_lblDeliveryTime.origin.x = xOffset;
    rect_lblDeliveryTime.origin.y = self.contentInsets.top;
    rect_lblDeliveryTime.size.width = avlWidth * 0.6;
    rect_lblDeliveryTime.size.height = self.contentHeight;

    self.imgvIcon.frame = rect_imgvIcon;
    self.lblTitle.frame = rect_lblTitle;
    self.lblDeliveryTime.frame = rect_lblDeliveryTime;
    self.lblCalenderIcon.frame = rect_lblIcon;
}

#pragma mark - UI Methods

- (UIImageView *)imgvIcon
{
    if (_imgvIcon == nil)
    {
        UIImage* img = [UIImage imageNamed:@"Delivery.png"];
        CGRect rect = CGRectMake(self.contentInsets.left, self.contentInsets.top , img.size.width, img.size.height);

        _imgvIcon = [[UIImageView alloc] initWithFrame:rect];
        _imgvIcon.image = img;
        _imgvIcon.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imgvIcon];
    }
    return _imgvIcon;
}

- (UILabel *)lblTitle
{
    if (_lblTitle == nil)
    {
        _lblTitle = [self getLabel];
        _lblTitle.text = @"Expected\rDelivery date";
        _lblTitle.textAlignment = NSTextAlignmentLeft;
        _lblTitle.textColor = [UIColor whiteColor];

        [self addSubview:_lblTitle];
    }
    return _lblTitle;
}

- (UILabel *)lblDeliveryTime
{
    if (_lblDeliveryTime == nil)
    {
        _lblDeliveryTime = [self getLabel];
        _lblDeliveryTime.text = @"16Oct‘17-17Oct’17";
        _lblDeliveryTime.textAlignment = NSTextAlignmentRight;
        _lblDeliveryTime.textColor = [UIColor whiteColor];

        [self addSubview:_lblDeliveryTime];
    }
    return _lblDeliveryTime;
}

- (UILabel *)lblCalenderIcon
{
    if (_lblCalenderIcon == nil)
    {
        _lblCalenderIcon = [self getLabel];
        _lblCalenderIcon.frame = CGRectMake(0, 0, DeliveryTimelineView_calendarIcon_width, self.contentHeight);
        _lblCalenderIcon.text = [IconFontCodes shared].calendar;
        _lblCalenderIcon.font = [Globals shared].defaultIconFont;
        _lblCalenderIcon.textAlignment = NSTextAlignmentCenter;
        _lblCalenderIcon.textColor = [UIColor whiteColor];

        [self addSubview:_lblCalenderIcon];
    }
    return _lblCalenderIcon;
}

@end
