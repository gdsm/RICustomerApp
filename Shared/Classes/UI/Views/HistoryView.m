//
//  HistoryView.m
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "HistoryView.h"
#import "PathCheckboxView.h"
#import "Globals.h"
#import "IconFontCodes.h"


@interface HistoryView ()

@property (nonatomic, strong) BaseLabel* lblOrderNo;
@property (nonatomic, strong) BaseLabel* lblTotalAmount;
@property (nonatomic, strong) BaseLabel* lblStatus;
@property (nonatomic, strong) BaseLabel* lblStartTime;
@property (nonatomic, strong) BaseLabel* lblEndTime;
@property (nonatomic, strong) PathCheckboxView* pathView;
@property (nonatomic, strong) BaseView* viewUnderLine;

@end


@implementation HistoryView

- (void)updateUI
{
    [self addSubview:self.lblOrderNo];
    [self addSubview:self.lblTotalAmount];
    [self addSubview:self.lblStatus];
    [self addSubview:self.lblStartTime];
    [self addSubview:self.lblEndTime];
    [self addSubview:self.pathView];
    [self addSubview:self.viewUnderLine];
}

- (void)setHistoryType:(HistoryType)historyType
{
    _historyType = historyType;
    
    switch (_historyType)
    {
        case HistoryType_Order:
        {
            self.pathView.hidden = NO;
            self.lblStatus.hidden = NO;
            self.lblTotalAmount.textAlignment = NSTextAlignmentCenter;

            [self.lblStatus defaultTextFont];
            self.lblStatus.backgroundColor = [UIColor whiteColor];
            self.lblStatus.text = @"New Order";
            self.lblStatus.layer.borderWidth = 1;
            self.lblStatus.textAlignment = NSTextAlignmentCenter;
        }break;
        case HistoryType_Delivery:
        {
            self.pathView.hidden = YES;
            self.lblStatus.hidden = YES;
            self.lblTotalAmount.textAlignment = NSTextAlignmentRight;
        }break;
        case HistoryType_DNS:
        {
            self.pathView.hidden = YES;
            self.lblStatus.hidden = NO;
            self.lblTotalAmount.textAlignment = NSTextAlignmentCenter;

            [self.lblStatus defaultIconFont];
            self.lblStatus.text = [IconFontCodes shared].image;
            self.lblStatus.backgroundColor = [UIColor clearColor];
            self.lblStatus.layer.borderWidth = 0;
            self.lblStatus.textAlignment = NSTextAlignmentRight;
        }break;
        default:
            break;
    }
}

- (void)setHidePathView:(BOOL)hidePathView
{
    _hidePathView = hidePathView;
    self.pathView.hidden = hidePathView;
}

- (void) layoutUI
{
    CGRect rect_lblOrder = self.lblOrderNo.frame;
    CGRect rect_lblTotal = self.lblTotalAmount.frame;
    CGRect rect_lblStatus = self.lblStatus.frame;
    CGRect rect_lblStartTime = self.lblStartTime.frame;
    CGRect rect_pathView = self.pathView.frame;
    CGRect rect_lblEndTime = self.lblEndTime.frame;

    CGFloat xOffset = self.contentInsets.left;
    CGFloat yOffset = self.contentInsets.top;
    CGFloat widthDivider[] = {0.3f, 0.4f, 0.3f};
    if (self.historyType == HistoryType_Delivery)
    {
        widthDivider[0] = 0.5f;
        widthDivider[1] = 0.5f;
        widthDivider[2] = 0.0f;
    }

    rect_lblOrder.origin.x = xOffset;
    rect_lblOrder.origin.y = yOffset;
    rect_lblOrder.size.width = self.contentWidth * widthDivider[0];
    rect_lblOrder.size.height = self.contentHeight * 0.5;

    xOffset += rect_lblOrder.size.width;

    rect_lblTotal.origin.x = xOffset;
    rect_lblTotal.origin.y = yOffset;
    rect_lblTotal.size.width = self.contentWidth * widthDivider[1];
    rect_lblTotal.size.height = self.contentHeight * 0.5;

    xOffset += rect_lblTotal.size.width;

    rect_lblStatus.origin.x = xOffset;
    rect_lblStatus.origin.y = yOffset;
    rect_lblStatus.size.width = self.contentWidth * widthDivider[2];
    rect_lblStatus.size.height = self.contentHeight * 0.5;
    
    xOffset = self.contentInsets.left;
    yOffset += rect_lblOrder.size.height;
    
    rect_lblStartTime.origin.x = xOffset;
    rect_lblStartTime.origin.y = yOffset;
    rect_lblStartTime.size.width = self.contentWidth * 0.3;
    rect_lblStartTime.size.height = self.contentHeight * 0.5;

    xOffset += rect_lblStartTime.size.width;

    rect_pathView.origin.x = xOffset;
    rect_pathView.origin.y = yOffset;
    rect_pathView.size.width = self.contentWidth * 0.4;
    rect_pathView.size.height = self.contentHeight * 0.5;

    xOffset += rect_pathView.size.width;
    
    rect_lblEndTime.origin.x = xOffset;
    rect_lblEndTime.origin.y = yOffset;
    rect_lblEndTime.size.width = self.contentWidth * 0.3;
    rect_lblEndTime.size.height = self.contentHeight * 0.5;

    self.lblOrderNo.frame = rect_lblOrder;
    self.lblTotalAmount.frame = rect_lblTotal;
    self.lblStatus.frame = rect_lblStatus;
    self.lblStartTime.frame = rect_lblStartTime;
    self.pathView.frame = rect_pathView;
    self.lblEndTime.frame = rect_lblEndTime;
    
    [self.pathView layoutUI];
}

- (BaseLabel *)lblStatus
{
    if (_lblStatus == nil)
    {
        _lblStatus = [self getBaseLabel];
        _lblStatus.backgroundColor = [UIColor whiteColor];
        _lblStatus.text = @"New Order";
        _lblStatus.textAlignment = NSTextAlignmentCenter;
        _lblStatus.layer.cornerRadius = 6;
        _lblStatus.layer.borderColor = [Globals shared].themingAssistant.defaultBorderColor.CGColor;
        _lblStatus.layer.borderWidth = seperatorHeight_1px;
        _lblStatus.clipsToBounds = YES;
    }
    return _lblStatus;
}

- (BaseLabel *) lblTotalAmount
{
    if (_lblTotalAmount == nil)
    {
        _lblTotalAmount = [self getBaseLabel];
        _lblTotalAmount.backgroundColor = [UIColor clearColor];
        _lblTotalAmount.textAlignment = NSTextAlignmentCenter;
        _lblTotalAmount.text = @"$000.00";
    }
    return _lblTotalAmount;
}

- (BaseLabel *) lblOrderNo
{
    if (_lblOrderNo == nil)
    {
        _lblOrderNo = [self getBaseLabel];
        _lblOrderNo.backgroundColor = [UIColor clearColor];
        _lblOrderNo.textAlignment = NSTextAlignmentLeft;
        _lblOrderNo.text = @"0000000001";
    }
    return _lblOrderNo;
}

- (BaseLabel *) lblStartTime
{
    if (_lblStartTime == nil)
    {
        _lblStartTime = [self getBaseLabel];
        _lblStartTime.backgroundColor = [UIColor clearColor];
        _lblStartTime.text = @"13 Oct 17, 19:12";
    }
    return _lblStartTime;
}

- (BaseLabel *) lblEndTime
{
    if (_lblEndTime == nil)
    {
        _lblEndTime = [self getBaseLabel];
        _lblEndTime.backgroundColor = [UIColor clearColor];
        _lblEndTime.textAlignment = NSTextAlignmentRight;
        _lblEndTime.text = @"17 Oct 17, 19:12";
    }
    return _lblEndTime;
}

- (PathCheckboxView *)pathView
{
    if (_pathView == nil)
    {
        _pathView = [[PathCheckboxView alloc] initWithFrame:self.bounds];
        _pathView.backgroundColor = [UIColor clearColor];
        [_pathView updateUI];
        _pathView.chkStart.onCheckboxCallback = self.onStartPathCheck;
        _pathView.chkEnd.onCheckboxCallback = self.onEndPathCheck;
    }
    return _pathView;
}

- (BaseView *) viewUnderLine
{
    if (_viewUnderLine == nil)
    {
        _viewUnderLine = [[BaseView alloc] initWithFrame:CGRectMake(self.contentInsets.left, self.frame.size.height - seperatorHeight_1px, self.contentWidth, seperatorHeight_1px)];
        _viewUnderLine.hidden = NO;
        _viewUnderLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _viewUnderLine.backgroundColor = [Globals shared].themingAssistant.itemCartQtyTitleColor;
    }
    return _viewUnderLine;
}

@end
