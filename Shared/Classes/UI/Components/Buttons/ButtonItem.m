

#import "ButtonItem.h"
#import "Globals.h"
#import "NSString+Additions.h"
#import "ThemingAssistant.h"

const CGFloat tabItemSideOffset = 10.0f;
const CGFloat tabItemSideInset = 2.0f;


@implementation ButtonItem

#pragma mark - basic initialisation methds

+ (ButtonItem *) itemWithTitle:(NSString *)title
                     titleFont:(UIFont *)titleFont
                          icon:(NSString *)icon
                 containerView:(id)view
                         index:(NSInteger)index
                    isSelected:(BOOL)isSelected
{
    ButtonItem *item = [[ButtonItem alloc] init];

    item.title = title;
    item.font = titleFont;
    item.icon = icon;
    item.isSelected = isSelected;
    item.index = index;

    return item;
}

+ (UIFont *) segmentFont
{
    UIFont *font = [[Globals shared] helveticaNeue:20];
    return font;
}

+ (UIFont *) iconFont
{
    UIFont *font = nil;
    return font;
}

- (id) init
{
    self = [super init];
    if (self != nil)
    {
        [self baseInit];
    }
    return self;
}

- (void) baseInit
{
    _font = nil;
    _icon = nil;
    _title = nil;
    _alignment = NSTextAlignmentCenter;
    
    // Setting default size inset
    self.itemOffset = UIEdgeInsetsMake(0, tabItemSideOffset, 0, tabItemSideOffset);
    self.itemInset = UIEdgeInsetsMake(0, tabItemSideInset, 0, tabItemSideInset);
}

- (void) dealloc
{
    [self baseInit];
}




#pragma mark - string calculations

- (UIFont *) font
{
    if (_font == nil)
    {
        // default font used in segment control.
        _font = [ButtonItem segmentFont];
    }
    return _font;
}

- (UIFont *) iconFont
{
    if (_iconFont == nil)
    {
        // default icon font size.
        _iconFont = [ButtonItem iconFont];
    }
    return _iconFont;
}

- (CGFloat) itemWidth
{
    CGFloat retVal = 0.0;
    
    if (self.useHardSize)
    {
        // Some parent module / context has requested to set hard code values.
        retVal = self.hardSize.width;
        return retVal;
    }

    // By default is title shoulf be there.
    retVal = self.itemOffset.left + [self.title silverSizeWithFont:self.font].width + self.itemOffset.right;
    if (self.icon != nil)
    {
        switch (self.titleIconPosition)
        {
            case TitleRight_IconLeft:
            {
                retVal = [self.icon silverSizeWithFont:self.iconFont].width + 5 + retVal;
            }break;
            case TitleBottom_IconTop:
            {
                retVal = MAX([self.icon silverSizeWithFont:self.iconFont].width , retVal);
            }break;
            default:
                break;
        }
    }
    return retVal;
}

- (CGFloat) itemHeight
{
    CGFloat retVal = 0.0;
    // Dy default is title shoulf be there.
    retVal = [self.title silverSizeWithFont:self.font].height + 5 + 5 + 1.0f;
    if (self.icon != nil)
    {
        switch (self.titleIconPosition)
        {
            case TitleRight_IconLeft:
            {
                retVal = MAX(([self.icon silverSizeWithFont:self.iconFont].height + 5 + 5) , retVal);
            }break;
            case TitleBottom_IconTop:
            {
                retVal = [self.icon silverSizeWithFont:self.iconFont].height + retVal;
            }break;
            default:
                break;
        }
    }
    return retVal;
}

- (UIColor *) normalIconColor
{
    if (_normalIconColor == nil)
    {
        _normalIconColor = [Globals shared].themingAssistant.redNorm;
    }
    return _normalIconColor;
}

- (UIColor *) normalTitleColor
{
    if (_normalTitleColor == nil)
    {
        _normalTitleColor = [Globals shared].themingAssistant.redNorm;
    }
    return _normalTitleColor;
}

- (UIColor *) highlightedIconColor
{
    if (_highlightedIconColor == nil)
    {
        _highlightedIconColor = [Globals shared].themingAssistant.greenHigh;
    }
    return _highlightedIconColor;
}

- (UIColor *) highlightedTitleColor
{
    if (_highlightedTitleColor == nil)
    {
        _highlightedTitleColor = [Globals shared].themingAssistant.greenHigh;
    }
    return _highlightedTitleColor;
}


@end
