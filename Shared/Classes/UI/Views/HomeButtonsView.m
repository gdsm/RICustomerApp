//
//  HomeButtonsView.m
//  ReddyIce
//
//  Created by Gagan on 12/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "HomeButtonsView.h"
#import "HomeButton.h"

const CGFloat HomeButtonView_TopMargin = 10;
const CGFloat HomeButtonView_BottomMargin = 10;
const CGFloat HomeButtonView_LeftMargin = 10;
const CGFloat HomeButtonView_RightMargin = 10;
const CGFloat HomeButtonView_VinnerMargin = 10;
const CGFloat HomeButtonView_HinnerMargin = 10;


@interface HomeButtonsView ()
@property (nonatomic, strong) HomeButton* btnPlaceOrder;
@property (nonatomic, strong) HomeButton* btnDeliveryHistory;
@property (nonatomic, strong) HomeButton* btnReportAProb;
@property (nonatomic, strong) HomeButton* btnShareFeedback;
@end


@implementation HomeButtonsView

- (CGSize) estimatedSize
{
    CGSize retSize = CGSizeMake(0, 0);
    retSize.height = 350;
    return retSize;
}

- (void) layoutUI
{
    CGRect rect_btnPlaceOrder = self.btnPlaceOrder.frame;
    CGRect rect_btnReportProb = self.btnReportAProb.frame;
    CGRect rect_btnFeedback = self.btnShareFeedback.frame;
    CGRect rect_btnDeliveryHistory = self.btnDeliveryHistory.frame;

    CGFloat interXMargin = self.frame.size.width * 0.05;
    CGFloat interYMargin = self.frame.size.height * 0.05;
    if (interXMargin < interYMargin)
    {
        interYMargin = interXMargin;
    }
    else if (interYMargin < interXMargin)
    {
        interXMargin = interYMargin;
    }

    CGFloat w = (self.frame.size.width - (3*interXMargin));
    CGFloat h = (self.frame.size.height - (3*interYMargin));
    CGFloat wh = MIN(w, h) * 0.5;
    CGFloat occupW = (wh * 2) + (interXMargin);

    CGFloat xOffset = ((self.frame.size.width - occupW) * 0.5);
    CGFloat yOffset = interYMargin;

    rect_btnDeliveryHistory.origin.x = xOffset;
    rect_btnDeliveryHistory.origin.y = yOffset;
    rect_btnDeliveryHistory.size.width = wh;
    rect_btnDeliveryHistory.size.height = wh;
    
    rect_btnFeedback.origin.x = rect_btnDeliveryHistory.origin.x + rect_btnDeliveryHistory.size.width + interXMargin;
    rect_btnFeedback.origin.y = yOffset;
    rect_btnFeedback.size.width = wh;
    rect_btnFeedback.size.height = wh;

    rect_btnPlaceOrder.origin.x = xOffset;
    rect_btnPlaceOrder.origin.y = rect_btnDeliveryHistory.origin.y + rect_btnDeliveryHistory.size.height + interYMargin;
    rect_btnPlaceOrder.size.width = wh;
    rect_btnPlaceOrder.size.height = wh;

    rect_btnReportProb.origin.x = rect_btnDeliveryHistory.origin.x + rect_btnDeliveryHistory.size.width + interXMargin;
    rect_btnReportProb.origin.y = rect_btnDeliveryHistory.origin.y + rect_btnDeliveryHistory.size.height + interYMargin;
    rect_btnReportProb.size.width = wh;
    rect_btnReportProb.size.height = wh;

    self.btnPlaceOrder.frame = rect_btnPlaceOrder;
    self.btnReportAProb.frame = rect_btnReportProb;
    self.btnShareFeedback.frame = rect_btnFeedback;
    self.btnDeliveryHistory.frame = rect_btnDeliveryHistory;


    self.btnPlaceOrder.layer.cornerRadius = wh * 0.5;
    self.btnReportAProb.layer.cornerRadius = wh * 0.5;
    self.btnShareFeedback.layer.cornerRadius = wh * 0.5;
    self.btnDeliveryHistory.layer.cornerRadius = wh * 0.5;
}

- (HomeButton *) btnPlaceOrder
{
    if (_btnPlaceOrder == nil)
    {
        //TODO:[GM]: Add Localisation
        _btnPlaceOrder = [self getButton:@"Order.png" title:@"Ice\rOrder"];
        [_btnPlaceOrder addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_btnPlaceOrder];
    }
    return _btnPlaceOrder;
}

- (HomeButton *) btnReportAProb
{
    if (_btnReportAProb == nil)
    {
        //TODO:[GM]: Add Localisation
        _btnReportAProb = [self getButton:@"Problem.png" title:@"Equipment\rRepair"];
        [_btnReportAProb addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:_btnReportAProb];
    }
    return _btnReportAProb;
}

- (HomeButton *) btnShareFeedback
{
    if (_btnShareFeedback == nil)
    {
        //TODO:[GM]: Add Localisation
        _btnShareFeedback = [self getButton:@"Feedback.png" title:@"Share\rFeedback"];
        [_btnShareFeedback addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnShareFeedback];
    }
    return _btnShareFeedback;
}

- (HomeButton *) btnDeliveryHistory
{
    if (_btnDeliveryHistory == nil)
    {
        //TODO:[GM]: Add Localisation
        _btnDeliveryHistory = [self getButton:@"Delivery.png" title:@"History"];
        [_btnDeliveryHistory addTarget:self action:@selector(onBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnDeliveryHistory];
    }
    return _btnDeliveryHistory;
}

- (void) onBtnTap:(HomeButton *)sender
{
    if ([sender isEqual:self.btnShareFeedback] && (self.callbackShareFeedback != nil))
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

- (HomeButton *) getButton:(NSString *)imageName title:(NSString *)title
{
    CGRect rect = CGRectMake(0, 0, 80, 80);
    HomeButton *btn = [HomeButton buttonWithType:UIButtonTypeCustom];
    btn.bgNormalColor = [Globals shared].themingAssistant.homeBtnBgNormColor;
    btn.bgHighlightedColor = [Globals shared].themingAssistant.homeBtnBgHighColor;
    btn.frame = rect;
    btn.layer.cornerRadius = 10;
    btn.clipsToBounds = YES;
    btn.imageName = imageName;
    btn.title = title;
    return btn;
}

@end

















//---> Old Design code : Keeping it for refrence;
//- (void) layoutUI
//{
//    CGRect rect_btnPlaceOrder = self.btnPlaceOrder.frame;
//    CGRect rect_btnReportProb = self.btnReportAProb.frame;
//    CGRect rect_btnFeedback = self.btnShareFeedback.frame;
//    CGRect rect_btnDeliveryHistory = self.btnDeliveryHistory.frame;
//
////    CGFloat xMargin = self.frame.size.width - (rect_btnPlaceOrder.size.width + rect_btnDeliveryHistory.size.width + HomeButtonView_HinnerMargin);
////    CGFloat yMargin = self.frame.size.height - (rect_btnPlaceOrder.size.height + rect_btnReportProb.size.height + HomeButtonView_VinnerMargin);
//
//    CGFloat xOffset = self.frame.size.width * 0.05;
//    CGFloat yOffset = self.frame.size.height * 0.05;
//    CGFloat interXMargin = self.frame.size.width * 0.05;
//    CGFloat interYMargin = self.frame.size.height * 0.05;
//    if (interXMargin < interYMargin)
//    {
//        interYMargin = interXMargin;
//    }
//    else if (interYMargin < interXMargin)
//    {
//        interXMargin = interYMargin;
//    }
//    CGFloat w = (self.frame.size.width - xOffset - interXMargin - xOffset) * 0.5;
//    CGFloat h = (self.frame.size.height - yOffset - interYMargin - yOffset) * 0.5;
//
//    rect_btnPlaceOrder.origin.x = xOffset;
//    rect_btnPlaceOrder.origin.y = yOffset;
//    rect_btnPlaceOrder.size.width = w;
//    rect_btnPlaceOrder.size.height = h;
//
//    rect_btnDeliveryHistory.origin.x = rect_btnPlaceOrder.origin.x + rect_btnPlaceOrder.size.width + interXMargin;
//    rect_btnDeliveryHistory.origin.y = yOffset;
//    rect_btnDeliveryHistory.size.width = w;
//    rect_btnDeliveryHistory.size.height = h;
//
//    rect_btnReportProb.origin.x = xOffset;
//    rect_btnReportProb.origin.y = rect_btnPlaceOrder.origin.y + rect_btnPlaceOrder.size.height + interYMargin;
//    rect_btnReportProb.size.width = w;
//    rect_btnReportProb.size.height = h;
//
//    rect_btnFeedback.origin.x = rect_btnPlaceOrder.origin.x + rect_btnPlaceOrder.size.width + interXMargin;
//    rect_btnFeedback.origin.y = rect_btnPlaceOrder.origin.y + rect_btnPlaceOrder.size.height + interYMargin;
//    rect_btnFeedback.size.width = w;
//    rect_btnFeedback.size.height = h;
//
//
//    self.btnPlaceOrder.frame = rect_btnPlaceOrder;
//    self.btnReportAProb.frame = rect_btnReportProb;
//    self.btnShareFeedback.frame = rect_btnFeedback;
//    self.btnDeliveryHistory.frame = rect_btnDeliveryHistory;
//}
