//
//  BaseTableViewController.h
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseViewController.h"
#import "ColoredButton.h"
#import "HeaderInfoView.h"

@interface BaseTableViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

#pragma mark - basic init methods
- (id) initWithStyle:(UITableViewStyle)style;

//MARK: Header Margin
@property (nonatomic) CGFloat nextHeaderMargin;
/// @brief layoutSubviews is used to increase performance. As a low level class try to avoid usage of layout subviews method. Layout will be called from viewWillAppear but the child class which needs to explicitely called this can call this.
- (void) layoutSubviews;

#pragma mark - Header View

@property (nonatomic, strong) HeaderInfoView* headerInfoView;


#pragma mark - tableview properties

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) UIEdgeInsets tableOffset;
@property (nonatomic) CGFloat topContentInset;
@property (nonatomic) CGFloat leftContentInset;
@property (nonatomic) CGFloat bottomContentInset;
@property (nonatomic) CGFloat rightContentInset;

/// @brief This is the floating button with keyboard. This would move up once keyboard appears;
@property (nonatomic, strong) ColoredButton* bottomKeyboardButton;
- (void) onBottomKeyboardButton:(ColoredButton *)sender;


@end
