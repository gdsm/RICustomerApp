//
//  TicketLineItemView.h
//  ReddyIce
//
//  Created by Gagan on 18/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "CheckBox.h"

extern const CGFloat TLI_checkBox_Size;

extern const CGFloat TLI_checkBoxImage_margin;
extern const CGFloat TLI_imageTitle_margin;
extern const CGFloat TLI_titleSize_margin;
extern const CGFloat TLI_sizeQty_margin;
extern const CGFloat TLI_qtyAmount_margin;

extern const CGFloat TLI_image_width_percent;
extern const CGFloat TLI_title_width_percent;
extern const CGFloat TLI_size_width_percent;
extern const CGFloat TLI_qty_width_percent;
extern const CGFloat TLI_amt_width_percent;

@interface TicketLineItemView : BaseView

@property (nonatomic, strong) CheckBox* checkbox;
@property (nonatomic, strong) UIImageView* imgvProduct;
@property (nonatomic, strong) UILabel* lblTitle;
@property (nonatomic, strong) UILabel* lblBagSize;
@property (nonatomic, strong) UILabel* lblQty;
@property (nonatomic, strong) UILabel* lblAmount;
@property (nonatomic, strong) BaseView* viewUnderLine;

@end
