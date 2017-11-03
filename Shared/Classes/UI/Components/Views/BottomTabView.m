//
//  BottomTabView.m
//  ReddyIce
//
//  Created by Gagan on 13/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BottomTabView.h"


const CGFloat BottomBtnView_Height = 50;
const CGFloat BottomBtnView_TopMargin = 2;
const CGFloat BottomBtnView_BottomMargin = 2;
const CGFloat BottomBtnView_LeftMargin = 0;
const CGFloat BottomBtnView_RightMargin = 0;
const CGFloat BottomBtnView_InterMargin = 2;


@interface BottomTabView ()
@property (nonatomic, strong) BaseView* viewSeperator;
@property (nonatomic, strong) UITabBar* tabBar;
@end


@implementation BottomTabView

- (CGSize) estimatedSize
{
    CGSize retSize = CGSizeMake(0, 0);
    retSize.height = BottomBtnView_Height;
    return retSize;
}

- (void) unselectBottomTabs
{
    self.btnHome.selected = NO;
    self.btnPlaceOrder.selected = NO;
    self.btnReportAProb.selected = NO;
    self.btnShareFeedback.selected = NO;
    self.btnDeliveryHistory.selected = NO;
}

- (void) updateUI
{
//    [self addSubview:self.tabBar];
    self.backgroundColor = [UIColor whiteColor];
}

- (void) layoutUI
{
    CGRect rect_btnHome = self.btnHome.frame;
    CGRect rect_btnPlaceOrder = self.btnPlaceOrder.frame;
    CGRect rect_btnReportProb = self.btnReportAProb.frame;
    CGRect rect_btnFeedback = self.btnShareFeedback.frame;
    CGRect rect_btnDeliveryHistory = self.btnDeliveryHistory.frame;
    
    
    CGFloat xOffset = BottomBtnView_LeftMargin;
    CGFloat yOffset = BottomBtnView_TopMargin;
    CGFloat avlWidth = self.frame.size.width - ((2 * xOffset) + (4 * BottomBtnView_InterMargin));
    CGFloat avlHeight = self.frame.size.height - (2 * yOffset);
    CGFloat interMargin = BottomBtnView_InterMargin;
    
    CGFloat w = avlWidth / 5;
    CGFloat h = avlHeight;
    
    rect_btnHome.origin.x = xOffset;
    rect_btnHome.origin.x = xOffset;
    rect_btnHome.size.width = w;
    rect_btnHome.size.height = h;
    
    xOffset += (w + interMargin);

    rect_btnPlaceOrder.origin.x = xOffset;
    rect_btnPlaceOrder.origin.y = yOffset;
    rect_btnPlaceOrder.size.width = w;
    rect_btnPlaceOrder.size.height = h;
    
    xOffset += (w + interMargin);

    rect_btnDeliveryHistory.origin.x = xOffset;
    rect_btnDeliveryHistory.origin.y = yOffset;
    rect_btnDeliveryHistory.size.width = w;
    rect_btnDeliveryHistory.size.height = h;
    
    xOffset += (w + interMargin);

    rect_btnReportProb.origin.x = xOffset;
    rect_btnReportProb.origin.y = yOffset;
    rect_btnReportProb.size.width = w;
    rect_btnReportProb.size.height = h;

    xOffset += (w + interMargin);

    rect_btnFeedback.origin.x = xOffset;
    rect_btnFeedback.origin.y = yOffset;
    rect_btnFeedback.size.width = w;
    rect_btnFeedback.size.height = h;
    
    
    self.btnHome.frame = rect_btnHome;
    self.btnPlaceOrder.frame = rect_btnPlaceOrder;
    self.btnReportAProb.frame = rect_btnReportProb;
    self.btnShareFeedback.frame = rect_btnFeedback;
    self.btnDeliveryHistory.frame = rect_btnDeliveryHistory;
    
//    self.backgroundColor = [UIColor redColor];
}


- (BottomTabButton *) btnHome
{
    if (_btnHome == nil)
    {
        _btnHome = [self getButton:@"Home_norm.png"
                  highlightedImage:@"Home_high.png"
                     selectedImage:@"Home_high.png"
                             title:@"Home"];
        [_btnHome addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_btnHome];
    }
    return _btnHome;
}

- (BottomTabButton *) btnPlaceOrder
{
    if (_btnPlaceOrder == nil)
    {
        _btnPlaceOrder = [self getButton:@"Products_norm.png"
                        highlightedImage:@"Products_high.png"
                           selectedImage:@"Products_high.png"
                                   title:@"Place Order"];
        [_btnPlaceOrder addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_btnPlaceOrder];
    }
    return _btnPlaceOrder;
}

- (BottomTabButton *) btnReportAProb
{
    if (_btnReportAProb == nil)
    {
        _btnReportAProb = [self getButton:@"Problem_norm.png"
                         highlightedImage:@"Problem_high.png"
                            selectedImage:@"Problem_high.png"
                                    title:@"Report a Problem"];
        [_btnReportAProb addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_btnReportAProb];
    }
    return _btnReportAProb;
}

- (BottomTabButton *) btnShareFeedback
{
    if (_btnShareFeedback == nil)
    {
        _btnShareFeedback = [self getButton:@"Feedback_norm.png"
                           highlightedImage:@"Feedback_high.png"
                              selectedImage:@"Feedback_high.png"
                                      title:@"Share Feedback"];
        [_btnShareFeedback addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnShareFeedback];
    }
    return _btnShareFeedback;
}

- (BottomTabButton *) btnDeliveryHistory
{
    if (_btnDeliveryHistory == nil)
    {
        _btnDeliveryHistory = [self getButton:@"Delivery_norm.png"
                             highlightedImage:@"Delivery_high.png"
                                selectedImage:@"Delivery_high.png"
                                        title:@"Delivery History"];
        [_btnDeliveryHistory addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnDeliveryHistory];
    }
    return _btnDeliveryHistory;
}

- (void) onBtnTap:(BottomTabButton *)sender
{
    if ([sender isEqual:self.btnHome] && (self.callbackHome != nil))
    {
        self.callbackHome(sender);
    }
    else if ([sender isEqual:self.btnShareFeedback] && (self.callbackShareFeedback != nil))
    {
        self.callbackShareFeedback(sender);
    }
    else if ([sender isEqual:self.btnReportAProb] && (self.callbackReportAProblem != nil))
    {
        self.callbackReportAProblem(sender);
    }
    else if ([sender isEqual:self.btnPlaceOrder] && (self.callbackPlaceOrder != nil))
    {
        self.callbackPlaceOrder(sender);
    }
    else if ([sender isEqual:self.btnDeliveryHistory] && (self.callbackDeliveryHistory != nil))
    {
        self.callbackDeliveryHistory(sender);
    }
}

- (BottomTabButton *) getButton:(NSString *)normImgName
               highlightedImage:(NSString *)highImgName
                  selectedImage:(NSString *)selImg
                          title:(NSString *)title
{
    CGRect rect = CGRectMake(0, 0, 80, 80);
    BottomTabButton *btn = [BottomTabButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    btn.layer.cornerRadius = 10;
    btn.clipsToBounds = YES;
    btn.normalImageName = normImgName;
    btn.highlightedImageName = highImgName;
    btn.selectedImageName = selImg;
    btn.title = title;
    return btn;
}

- (UITabBar *)tabBar
{
    if (_tabBar == nil)
    {
        _tabBar = [[UITabBar alloc] initWithFrame:self.bounds];
        _tabBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _tabBar;
}

@end
