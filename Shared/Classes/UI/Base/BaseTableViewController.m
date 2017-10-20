//
//  BaseTableViewController.m
//  ReddyIce
//
//  Created by Gagan on 10/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableViewCell.h"
#import "Utilities.h"
#import "Globals.h"


const CGFloat BaseTVC_keyboardButtonCorner = 5;
const CGFloat BaseTVC_keyboardButtonHeight = 50;
const CGFloat BaseTVC_keyboardButtonLeftMargin = 10;
const CGFloat BaseTVC_keyboardButtonRightMargin = 10;
const CGFloat BaseTVC_keyboardButtonBottomMargin = 10;


@interface BaseTableViewController ()
@end


@implementation BaseTableViewController

- (id) initWithStyle:(UITableViewStyle)style
{
    if (self = [super init])
    {
        [self initialise];
    }
    return self;
}

- (void) initialise
{
    _tableView = nil;
    self.nextHeaderMargin = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.topContentInset = (self.navigationBarHeight + self.statusBarHeight);
//    baseTVC_keyboardButtonBottomMargin = BaseTVC_keyboardButtonBottomMargin;
    self.topContentInset = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Header View

- (HeaderInfoView *)headerInfoView
{
    if (_headerInfoView == nil)
    {
        _headerInfoView = [[HeaderInfoView alloc] init];
        _headerInfoView.hidden = YES;
        _headerInfoView.backgroundColor = [UIColor clearColor];

        [self.view insertSubview:_headerInfoView aboveSubview:self.tableView];
    }
    return _headerInfoView;
}

#pragma mark - TableView Methods

- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [Globals shared].themingAssistant.defaultTableViewBGColor;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view insertSubview:_tableView aboveSubview:self.bgImgv];
    }
    return _tableView;
}

- (void) setTopContentInset:(CGFloat)value
{
    UIEdgeInsets inset = self.tableView.contentInset;
    inset.top = value;
    self.tableView.contentInset = inset;
}

- (void) setBottomContentInset:(CGFloat)value
{
    UIEdgeInsets inset = self.tableView.contentInset;
    inset.bottom = value;
    self.tableView.contentInset = inset;
}

- (void) setLeftContentInset:(CGFloat)value
{
    UIEdgeInsets inset = self.tableView.contentInset;
    inset.left = value;
    self.tableView.contentInset = inset;
}

- (void) setRightContentInset:(CGFloat)value
{
    UIEdgeInsets inset = self.tableView.contentInset;
    inset.right = value;
    self.tableView.contentInset = inset;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CPCell"];
    return cell;
}

- (void) tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    // since table view has custom cell layouting. So needs to call cell highlighted/unhighlight explicitely.
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.highlighted = YES;
}

- (void) tableView:(UITableView *)tableView didUnHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.highlighted = NO;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
}



#pragma mark - Keyboard

- (ColoredButton *)bottomKeyboardButton
{
    if (_bottomKeyboardButton == nil)
    {
        CGRect frame = CGRectMake(0, 0, 200, BaseTVC_keyboardButtonHeight);
        _bottomKeyboardButton = [ColoredButton coloredButtonType:ColoredButtonType_Green frame:frame];
        _bottomKeyboardButton.cornerRadius = BaseTVC_keyboardButtonCorner;
        _bottomKeyboardButton.hidden = YES;
        [_bottomKeyboardButton addTarget:self action:@selector(onBottomKeyboardButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_bottomKeyboardButton];
    }
    return _bottomKeyboardButton;
}

- (void) onBottomKeyboardButton:(ColoredButton *)sender
{
    
}

- (void) keyboardDidShow:(nullable NSNotification *)notification
{
    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if ((_bottomKeyboardButton != nil) && (_bottomKeyboardButton.hidden == NO))
    {
        CGFloat btnHeight = CGRectGetHeight(_bottomKeyboardButton.frame);
        self.bottomContentInset = btnHeight + BaseTVC_keyboardButtonBottomMargin;
        
        UIEdgeInsets offset = self.tableOffset;
        offset.bottom = keyBoardFrame.size.height;
        self.tableOffset = offset;
        
        [self layoutSubviews];
    }
    else if (self.bottomTabView.hidden == NO)
    {
        UIEdgeInsets offset = self.tableOffset;
        offset.bottom = keyBoardFrame.size.height;
        self.tableOffset = offset;

        [self layoutSubviews];
    }
}

- (void) keyboardDidHide:(nullable NSNotification *)notification
{
//    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if ((_bottomKeyboardButton != nil) && (_bottomKeyboardButton.hidden == NO))
    {
        UIEdgeInsets offset = self.tableOffset;
        offset.bottom = 0;
        self.tableOffset = offset;

        [self layoutSubviews];
    }
    else if (self.bottomTabView.hidden == NO)
    {
        UIEdgeInsets offset = self.tableOffset;
        offset.bottom = 0;
        self.tableOffset = offset;

        [self layoutSubviews];
    }
}


#pragma mark - layouting methods

- (void) layoutSubviews
{
    CGFloat offsetY = 0.f;
    
    offsetY += self.nextHeaderMargin;
    
    if ((_headerInfoView != nil) && (_headerInfoView.hidden == NO))
    {
        CGRect rect_headerInfoView = _headerInfoView.frame;
        
        rect_headerInfoView.origin.x = 0;
        rect_headerInfoView.origin.y = (self.navigationBarHeight + self.statusBarHeight);
        rect_headerInfoView.size.width = CGRectGetWidth(self.view.frame);
        rect_headerInfoView.size.height = _headerInfoView.prefferedHeight;
        
        _headerInfoView.frame = rect_headerInfoView;
        [_headerInfoView layoutUI];

        offsetY += (rect_headerInfoView.size.height + rect_headerInfoView.origin.y);
    }

    if (self.tableView.hidden == NO)
    {
        CGRect rect_tableView = self.tableView.frame;
        rect_tableView.origin.x = self.tableOffset.left;
        rect_tableView.origin.y = offsetY + self.tableOffset.top;
        rect_tableView.size.width = CGRectGetWidth(self.view.frame) - (self.tableOffset.left + self.tableOffset.right);
        rect_tableView.size.height = CGRectGetHeight(self.view.frame) - (offsetY + self.tableOffset.bottom + self.tableOffset.top);

        self.tableView.frame = rect_tableView;
        
        offsetY += rect_tableView.size.height;
    }
    
    if ((_bottomKeyboardButton != nil) && (_bottomKeyboardButton.hidden == NO))
    {
        CGRect rect_keybrdBtmBtn = _bottomKeyboardButton.frame;
        
        rect_keybrdBtmBtn.origin.x = BaseTVC_keyboardButtonLeftMargin;
        rect_keybrdBtmBtn.origin.y = offsetY;
        rect_keybrdBtmBtn.size.width = CGRectGetWidth(self.view.frame) - (BaseTVC_keyboardButtonLeftMargin + BaseTVC_keyboardButtonRightMargin);
        
        _bottomKeyboardButton.frame = rect_keybrdBtmBtn;
    }
}

@end
