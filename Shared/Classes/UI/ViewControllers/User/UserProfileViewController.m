//
//  UserProfileViewController.m
//  ReddyIce
//
//  Created by Gagan on 25/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "UserProfileViewController.h"
#import "RegistrationConfirmationViewController.h"
#import "IconTextFieldCell.h"
#import "ReportLineCell.h"
#import "EditFieldCell.h"
#import "ToggleSettingCell.h"
#import "CheckboxSelectionCell.h"


const CGFloat UserInfoRow_Name_Height = 60;
const CGFloat UserInfoRow_EmailId_Height = 60;
const CGFloat UserInfoRow_EmailInfo_Height = 40;
const CGFloat UserInfoRow_Phone_Height = 60;
const CGFloat UserProfile_StoreInfo_Height = 40;

const CGFloat StoreInfoRow_Title_Height = 40;
const CGFloat StoreInfoRow_StoreName_Height = 60;
const CGFloat StoreInfoRow_StoreId_Height = 60;
const CGFloat StoreInfoRow_StreetAddr_Height = 60;
const CGFloat StoreInfoRow_CityStateAddr_Height = 60;
const CGFloat StoreInfoRow_ZipCode_Height = 60;

const CGFloat NotificationRow_Title_Height = 40;
const CGFloat NotificationRow_Email_Height = 60;
const CGFloat NotificationRow_TextMsg_Height = 60;

const CGFloat DisclaimerRow_Aggreement_Height = 60;


typedef NS_ENUM(NSUInteger, ProfileSections) {
    ProfileSection_UserInfo,
    ProfileSection_StoreInfo,
    ProfileSection_Notification,
    ProfileSection_Disclaimer,
    ProfileSection_MAXCOUNT
};

typedef NS_ENUM(NSUInteger, UserInfoRows) {
    UserInfoRow_Name,
    UserInfoRow_EmailId,
    UserInfoRow_EmailInfo,
    UserInfoRow_Phone,
    UserInfoRow_MAXCOUNT
};

typedef NS_ENUM(NSUInteger, StoreInfoRows) {
    StoreInfoRow_Title,
    StoreInfoRow_StoreName,
    StoreInfoRow_StoreId,
    StoreInfoRow_StreetAddr,
    StoreInfoRow_CityStateAddr,
    StoreInfoRow_ZipCode,
    StoreInfoRow_MAXCOUNT
};

typedef NS_ENUM(NSUInteger, NotificationRows) {
    NotificationRow_Title,
    NotificationRow_Email,
    NotificationRow_TextMsg,
    NotificationRow_MAXCOUNT
};

typedef NS_ENUM(NSUInteger, DisclaimerRows) {
    DisclaimerRow_Aggreement,
    DisclaimerRow_MAXCOUNT
};


@interface UserProfileViewController ()
@property (nonatomic, strong) UIBarButtonItem* bbiRegister;
@end


@implementation UserProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI
{
    if (_isNewUser)
    {
        self.title = @"New User";
    }
    else
    {
        self.title = @"User Profile";
    }
    self.bgImgv.image = nil;
    
    CGFloat top = (self.navigationBarHeight + self.statusBarHeight + topMargin_20px);
    self.tableOffset = UIEdgeInsetsMake(top, 0, 0, 0);
    
    self.allowKeyboardNotifications = YES;
    self.navigationItem.rightBarButtonItem = self.bbiRegister;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Logical Flow Methods

- (void) registerUser
{
    RegistrationConfirmationViewController* view = [[RegistrationConfirmationViewController alloc] initWithNibName:@"RegistrationConfirmationViewController" bundle:nil];
    [self safePush:view animated:YES];
}


#pragma mark - TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ProfileSection_MAXCOUNT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger retVal = 0;
    if (section == ProfileSection_UserInfo){
        retVal = UserInfoRow_MAXCOUNT;
    }
    else if (section == ProfileSection_StoreInfo){
        retVal = StoreInfoRow_MAXCOUNT;
    }
    else if (section == ProfileSection_Notification){
        retVal = NotificationRow_MAXCOUNT;
    }
    else if (section == ProfileSection_Disclaimer){
        retVal = DisclaimerRow_MAXCOUNT;
    }
    return retVal;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat retVal = 1;
    if (indexPath.section == ProfileSection_UserInfo){
        if (indexPath.row == UserInfoRow_Name){
            retVal = UserInfoRow_Name_Height;
        }
        else if (indexPath.row == UserInfoRow_EmailId){
            retVal = UserInfoRow_EmailId_Height;
        }
        else if (indexPath.row == UserInfoRow_EmailInfo){
            retVal = UserInfoRow_EmailInfo_Height;
        }
        else if (indexPath.row == UserInfoRow_Phone){
            retVal = UserInfoRow_Phone_Height;
        }
    }
    else if (indexPath.section == ProfileSection_StoreInfo){
        if (indexPath.row == StoreInfoRow_Title){
            retVal = StoreInfoRow_Title_Height;
        }
        else if (indexPath.row == StoreInfoRow_StoreId){
            retVal = StoreInfoRow_StoreId_Height;
        }
        else if (indexPath.row == StoreInfoRow_ZipCode){
            retVal = StoreInfoRow_ZipCode_Height;
        }
        else if (indexPath.row == StoreInfoRow_StreetAddr){
            retVal = StoreInfoRow_StreetAddr_Height;
        }
        else if (indexPath.row == StoreInfoRow_CityStateAddr){
            retVal = StoreInfoRow_CityStateAddr_Height;
        }
        else if (indexPath.row == StoreInfoRow_StoreName){
            retVal = StoreInfoRow_StoreName_Height;
        }
    }
    else if (indexPath.section == ProfileSection_Notification){
        if (indexPath.row == NotificationRow_Title){
            retVal = NotificationRow_Title_Height;
        }
        else if (indexPath.row == NotificationRow_Email){
            retVal = NotificationRow_Email_Height;
        }
        else if (indexPath.row == NotificationRow_TextMsg){
            retVal = NotificationRow_TextMsg_Height;
        }
    }
    else if (indexPath.section == ProfileSection_Disclaimer){
        if (indexPath.row == DisclaimerRow_Aggreement){
            retVal = DisclaimerRow_Aggreement_Height;
        }
    }
    return retVal;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return seperatorHeight_1px;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *) userTableView:(UITableView *)tableView
              cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row == UserInfoRow_Name) || (indexPath.row == UserInfoRow_Phone) || (indexPath.row == UserInfoRow_EmailId))
    {
        IconTextFieldCell *cell = [IconTextFieldCell dequeueFrom:tableView loadFromNib:@"IconTextFieldCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [Globals shared].themingAssistant.blueNorm;
        cell.indexPath = indexPath;
        cell.returnKeyType = UIReturnKeyNext;
        cell.iconTextField.viewUnderLine.hidden = NO;
        
        if (indexPath.row == UserInfoRow_Name){
            cell.iconTextField.iconCode = [IconFontCodes shared].user;
            cell.iconTextField.textField.placeholder = @"Enter your full Name";
        }
        else if (indexPath.row == UserInfoRow_Phone){
            cell.iconTextField.iconCode = [IconFontCodes shared].call;
            cell.iconTextField.textField.placeholder = @"Enter your phone number";
        }
        else if (indexPath.row == UserInfoRow_EmailId){
            cell.iconTextField.iconCode = [IconFontCodes shared].message;
            cell.iconTextField.textField.placeholder = @"Enter your email Id";
        }
        
        UIEdgeInsets inset = cell.iconTextField.contentInsets;
        inset.left = leftMargin_15px;
        inset.right = rightMargin_15px; // there is alread 5 px margin there
        cell.iconTextField.contentInsets = inset;
        

        [cell updateCell];
        return cell;
    }
    else if (indexPath.row == UserInfoRow_EmailInfo)
    {
        ReportLineCell* cell = [ReportLineCell dequeueFrom:tableView loadFromNib:@"ReportLineCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [Globals shared].themingAssistant.blueNorm;

        CGFloat div[] = {0.f};
        
        [cell initWithDividers:div count:1];
        [cell.reportLineView setTitles:@"All email Notifications will be sent to this email Id", nil];
        [cell.reportLineView labelAtIndex:0].textAlignment = NSTextAlignmentRight;
        [cell.reportLineView labelAtIndex:0].font = [Globals shared].defaultInfoFont;
        [cell.reportLineView labelAtIndex:0].textColor = [Globals shared].themingAssistant.defaultTextColor;
        
        [cell updateCell];
        
        return cell;
    }

    BaseTableViewCell* cell = [BaseTableViewCell blankCell];
    return cell;
}

- (UITableViewCell *) storeTableView:(UITableView *)tableView
               cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == StoreInfoRow_Title)
    {
        ReportLineCell* cell = [ReportLineCell dequeueFrom:tableView loadFromNib:@"ReportLineCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat div[] = {0.f};
        
        [cell initWithDividers:div count:1];
        [cell.reportLineView setTitles:@"Store information", nil];
        [cell.reportLineView labelAtIndex:0].textAlignment = NSTextAlignmentLeft;
        [cell.reportLineView labelAtIndex:0].font = [Globals shared].defaultInfoFont;
        [cell.reportLineView labelAtIndex:0].textColor = [Globals shared].themingAssistant.defaultTextColor;
        
        [cell updateCell];
        
        return cell;
    }
    else
    {
        EditFieldCell *cell = [EditFieldCell dequeueFrom:tableView loadFromNib:@"EditFieldCell"];
        cell.indexPath = indexPath;
        
        cell.returnKeyType = UIReturnKeyNext;
        
        if (indexPath.row == StoreInfoRow_StoreName)
        {
            cell.editField.editFieldStyle = EditFieldStyle_Hint_H_TextField;
            cell.editField.hintText = @"Store Name";
        }
        else if (indexPath.row == StoreInfoRow_StoreId)
        {
            cell.editField.editFieldStyle = EditFieldStyle_Hint_H_TextField;
            cell.editField.hintText = @"Store Id";
        }
        else if (indexPath.row == StoreInfoRow_StreetAddr)
        {
            cell.editField.editFieldStyle = EditFieldStyle_Hint_H_TextField;
            cell.editField.hintText = @"Address";
            cell.editField.placeHolderText = @"Address";
        }
        else if (indexPath.row == StoreInfoRow_CityStateAddr)
        {
            cell.editField.editFieldStyle = EditFieldStyle_Split;
            cell.editField.placeHolderText = @"City";
            cell.editField.placeHolderText2 = @"State";
            cell.editField.lblHint.hidden = YES;
        }
        else if (indexPath.row == StoreInfoRow_ZipCode)
        {
            cell.editField.editFieldStyle = EditFieldStyle_Split;
            cell.editField.placeHolderText = @"Zipcode";
            cell.editField.lblHint.hidden = YES;
            cell.editField.hideField2 = YES;
        }
        cell.editField.lblHint.textAlignment = NSTextAlignmentRight;

        [cell updateCell];
        return cell;
    }
    return nil;
}

- (UITableViewCell *) notificationTableView:(UITableView *)tableView
                      cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == NotificationRow_Title)
    {
        ReportLineCell* cell = [ReportLineCell dequeueFrom:tableView loadFromNib:@"ReportLineCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat div[] = {0.f};
        
        [cell initWithDividers:div count:1];
        [cell.reportLineView setTitles:@"Notification prefrences", nil];
        [cell.reportLineView labelAtIndex:0].textAlignment = NSTextAlignmentLeft;
        [cell.reportLineView labelAtIndex:0].font = [Globals shared].defaultInfoFont;
        [cell.reportLineView labelAtIndex:0].textColor = [Globals shared].themingAssistant.defaultTextColor;
        
        [cell updateCell];
        
        return cell;
    }
    else
    {
        ToggleSettingCell *cell = [ToggleSettingCell dequeueFrom:tableView loadFromNib:@"ToggleSettingCell"];
        cell.indexPath = indexPath;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.row == NotificationRow_Email)
        {
            cell.toggleSettingView.lblDescription.text = @"Receive email notifications";
            cell.toggleSettingView.onValueChanged = ^(NSDecimalNumber *value) {
                // collect response here
            };
        }
        else if (indexPath.row == NotificationRow_TextMsg)
        {
            cell.toggleSettingView.lblDescription.text = @"Receive Text Messages.\rYou may incur charges form your cellular provider";
            cell.toggleSettingView.onValueChanged = ^(NSDecimalNumber *value) {
                // collect response here
            };
        }
        
        [cell updateCell];
        return cell;
    }
    return nil;
}

- (UITableViewCell *) disclaimerTableView:(UITableView *)tableView
                    cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckboxSelectionCell* cell = [CheckboxSelectionCell dequeueFrom:tableView loadFromNib:@"CheckboxSelectionCell"];
    [cell updateCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblTitle.text = @"I agree to the terms and conditions";
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    if (indexPath.section == ProfileSection_UserInfo)
    {
        cell = [self userTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == ProfileSection_StoreInfo)
    {
        cell = [self storeTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == ProfileSection_Notification)
    {
        cell = [self notificationTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else if (indexPath.section == ProfileSection_Disclaimer)
    {
        cell = [self disclaimerTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Layout Methods

#pragma mark - UI Methods

- (UIBarButtonItem *) bbiRegister
{
    if (_bbiRegister == nil)
    {
        _bbiRegister = [[UIBarButtonItem alloc] initWithTitle:@"Register" style:UIBarButtonItemStylePlain target:self action:@selector(onbbiRegister:)];
    }
    return _bbiRegister;
}

- (void) onbbiRegister:(UIBarButtonItem *)sender
{
    [self registerUser];
}

@end
