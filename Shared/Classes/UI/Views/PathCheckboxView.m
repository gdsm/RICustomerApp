//
//  RouteCheckboxView.m
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "PathCheckboxView.h"
#import "Globals.h"



@implementation PathCheckboxView


- (void)updateUI
{
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Layout Method

- (void)layoutUI
{
    CGRect rect_chkStart = self.chkStart.frame;
    CGRect rect_viewUnderline = self.viewUnderLine.frame;
    CGRect rect_chkEnd = self.chkEnd.frame;

    CGFloat xOffset = self.contentInsets.left;

    rect_chkStart.origin.x = xOffset;
    rect_chkStart.origin.y = (self.frame.size.height - rect_chkStart.size.height) * 0.5;
    
    xOffset += rect_chkStart.size.width;

    rect_viewUnderline.origin.x = xOffset;
    rect_viewUnderline.origin.y = (self.frame.size.height - rect_viewUnderline.size.height) * 0.5;
    rect_viewUnderline.size.width = self.contentWidth - (rect_chkStart.size.width + rect_chkEnd.size.width);
    
    xOffset += rect_viewUnderline.size.width;

    rect_chkEnd.origin.x = xOffset;
    rect_chkEnd.origin.y = (self.frame.size.height - rect_chkEnd.size.height) * 0.5;
    
    self.chkStart.frame = rect_chkStart;
    self.viewUnderLine.frame = rect_viewUnderline;
    self.chkEnd.frame = rect_chkEnd;
}

#pragma mark - UI Method

- (CheckBox *) chkEnd
{
    if (_chkEnd == nil)
    {
        CGRect rect = CGRectMake(self.contentInsets.left, (self.frame.size.height - checkboxSize) * 0.5 , checkboxSize, checkboxSize);
        _chkEnd = [[CheckBox alloc] initWithFrame:rect];
        [_chkEnd updateUI];
        _chkEnd.layer.cornerRadius = checkboxSize * 0.5;
        [self addSubview:_chkEnd];
    }
    return _chkEnd;
}

- (CheckBox *) chkStart
{
    if (_chkStart == nil)
    {
        CGRect rect = CGRectMake(self.contentInsets.left, (self.frame.size.height - checkboxSize) * 0.5 , checkboxSize, checkboxSize);
        _chkStart = [[CheckBox alloc] initWithFrame:rect];
        [_chkStart updateUI];
        _chkStart.layer.cornerRadius = checkboxSize * 0.5;
        [self addSubview:_chkStart];
    }
    return _chkStart;
}

- (BaseView *) viewUnderLine
{
    if (_viewUnderLine == nil)
    {
        _viewUnderLine = [[BaseView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, seperatorHeight_1px)];
        _viewUnderLine.hidden = NO;
        _viewUnderLine.backgroundColor = [Globals shared].themingAssistant.itemCartQtyTitleColor;
        
        [self addSubview:_viewUnderLine];
    }
    return _viewUnderLine;
}

@end
