

#import "BaseButton.h"

/**
 * @brief This class is designed as per v4 scheme. Class will provide colored buttons. This is generic class provide styling to buttons.
 * NCRButton class will provide basic layouting like background image, corner radius But ColoredButton will provide color schem for buttons.
 */


typedef NS_ENUM(NSUInteger, ColoredButtonType)
{
    ColoredButtonType_Red,
    ColoredButtonType_Green,
    ColoredButtonType_White,
    ColoredButtonType_Clear,
    ColoredButtonType_Blue
};

@interface ColoredButton : BaseButton

/**
 * @brief Method return initialized instance of colored button. Button type will decide the color scheme of buttons.
 */
+ (ColoredButton *) coloredButtonType:(ColoredButtonType)type frame:(CGRect)frame;

@property (nonatomic) ColoredButtonType coloredButtonType;
@property (nonatomic) UIEdgeInsets contentOffset;

@end
