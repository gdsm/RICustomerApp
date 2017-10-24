//
//  ProblemCategoryViewController.m
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ProblemCategoryViewController.h"
#import "ProblemDescriptionViewController.h"
#import "CheckboxSelectionCell.h"
#import "Globals.h"

const CGFloat ProbCatVC_CbTitCell_Height = 60;

@interface ProblemCategoryViewController ()
@property (nonatomic, strong) BaseLabel* lblInfo;
@property (nonatomic, strong) UIBarButtonItem* bbiNext;
@property (nonatomic, strong) NSMutableArray* dataSource;
@end

@implementation ProblemCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI
{
    self.title = @"New Problem Request.";
    self.bgImgv.image = nil;
    self.bottomTabView.hidden = YES;

    CGFloat top = (self.lblInfo.frame.origin.y + self.lblInfo.frame.size.height);
    self.tableOffset = UIEdgeInsetsMake(top, 0, 0, 0);
    
    self.navigationItem.rightBarButtonItem = self.bbiNext;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsZero;
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
        [_dataSource addObject:@"Backup"];
        [_dataSource addObject:@"Bags not sealed"];
        [_dataSource addObject:@"Cassette open"];
        [_dataSource addObject:@"Empty Bags"];
        [_dataSource addObject:@"Equipment Repair"];
        [_dataSource addObject:@"Fire"];
        [_dataSource addObject:@"Load Bags"];
        [_dataSource addObject:@"Loose Ice"];
        [_dataSource addObject:@"MeltDown"];
        [_dataSource addObject:@"Merchandiser full"];
        [_dataSource addObject:@"Needs cases"];
        [_dataSource addObject:@"Not producing"];
        [_dataSource addObject:@"Overweight"];
        [_dataSource addObject:@"Pickup"];
        [_dataSource addObject:@"Replacement parts"];
        [_dataSource addObject:@"Routine maintainence"];
        [_dataSource addObject:@"Under weight"];
        [_dataSource addObject:@"Water leak"];
        [_dataSource addObject:@"Weired Noises"];
        [_dataSource addObject:@"Others"];
    }
    return _dataSource;
}

#pragma mark - Logical Flow Methods

- (void) enterProblemDetail
{
    ProblemDescriptionViewController* view = [[ProblemDescriptionViewController alloc] init];
    [self safePush:view animated:YES];
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = ProbCatVC_CbTitCell_Height;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckboxSelectionCell* cell = [CheckboxSelectionCell dequeueFrom:tableView loadFromNib:@"CheckboxSelectionCell"];
    [cell updateCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblTitle.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - UI Methods

- (BaseLabel *)lblInfo
{
    if (_lblInfo == nil)
    {
        CGFloat top = (self.navigationBarHeight + self.statusBarHeight + topMargin_20px);

        CGRect rect = CGRectMake(leftMargin_20px, top, self.view.frame.size.width - leftMargin_20px, viewHeight_40px);
        _lblInfo = [[BaseLabel alloc] initWithFrame:rect];
        _lblInfo.text = @"Please Select Reason";
        [_lblInfo defaultStyling];
        [self.view addSubview:_lblInfo];
    }
    return _lblInfo;
}

- (UIBarButtonItem *) bbiNext
{
    if (_bbiNext == nil)
    {
        _bbiNext = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(onbbiNext:)];
    }
    return _bbiNext;
}

- (void) onbbiNext:(UIBarButtonItem *)sender
{
    [self enterProblemDetail];
}

@end
