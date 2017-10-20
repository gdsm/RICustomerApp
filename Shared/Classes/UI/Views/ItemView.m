//
//  ItemView.m
//  ReddyIce
//
//  Created by Gagan on 15/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ItemView.h"
#import "Globals.h"

const CGFloat ItemView_TopMargin = 15;
const CGFloat ItemView_BottomMargin = 15;
const CGFloat ItemView_LeftMargin = 15;
const CGFloat ItemView_RightMargin = 15;
const CGFloat ItemView_ImgvTitleLabelMargin = 20;
const CGFloat ItemView_TitleLabelHeight = 30;
const CGFloat ItemView_TitlePriceLabelMargin = 0;
const CGFloat ItemView_PriceLabelHeight = 20;
const CGFloat ItemView_PriceVariationLabelMargin = 15;

const CGFloat ItemView_VariationLabelHeight = 25;
const CGFloat ItemView_CartVariationViewMargin = 5;
const CGFloat ItemView_VariationViewHeight = 38;

const CGFloat ItemView_CartQuantityLabelHeight = 25;


@implementation ItemView

- (void)updateUI
{
    self.itemVariationView.hideCheckMark = YES;
    [self.itemVariationView updateUI];
}

- (void)setVarSelected:(blk_variationSelected)varSelected
{
    _varSelected = varSelected;
    self.itemVariationView.varSelected = varSelected;
}

- (void)layoutUI
{
    CGRect rect_imgvItem = self.imgvItem.frame;
    CGRect rect_lblTitle = self.lblTitle.frame;
    CGRect rect_lblPriceDescr = self.lblPriceDescr.frame;
    CGRect rect_lblVariation = self.lblVariationDescr.frame;
    CGRect rect_itmVarView = self.itemVariationView.frame;
    CGRect rect_lblCartQuantity = self.lblCartQuantity.frame;
    CGRect rect_viewUnderline = self.viewUnderLine.frame;

    
    CGFloat xOffset = ItemView_LeftMargin;
    CGFloat yOffset = ItemView_RightMargin;
    CGFloat avlWidth = self.frame.size.width - (ItemView_LeftMargin + ItemView_RightMargin);
    CGFloat avlHeight = self.frame.size.height - (ItemView_TopMargin + ItemView_BottomMargin);
    
    rect_imgvItem.origin.x = xOffset;
    rect_imgvItem.origin.y = yOffset;
    CGFloat imgvWidth = avlWidth * 0.35;
    rect_imgvItem.size.width = imgvWidth;
    rect_imgvItem.size.height = avlHeight;

    xOffset += (rect_imgvItem.size.width + ItemView_ImgvTitleLabelMargin);
    avlWidth -= (rect_imgvItem.size.width + ItemView_ImgvTitleLabelMargin);
    
    rect_lblTitle.origin.x = xOffset;
    rect_lblTitle.origin.y = yOffset;
    rect_lblTitle.size.width = avlWidth;
    rect_lblTitle.size.height = ItemView_TitleLabelHeight;

    yOffset += (rect_lblTitle.size.height + ItemView_TitlePriceLabelMargin);

    rect_lblPriceDescr.origin.x = xOffset;
    rect_lblPriceDescr.origin.y = yOffset;
    rect_lblPriceDescr.size.width = avlWidth;
    rect_lblPriceDescr.size.height = ItemView_PriceLabelHeight;

    yOffset += (ItemView_PriceVariationLabelMargin + ItemView_PriceLabelHeight);

    rect_lblVariation.origin.x = xOffset;
    rect_lblVariation.origin.y = yOffset;
    rect_lblVariation.size.width = avlWidth;
    rect_lblVariation.size.height = ItemView_VariationLabelHeight;

    
    yOffset = (avlHeight + ItemView_TopMargin - ItemView_CartQuantityLabelHeight);

    rect_lblCartQuantity.origin.x = xOffset;
    rect_lblCartQuantity.origin.y = yOffset;
    rect_lblCartQuantity.size.width = avlWidth;
    rect_lblCartQuantity.size.height = ItemView_CartQuantityLabelHeight;
    
    yOffset -= (ItemView_CartVariationViewMargin + ItemView_VariationViewHeight);

    rect_itmVarView.origin.x = xOffset;
    rect_itmVarView.origin.y = yOffset;
    rect_itmVarView.size.width = avlWidth;
    rect_itmVarView.size.height = ItemView_VariationViewHeight;

    
    
    rect_viewUnderline.origin.x = ItemView_LeftMargin;
    rect_viewUnderline.origin.y = (self.frame.size.height - seperatorHeight);
    rect_viewUnderline.size.width = self.frame.size.width - (ItemView_LeftMargin + ItemView_RightMargin);
    rect_viewUnderline.size.height = seperatorHeight;

    
    self.imgvItem.frame = rect_imgvItem;
    self.lblTitle.frame = rect_lblTitle;
    self.lblPriceDescr.frame = rect_lblPriceDescr;
    self.lblVariationDescr.frame = rect_lblVariation;
    self.itemVariationView.frame = rect_itmVarView;
    self.lblCartQuantity.frame = rect_lblCartQuantity;
    self.viewUnderLine.frame = rect_viewUnderline;

    [self.itemVariationView layoutUI];
}

- (UIImageView *)imgvItem
{
    if (_imgvItem == nil)
    {
        _imgvItem = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
        _imgvItem.contentMode = UIViewContentModeScaleAspectFit;
        _imgvItem.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_imgvItem];
    }
    return _imgvItem;
}

- (UILabel *)lblTitle
{
    if (_lblTitle == nil)
    {
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, ItemView_TitleLabelHeight)];
        _lblTitle.backgroundColor = [UIColor clearColor];
        _lblTitle.textColor = [Globals shared].themingAssistant.itemTitleColor;
        _lblTitle.font = [Globals shared].defaultTextFont;
        _lblTitle.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_lblTitle];
    }
    return _lblTitle;
}

- (UILabel *) lblPriceDescr
{
    if (_lblPriceDescr == nil)
    {
        _lblPriceDescr = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, ItemView_PriceLabelHeight)];
        _lblPriceDescr.backgroundColor = [UIColor clearColor];
        _lblPriceDescr.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblPriceDescr.font = [Globals shared].defaultInfoFont;
        _lblPriceDescr.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_lblPriceDescr];
    }
    return _lblPriceDescr;
}

- (UILabel *)lblVariationDescr
{
    if (_lblVariationDescr == nil)
    {
        _lblVariationDescr = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, ItemView_VariationLabelHeight)];
        _lblVariationDescr.backgroundColor = [UIColor clearColor];
        _lblVariationDescr.textColor = [Globals shared].themingAssistant.defaultTextColor;
        _lblVariationDescr.font = [Globals shared].defaultInfoFont;
        _lblVariationDescr.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_lblVariationDescr];
    }
    return _lblVariationDescr;
}

- (UILabel *) lblCartQuantity
{
    if (_lblCartQuantity == nil)
    {
        _lblCartQuantity = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, ItemView_CartQuantityLabelHeight)];
        _lblCartQuantity.backgroundColor = [UIColor clearColor];
        _lblCartQuantity.textColor = [Globals shared].themingAssistant.itemCartQtyTitleColor;
        _lblCartQuantity.font = [Globals shared].defaultInfoFont;
        _lblCartQuantity.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_lblCartQuantity];
    }
    return _lblCartQuantity;
}

- (ItemVariationView *) itemVariationView
{
    if (_itemVariationView == nil)
    {
        _itemVariationView = [[ItemVariationView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, ItemView_VariationLabelHeight)];
        _itemVariationView.backgroundColor = [UIColor clearColor];
        _itemVariationView.varSelected = self.varSelected;
        _itemVariationView.contentInsets = UIEdgeInsetsZero;
        [self addSubview:_itemVariationView];
    }
    return _itemVariationView;
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
