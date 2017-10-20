

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
            break;
        case ColoredButtonType_Green:
            self.bgNormalColor = [Globals shared].themingAssistant.greenBtnNormBG;
            break;
        case ColoredButtonType_White:
            self.bgNormalColor = [Globals shared].themingAssistant.coloredButtonWhite;
            break;
        case ColoredButtonType_Clear:
            self.bgNormalColor = [UIColor clearColor];
            break;
        case ColoredButtonType_Blue:
            self.bgNormalColor = [Globals shared].themingAssistant.blueNorm;
            break;
        default:
            break;
    }
}

@end
