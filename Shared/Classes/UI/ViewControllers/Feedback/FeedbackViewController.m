//
//  FeedbackViewController.m
//  ReddyIce
//
//  Created by Ameet on 26/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedbackQuestionareViewController.h"
#import "CategoryDetailCell.h"

const CGFloat FeedbackVC_Header_Height = 100;

@interface FeedbackViewController ()
@property (nonatomic, strong) CategoryDetailView* headerView;
@property (nonatomic, strong) NSMutableArray* dataSource;
@end

@implementation FeedbackViewController


#pragma mark - View Life cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.bottomTabView.hidden = NO;
}

- (void)setupUI
{
    self.title = @"Feedback";
    self.bgImgv.image = nil;
    self.bottomTabView.hidden = NO;

    CGFloat top = (self.headerView.frame.size.height + self.headerView.frame.origin.y);
    self.tableOffset = UIEdgeInsetsMake(top, 0, 0, 0);
    
    [self.view addSubview:self.headerView];
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [NSMutableArray new];
        [_dataSource addObject:@"Delivery Question/Feedback"];
        [_dataSource addObject:@"Driver"];
        [_dataSource addObject:@"Management Team"];
        [_dataSource addObject:@"Plant"];
        [_dataSource addObject:@"Retail Merchandiser"];
        [_dataSource addObject:@"Service Technician"];
    }
    return _dataSource;
}


#pragma mark - Logical Flow Methods

- (void) showFeedbackQuestionare
{
    FeedbackQuestionareViewController* view = [[FeedbackQuestionareViewController alloc] init];
    [self safePush:view animated:YES];
}

#pragma mark - TableView Methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return viewHeight_60px;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryDetailCell* cell = [CategoryDetailCell dequeueFrom:tableView loadFromNib:@"CategoryDetailCell"];
    [cell updateCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.categoryDetailView.lblCategory iconStyling];
    cell.categoryDetailView.lblDetail.textAlignment = NSTextAlignmentLeft;
    cell.categoryDetailView.dividerRatio = 0.2;
    cell.category = [IconFontCodes shared].user;
    cell.detail = [self.dataSource objectAtIndex:indexPath.row];
    cell.categoryDetailView.viewUnderLine.hidden = NO;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showFeedbackQuestionare];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - Layout Methods

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.headerView layoutUI];
}

#pragma mark - UI Methods

- (CategoryDetailView *)headerView
{
    if (_headerView == nil)
    {
        CGRect rect = CGRectZero;
        CGFloat top = self.navigationBarHeight + self.statusBarHeight + topMargin_20px;
        rect.origin.y = top;
        rect.size.width = self.view.frame.size.width;
        rect.size.height = FeedbackVC_Header_Height;
        
        _headerView = [[CategoryDetailView alloc] initWithFrame:rect];
        _headerView.categoryDetailStyle = CategoryDetailStyle_Vertical;
        [_headerView updateUI];
        [_headerView.lblDetail defaultStyling];
        _headerView.lblDetail.textAlignment = NSTextAlignmentCenter;
        _headerView.imgCategory = @"Feedback.png";
        _headerView.detail = @"Placeholder for contextual help text";
        _headerView.dividerRatio = 0.6;
        
        _headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    }
    return _headerView;
}

@end
