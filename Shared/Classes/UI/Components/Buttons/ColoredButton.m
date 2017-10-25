

#import "ColoredButton.h"
#import "ThemingAssistant.h"
#import "Globals.h"

const CGFloat coloredButton_DefaultWidth = 100.0f;
const CGFloat coloredButton_DefaultHeight = 50.0f;

@interface ColoredButton()

@property (nonatomic, strong) UIColor *normalStart;
@property (nonatomic, strong) UIColor *normalEnd;
@property (nonatomic, strong) UIColor *highlightedStart;
@property (nonatomic, strong) UIColor *highlightedEnd;

@end

@implementation ColoredButton
{
    UIColor *_normalTitleColor;
    UIColor *_highlightedTitleColor;
}

#pragma mark - basic initialistion methods

+ (ColoredButton *) coloredButtonType:(ColoredButtonType)type frame:(CGRect)frame
{
    CGRect btFrame = frame;
    if (btFrame.size.width == 0)
    {
        btFrame.size.width = coloredButton_DefaultWidth;
    }
    if (btFrame.size.height == 0)
    {
        btFrame.size.height = coloredButton_DefaultHeight;
    }
    
    ColoredButton *button = [ColoredButton buttonWithType:UIButtonTypeCustom];
    button.frame = btFrame;
    button.coloredButtonType = type;
    
    return button;
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

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self != nil)
    {
        [self baseInit];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        [self baseInit];
    }
    return self;
}

- (void) baseInit
{
    //By default a button can highlight itself.
    self.canHighlight = YES;
}

- (void) dealloc
{
}

- (void) setColoredButtonType:(ColoredButtonType)coloredButtonType
{
    switch (coloredButtonType)
    {
        case ColoredButtonType_Red:
            self.bgNormalColor = [Globals shared].themingAssistant.redNorm;
            self.bgHighlightedColor = [Globals shared].themingAssistant.redHigh;
            break;
        case ColoredButtonType_Green:
            self.bgNormalColor = [Globals shared].themingAssistant.greenNorm;
            self.bgHighlightedColor = [Globals shared].themingAssistant.greenHigh;
            break;
        case ColoredButtonType_White:
            self.bgNormalColor = [Globals shared].themingAssistant.whiteNorm;
            self.bgHighlightedColor = [Globals shared].themingAssistant.whiteHigh;
            break;
        case ColoredButtonType_Clear:
            self.bgNormalColor = [UIColor clearColor];
            self.bgHighlightedColor = [UIColor clearColor];
            break;
        case ColoredButtonType_Blue:
            self.bgNormalColor = [Globals shared].themingAssistant.blueNorm;
            self.bgHighlightedColor = [Globals shared].themingAssistant.blueHigh;
            break;
        default:
            break;
    }
}

@end
