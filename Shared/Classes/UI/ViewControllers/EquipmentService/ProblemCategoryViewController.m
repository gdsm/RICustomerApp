//
//  ProblemCategoryViewController.m
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ProblemCategoryViewController.h"
#import "ProblemDescriptionViewController.h"
#import "ReportLineCell.h"
#import "Globals.h"


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
    self.bottomTabView.hidden = NO;

    CGFloat top = (self.lblInfo.frame.origin.y + self.lblInfo.frame.size.height + topMargin_20px);
    self.tableOffset = UIEdgeInsetsMake(top, 0, 0, 0);
    
//    self.navigationItem.rightBarButtonItem = self.bbiNext;
    self.navigationItem.hidesBackButton = YES;

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
    CGFloat height = cellHeight_60px;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReportLineCell* cell = [ReportLineCell dequeueFrom:tableView loadFromNib:@"ReportLineCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat div[] = {0.999f};
    
    [cell initWithDividers:div count:2];
    [cell.reportLineView setTitles:[self.dataSource objectAtIndex:indexPath.row], nil];
    [[cell.reportLineView labelAtIndex:0] defaultStyling];
    [cell.reportLineView labelAtIndex:0].textAlignment = NSTextAlignmentLeft;
    
    [cell updateCell];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self enterProblemDetail];
}

#pragma mark - UI Methods

- (BaseLabel *)lblInfo
{
    if (_lblInfo == nil)
    {
        CGFloat top = (self.navigationBarHeight + self.statusBarHeight + topMargin_20px);

        CGRect rect = CGRectMake(leftMargin_20px, top, self.view.frame.size.width - (leftMargin_20px + rightMargin_20px), viewHeight_40px);
        _lblInfo = [[BaseLabel alloc] initWithFrame:rect];
        [_lblInfo defaultStyling];
        _lblInfo.font = [Globals shared].boldTextFont;
        _lblInfo.text = @"Please Select Reason";
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
