//
//  TicketLineItemView.m
//  ReddyIce
//
//  Created by Gagan on 18/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "TicketLineItemView.h"
#import "Globals.h"

const CGFloat TLI_checkBox_Size = 20;

const CGFloat TLI_checkBoxImage_margin = 5;
const CGFloat TLI_imageTitle_margin = 5;
const CGFloat TLI_titleSize_margin = 5;
const CGFloat TLI_sizeQty_margin = 5;
const CGFloat TLI_qtyAmount_margin = 5;

const CGFloat TLI_image_width_percent = 0.2;
const CGFloat TLI_title_width_percent = 0.3;
const CGFloat TLI_size_width_percent = 0.15;
const CGFloat TLI_qty_width_percent = 0.1;
const CGFloat TLI_amt_width_percent = 0.25;


@interface TicketLineItemView()
@end


@implementation TicketLineItemView

- (void)updateUI
{
    [self.checkbox updateUI];
}

#pragma mark - Logical Flow Methods

- (void) lineItemChecked
{
    
}

#pragma mark - Layout Methods

- (void) layoutUI
{
    CGRect rect_checkbox = self.checkbox.frame;
    CGRect rect_imgvProd = self.imgvProduct.frame;
    CGRect rect_lblTitle = self.lblTitle.frame;
    CGRect rect_lblBagSize = self.lblBagSize.frame;
    CGRect rect_lblQty = self.lblQty.frame;
    CGRect rect_lblAmount = self.lblAmount.frame;
    CGRect rect_viewUnderline = self.viewUnderLine.frame;

    CGFloat xOffset = self.contentInsets.left;
    CGFloat avlWidth = (self.contentWidth - (TLI_checkBoxImage_margin + TLI_imageTitle_margin + TLI_titleSize_margin + TLI_sizeQty_margin + TLI_qtyAmount_margin));

    if (self.checkbox.hidden == NO)
    {
        rect_checkbox.origin.y = (self.frame.size.height - TLI_checkBox_Size) * 0.5;
        xOffset += (rect_checkbox.size.width + TLI_checkBoxImage_margin);
        avlWidth -= (rect_checkbox.size.width + TLI_checkBoxImage_margin);
    }
    
    rect_imgvProd.origin.x = xOffset;
    rect_imgvProd.size.height = self.contentHeight;
    rect_imgvProd.size.width = avlWidth * TLI_image_width_percent;
    xOffset += (rect_imgvProd.size.width + TLI_imageTitle_margin);

    rect_lblTitle.origin.x = xOffset;
    rect_lblTitle.size.height = self.contentHeight;
    rect_lblTitle.size.width = avlWidth * TLI_title_width_percent;
    xOffset += (rect_lblTitle.size.width + TLI_titleSize_margin);

    rect_lblBagSize.origin.x = xOffset;
    rect_lblBagSize.size.height = self.contentHeight;
    rect_lblBagSize.size.width = avlWidth * TLI_size_width_percent;
    xOffset += (rect_lblBagSize.size.width + TLI_sizeQty_margin);

    rect_lblQty.origin.x = xOffset;
    rect_lblQty.size.height = self.contentHeight;
    rect_lblQty.size.width = avlWidth * TLI_qty_width_percent;
    xOffset += (rect_lblQty.size.width + TLI_qtyAmount_margin);

    rect_lblAmount.origin.x = xOffset;
    rect_lblAmount.size.height = self.contentHeight;
    rect_lblAmount.size.width = avlWidth * TLI_amt_width_percent;

    rect_viewUnderline.origin.x = self.contentInsets.left;
    rect_viewUnderline.origin.y = (self.frame.size.height - seperatorHeight);
    rect_viewUnderline.size.width = self.frame.size.width - (self.contentInsets.left + self.contentInsets.right);
    rect_viewUnderline.size.height = seperatorHeight;

    self.checkbox.frame = rect_checkbox;
    self.imgvProduct.frame = rect_imgvProd;
    self.lblTitle.frame = rect_lblTitle;
    self.lblBagSize.frame = rect_lblBagSize;
    self.lblQty.frame = rect_lblQty;
    self.lblAmount.frame = rect_lblAmount;
    self.viewUnderLine.frame = rect_viewUnderline;

    
//    self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
//    self.imgvProduct.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
//    self.lblBagSize.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
//    self.lblQty.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
//    self.lblAmount.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
//    self.lblTitle.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5];
}

#pragma mark - UI Method

- (CheckBox *) checkbox
{
    if (_checkbox == nil)
    {
        __weak TicketLineItemView* weakSelf = self;
        
        CGRect rect = CGRectMake(self.contentInsets.left, (self.frame.size.height - TLI_checkBox_Size) * 0.5 , TLI_checkBox_Size, TLI_checkBox_Size);
        _checkbox = [[CheckBox alloc] initWithFrame:rect];
        [_checkbox updateUI];
        _checkbox.onCheckboxCallback = ^(id sender) {
            [weakSelf lineItemChecked];
        };
        [self addSubview:_checkbox];
        return _checkbox;
    }
    return _checkbox;
}

- (UIImageView *)imgvProduct
{
    if (_imgvProduct == nil)
    {
        CGRect rect = CGRectMake(self.contentInsets.left, self.contentInsets.top , self.contentWidth * 0.35, self.contentHeight);
        _imgvProduct = [[UIImageView alloc] initWithFrame:rect];
        _imgvProduct.image = [UIImage imageNamed:@"prod_sample_0.png"];
        _imgvProduct.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imgvProduct];
    }
    return _imgvProduct;
}

- (UILabel *) lblTitle
{
    if (_lblTitle == nil)
    {
        _lblTitle = [self getLabel];
        _lblTitle.text = @"Crystal Classic CubesTM";
        _lblTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_lblTitle];
    }
    return _lblTitle;
}

- (UILabel *) lblBagSize
{
    if (_lblBagSize == nil)
    {
        _lblBagSize = [self getLabel];
        _lblBagSize.text = @"20 lbs";
        _lblBagSize.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lblBagSize];
    }
    return _lblBagSize;
}

- (UILabel *) lblQty
{
    if (_lblQty == nil)
    {
        _lblQty = [self getLabel];
        _lblQty.text = @"100";
        _lblQty.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lblQty];
    }
    return _lblQty;
}

- (UILabel *) lblAmount
{
    if (_lblAmount == nil)
    {
        _lblAmount = [self getLabel];
        _lblAmount.text = @"$100.00";
        _lblAmount.textAlignment = NSTextAlignmentRight;
        [self addSubview:_lblAmount];
    }
    return _lblAmount;
}

- (BaseView *) viewUnderLine
{
    if (_viewUnderLine == nil)
    {
        _viewUnderLine = [[BaseView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, seperatorHeight)];
        _viewUnderLine.hidden = NO;
        _viewUnderLine.backgroundColor = [Globals shared].themingAssistant.itemCartQtyTitleColor;
        
        [self addSubview:_viewUnderLine];
    }
    return _viewUnderLine;
}

@end
