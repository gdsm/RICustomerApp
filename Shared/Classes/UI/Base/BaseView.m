//
//  BaseView.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"
#import "Globals.h"

const CGFloat viewContentInset_top = 10;
const CGFloat viewContentInset_left = 20;
const CGFloat viewContentInset_bottom = 10;
const CGFloat viewContentInset_right = 20;

@implementation BaseView

- (id) init
{
    self = [super init];
    if (self != nil)
    {
        [self baseViewInitialisation];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self != nil)
    {
        [self baseViewInitialisation];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        [self baseViewInitialisation];
    }
    return self;
}

- (void) baseViewInitialisation
{
    self.contentInsets = UIEdgeInsetsMake(viewContentInset_top, viewContentInset_left, viewContentInset_bottom, viewContentInset_right);
}

- (CGFloat) contentHeight
{
    CGFloat retVal = self.frame.size.height - (self.contentInsets.top + self.contentInsets.bottom);
    return retVal;
}

- (CGFloat) contentWidth
{
    CGFloat retVal = self.frame.size.width - (self.contentInsets.left + self.contentInsets.right);
    return retVal;
}

- (void) layoutUI
{
    // Child class should implement this to layout the UI on parent ViewController demand
}

- (void) updateUI
{
    // child class override this.
}

- (void) listenNotifications
{
    // child class override this.
}

- (void) removeNotifications
{
    // child class override this.
}

- (UILabel *) getLabel
{
    CGRect rect = CGRectMake(0, self.contentInsets.top, self.contentWidth, self.contentHeight);
    UILabel* retVal = [[UILabel alloc] initWithFrame:rect];
    retVal.adjustsFontSizeToFitWidth = YES;
    retVal.font = [Globals shared].defaultTextFont;
    retVal.textColor = [Globals shared].themingAssistant.defaultTextColor;
    retVal.backgroundColor = [UIColor clearColor];
    retVal.numberOfLines = 0;
    return retVal;
}

@end
