//
//  CreateServiceRequestView.m
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CreateServiceRequestView.h"
#import "ColoredButton.h"

const CGFloat CreateSerReq_Btn_Height = 60;

@interface CreateServiceRequestView()

@property (nonatomic, strong) BaseLabel* lblInfo;
@property (nonatomic, strong) ColoredButton* btnCreateRequest;

@end

@implementation CreateServiceRequestView

- (void)updateUI
{
    [self addSubview:self.lblInfo];
    [self addSubview:self.btnCreateRequest];
}

#pragma mark - UI Methods

- (BaseLabel *)lblInfo
{
    if (_lblInfo == nil)
    {
        _lblInfo = [self getBaseLabel];
        
        CGRect rect = self.bounds;
        rect.origin.x = self.contentInsets.left;
        rect.origin.y = self.contentInsets.top;
        rect.size.width = self.contentWidth * 0.6;
        rect.size.height = self.contentHeight;
        _lblInfo.frame = rect;
        
        _lblInfo.text = @"You can raise problem request to report a problem";
        
        _lblInfo.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        _lblInfo.textColor = [UIColor whiteColor];
    }
    return _lblInfo;
}

- (ColoredButton *)btnCreateRequest
{
    if (_btnCreateRequest == nil)
    {
        CGRect rect = self.bounds;
        rect.size.width = self.contentWidth * 0.4;
        rect.size.height = CreateSerReq_Btn_Height;
        rect.origin.x = self.contentWidth + self.contentInsets.left - rect.size.width;
        rect.origin.y = (self.frame.size.height - rect.size.height) * 0.5;

        _btnCreateRequest = [ColoredButton coloredButtonType:ColoredButtonType_Clear frame:rect];
        _btnCreateRequest.borderNormalColor = [Globals shared].themingAssistant.defaultBorderColor;
        _btnCreateRequest.normalBorderWidth = 1;
        _btnCreateRequest.layer.cornerRadius = 6;
        _btnCreateRequest.bgNormalColor = [UIColor whiteColor];
        [_btnCreateRequest setTitle:@"Create Request" forState:UIControlStateNormal];
        _btnCreateRequest.titleNormalColor = [Globals shared].themingAssistant.defaultTextColor;
        
        [_btnCreateRequest addTarget:self action:@selector(onBtnCreateRequest:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCreateRequest;
}

- (void) onBtnCreateRequest:(ColoredButton *)sender
{
    if (self.onCreateRequest != nil)
    {
        self.onCreateRequest(sender);
    }
}

@end
