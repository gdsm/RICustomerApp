//
//  TicketLineItemHeaderView.m
//  ReddyIce
//
//  Created by Gagan on 18/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "TicketLineItemHeaderView.h"
#import "TicketLineItemView.h"
#import "Globals.h"

@interface TicketLineItemHeaderView()
@property (nonatomic, strong) UILabel* lblProduct;
@property (nonatomic, strong) UILabel* lblBagSize;
@property (nonatomic, strong) UILabel* lblQty;
@property (nonatomic, strong) UILabel* lblAmount;
@end

@implementation TicketLineItemHeaderView

- (void)updateUI
{
}

- (void) layoutUI
{
    CGRect rect_lblProduct = self.lblProduct.frame;
    CGRect rect_lblBagSize = self.lblBagSize.frame;
    CGRect rect_lblQty = self.lblQty.frame;
    CGRect rect_lblAmount = self.lblAmount.frame;

    CGFloat xOffset = (self.contentInsets.left);
    CGFloat avlWidth = (self.contentWidth - (TLI_imageTitle_margin + TLI_titleSize_margin + TLI_sizeQty_margin + TLI_qtyAmount_margin));
    
    rect_lblProduct.origin.x = xOffset;
    rect_lblProduct.size.height = self.contentHeight;
    rect_lblProduct.size.width = avlWidth * (TLI_image_width_percent + TLI_title_width_percent);
    xOffset += (rect_lblProduct.size.width + TLI_titleSize_margin);
    
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

    self.lblProduct.frame = rect_lblProduct;
    self.lblBagSize.frame = rect_lblBagSize;
    self.lblQty.frame = rect_lblQty;
    self.lblAmount.frame = rect_lblAmount;
    
//    self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
//    self.lblBagSize.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.3];
//    self.lblQty.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
//    self.lblAmount.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
//    self.lblProduct.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.3];
}


#pragma mark - UI Method

- (UILabel *) lblProduct
{
    if (_lblProduct == nil)
    {
        _lblProduct = [self getLabel];
        _lblProduct.text = @"Products (1)";
        _lblProduct.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_lblProduct];
    }
    return _lblProduct;
}

- (UILabel *) lblBagSize
{
    if (_lblBagSize == nil)
    {
        _lblBagSize = [self getLabel];
        _lblBagSize.text = @"Bag Size";
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
        _lblQty.text = @"Qty";
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
        _lblAmount.text = @"Amount ($)";
        _lblAmount.textAlignment = NSTextAlignmentRight;
        [self addSubview:_lblAmount];
    }
    return _lblAmount;
}

@end
