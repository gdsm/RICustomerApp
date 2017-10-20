

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 * @brief Class description : This class is datasource class for SegmentedListView. Each instance of class is mapped with SegmentedListCell.
 */


extern const CGFloat tabItemSideOffset;  // How much amount the width of tab would increase.
extern const CGFloat tabItemSideInset; // How much amount the content of tabs would shrink.


// Icon position in segment.
typedef NS_ENUM(NSUInteger, TitleIconPosition)
{
    TitleRight_IconLeft,
    TitleBottom_IconTop
};

@interface ButtonItem : NSObject

/**
 * @brief returns initialized instance of class.
 * @param title : Title to be shown in cell.
 * @param titleFont : Font for title.
 * @param icon : Iconic text to be displayed.
 * @param view : Container view (Required in SegmentListViewController)
 * @param isSelected : Item is selected or in non-selected state.
 * @param index : It's and important parameter which keeps track of each item. Parent class/method/module send this parameter. When there is tap on any item this parameter is returned as NSNumber, so that parent class/method/module known where tap has occurred. We cannot rely on indexpath of cells here because some items can be in disable-tapable/disable-nonvisible/disbale-nontapable state.
 */
+ (ButtonItem *) itemWithTitle:(NSString *)title
                     titleFont:(UIFont *)titleFont
                          icon:(NSString *)icon
                 containerView:(id)view
                         index:(NSInteger)index
                    isSelected:(BOOL)isSelected;

/// @brief Static methods to provide default frame for both inside class & outside class.
+ (UIFont *) segmentFont;
+ (UIFont *) iconFont;

@property (nonatomic) BOOL isSelected;
@property (nonatomic) BOOL isDisable;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIFont *iconFont;
/// @brief Alignment if text. Default is Center.
@property (nonatomic) NSTextAlignment alignment;
/// @brief Title to be shown in cell. This property is of NSobject type insteat of NSString because as per refreing MainScreen UI Designs icons are also part of cells, so in that case NSAttributtedString is used.
@property (nonatomic, strong) NSString *title;
/// @brief Icon font code;
@property (nonatomic, strong) NSString *icon;
/// @brief Index of segmented list item. Sequential indexing cannot be used . It may be possible some entries can be unihghlighted need to skip indexing.
@property (nonatomic) NSInteger index;
/// @brief Position of Icon and title
@property (nonatomic) TitleIconPosition titleIconPosition;

///@remarks Below properties are also in NCRLabel.But in Segmented List we are only exposing the SegmentedListItem class to other modules. And also SegmentedListItemView will be part of cell. So it will in-out from memory at runtime. But SegmentedListItem is datasource and will remain in memory.
/// @brief Property to store colors for icon/title in normal states. Default is light text color.
@property (nonatomic, strong) UIColor *normalIconColor, *normalTitleColor;
/// @brief Property to store colors for icon/title in highlighted states. Default is tealColor
@property (nonatomic, strong) UIColor *highlightedIconColor, *highlightedTitleColor;

/// @brief IOType to be used when there is tap on any segment.
@property (nonatomic) NSInteger ioType;

/// @brief Margins by which tab width is extended.
@property (nonatomic) UIEdgeInsets itemOffset;
/// @brief Margins by which tab contents are compressed.
@property (nonatomic) UIEdgeInsets itemInset;
/// @brief This bool property allows to set the size hard code. Without any calculation. In ticket header certain criteria when sizes are need to be hard coded. By setting this hard code value we can avoid some heavy calculations which would result in approx hardsize value. If we do not go with hard size then there are certain calculations needs to be done during layout which can result in waste of execution cycles.
@property (nonatomic) BOOL useHardSize;
/// @brief Hard code size which needs to be set.
@property (nonatomic) CGSize hardSize;

- (CGFloat) itemWidth;
- (CGFloat) itemHeight;

/// @brief Some preffereh height that the layout view can use later on.
@property (nonatomic) CGFloat preferredWidth, prefferedHeight;

@end
