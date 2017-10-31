//
//  UserOptionsViewController.m
//  ReddyIce
//
//  Created by Gagan on 25/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "UserOptionsViewController.h"
#import "TitleCell.h"
#import "UserManager.h"

const CGFloat UserOptions_TitleCellHeight = 40;

typedef NS_ENUM(NSUInteger, UserOptionsType) {
    UserOptionsType_MyProfile,
    UserOptionsType_ChangePassword,
    UserOptionsType_Logout
};

@interface UserOptionsViewController ()
@property (nonatomic, strong) NSMutableArray* dataSource;
@end

@implementation UserOptionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI
{
    self.title = [UserManager shared].activeUser.name;
    self.bgImgv.image = nil;
    
    CGFloat top = (self.navigationBarHeight + self.statusBarHeight);
    self.tableOffset = UIEdgeInsetsMake(top, 0, 0, 0);

    self.navigationItem.leftBarButtonItem = self.bbiCancel;
}

- (CGSize) preferredContentSize
{
    return CGSizeMake(250, UserOptions_TitleCellHeight * self.dataSource.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [NSMutableArray new];
        [_dataSource addObject:@"My Profile"];
        [_dataSource addObject:@"Change Password"];
        [_dataSource addObject:@"Logout"];
    }
    return _dataSource;
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (UserOptions_TitleCellHeight);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCell* cell = [TitleCell dequeueFrom:tableView loadFromNib:@"TitleCell"];
    [cell updateCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lblTitle.text = [self.dataSource objectAtIndex:indexPath.row];
    cell.lblTitle.numberOfLines = 1;
    cell.lblTitle.adjustsFontSizeToFitWidth = YES;
    cell.btnInfo.hidden = YES;
    cell.viewLeftLine.hidden = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row == UserOptionsType_MyProfile) && (self.callbackMyProfile != nil))
    {
        self.callbackMyProfile();
    }
    else if ((indexPath.row == UserOptionsType_ChangePassword) && (self.callbackChangePassword != nil))
    {
        self.callbackChangePassword();
    }
    else if ((indexPath.row == UserOptionsType_Logout) && (self.callbackLogout != nil))
    {
        self.callbackLogout();
    }
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [Globals shared].themingAssistant.whiteHigh;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

@end
