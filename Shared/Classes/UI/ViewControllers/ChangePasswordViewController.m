//
//  ChangePasswordViewController.m
//  ReddyIce
//
//  Created by Gagan on 11/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ChangePasswordModelObject.h"
#import "PasswordFieldCell.h"

const CGFloat changePasswordVC_cellHeight = 90;
const CGFloat changePasswordVC_infoTopMargin = 20;
const CGFloat changePasswordVC_infoLeftMargin = 40;
const CGFloat changePasswordVC_infoRightMargin = 40;

@interface ChangePasswordViewController () <TextEntryDelegate>
@property (nonatomic, strong) ChangePasswordModelObject* changePasswordModel;
@property (nonatomic, strong) NSMutableDictionary* valueSet;
@property (strong, nonatomic) UIBarButtonItem* bbiSave;
@end


@implementation ChangePasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.allowKeyboardNotifications = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.allowKeyboardNotifications = NO;
}

- (void) setupUI
{
//    __weak ChangePasswordViewController* weakSelf = self;
    self.title = @"Change Password";
    
//    self.bottomKeyboardButton.hidden = NO;
//    [self.bottomKeyboardButton setTitle:@"Save" forState:UIControlStateNormal];
    CGFloat top = (self.navigationBarHeight + 10);
    self.tableOffset = UIEdgeInsetsMake(top, 0, 0, 0);

    self.navigationItem.rightBarButtonItem = self.bbiSave;
    self.navigationItem.backBarButtonItem.title = nil;
    
    self.headerInfoView.hidden = NO;
    self.headerInfoView.lblInfo.text = @"Change your password before logging on the first time. please update your password";
    
    self.tableView.scrollEnabled = NO;
}

- (UIBarButtonItem *) bbiSave
{
    if (_bbiSave == nil)
    {
        _bbiSave = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(onbbiSave:)];
    }
    return _bbiSave;
}

- (void) onbbiSave:(UIBarButtonItem *)sender
{
    [self savePassword];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Logical Flow

- (void) savePassword
{
    [[Utilities findFirstResonderIn:self.tableView] resignFirstResponder];
    [self.changePasswordModel updateWithDictionary:self.valueSet];
    [self changePasswordModel];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (ChangePasswordModelObject *)changePasswordModel
{
    if (_changePasswordModel == nil)
    {
        _changePasswordModel = [ChangePasswordModelObject new];
    }
    return _changePasswordModel;
}

- (NSMutableDictionary *)valueSet
{
    if (_valueSet == nil)
    {
        _valueSet = [NSMutableDictionary dictionaryWithDictionary:self.changePasswordModel.nonnullDictionary];
    }
    return _valueSet;
}

- (void) onBottomKeyboardButton:(ColoredButton *)sender
{
    [self savePassword];
}



#pragma mark - TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.changePasswordModel.allKeys.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return changePasswordVC_cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PasswordFieldCell *cell = [PasswordFieldCell dequeueFrom:tableView loadFromNib:@"PasswordFieldCell"];
    cell.indexPath = indexPath;
    
    NSString* placeHolderText = nil;
    NSString* key = [self.changePasswordModel.allKeys objectAtIndex:indexPath.row];
    NSString* hintText = [self.changePasswordModel displayValueForKey:key];
    
    cell.passwordField.hintText = hintText;
    cell.passwordField.placeHolderText = placeHolderText;
    [cell updateWithDelegate:self dictionary:self.valueSet key:key keyboardType:UIKeyboardTypeDefault];
    cell.returnKeyType = UIReturnKeyNext;
    
    if (indexPath.row == (self.changePasswordModel.allKeys.count-1))
    {
        cell.returnKeyType = UIReturnKeyDone;
    }
    [cell updateCell];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PasswordFieldCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.passwordField.textField becomeFirstResponder];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


#pragma mark - TextEntry Delegate

- (void) textFieldShouldReturn:(UITextField *)textField forIndexPath:(NSIndexPath *)indexPath inCell:(id)cell
{
    if (indexPath.row < (self.changePasswordModel.allKeys.count-1))
    {
        PasswordFieldCell* nextCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]];
        [nextCell.passwordField.textField becomeFirstResponder];
    }
    else
    {
        PasswordFieldCell* pwdCell = (PasswordFieldCell *)cell;
        [self.changePasswordModel updateWithDictionary:pwdCell.dictionary];
        [self onBottomKeyboardButton:nil];
    }
}

- (void) textFieldShouldEndEditing:(UITextField *)textField forIndexPath:(NSIndexPath *)indexPath inCell:(id)cell
{
    PasswordFieldCell* pwdCell = (PasswordFieldCell *)cell;
    [self.changePasswordModel updateWithDictionary:pwdCell.dictionary];
}


#pragma mark - Layout Methods

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self layoutSubviews];
}

@end
