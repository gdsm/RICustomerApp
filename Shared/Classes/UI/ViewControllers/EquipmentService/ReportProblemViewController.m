//
//  ReportProblemViewController.m
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ReportProblemViewController.h"
#import "CreateProblemViewController.h"
#import "CreateServiceRequestView.h"
#import "ReportLineCell.h"
#import "HistoryCell.h"

const CGFloat ReportProbVC_viewServiceRequest_Height = 150;
const CGFloat ReportProbVC_HeaderCell_Height = 40.0;
const CGFloat ReportProbVC_HistoryCell_Height = 80.0;

@interface ReportProblemViewController ()
@property (nonatomic, strong) UIBarButtonItem* bbiSearch;
@property (nonatomic, strong) CreateServiceRequestView* viewCreateServiceRequest;
@end

@implementation ReportProblemViewController


#pragma mark - View Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setupUI
{
    self.title = @"Report a problem";
    self.bgImgv.image = nil;
    self.bottomTabView.hidden = NO;
    
    CGFloat top = (self.navigationBarHeight + self.statusBarHeight + self.viewCreateServiceRequest.frame.size.height);
    CGFloat bottom = self.bottomTabView.frame.size.height;
    self.tableOffset = UIEdgeInsetsMake(top, 0, bottom, 0);

    self.navigationItem.rightBarButtonItem = self.bbiSearch;
    
    [self.view addSubview:self.viewCreateServiceRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Logical Methods

- (void) searchHistory
{
    
}

- (void) createServiceRequest
{
    CreateProblemViewController* view = [[CreateProblemViewController alloc] initWithNibName:@"CreateProblemViewController" bundle:nil];
    [self safePush:view animated:YES];
}


#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 1;
    if (indexPath.row == 0)
    {
        height = ReportProbVC_HeaderCell_Height;
    }
    else
    {
        height = ReportProbVC_HistoryCell_Height;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        ReportLineCell* cell = [ReportLineCell dequeueFrom:tableView loadFromNib:@"ReportLineCell"];
        [cell updateCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat div[] = {0.3f, 0.7f};
        [cell initWithDividers:div count:3];
        [cell.reportLineView setTitles:@"Equipment.", @"Reason", @"Status", nil];
        [cell.reportLineView labelAtIndex:0].textAlignment = NSTextAlignmentLeft;
        [cell.reportLineView labelAtIndex:1].textAlignment = NSTextAlignmentCenter;
        [cell.reportLineView labelAtIndex:2].textAlignment = NSTextAlignmentRight;
        
        return cell;
    }
    else
    {
        HistoryCell* cell = [HistoryCell dequeueFrom:tableView loadFromNib:@"HistoryCell"];
        [cell updateCell];
        cell.historyView.lblStatus.text = @"Queued";
        cell.historyView.lblTotalAmount.text = @"Equipment Repair";
        cell.historyView.lblStartTime.text = @"";
        cell.historyView.lblEndTime.text = @"17 Oct 2017";
        cell.historyView.lblOrderNo.text = @"In line freezer";
        cell.historyView.historyType = HistoryType_RequestHistory;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - UI Methods

- (CreateServiceRequestView *) viewCreateServiceRequest
{
    if (_viewCreateServiceRequest == nil)
    {
        __weak ReportProblemViewController* weakSelf = self;
        CGFloat top = (self.navigationBarHeight + self.statusBarHeight);

        CGRect rect = CGRectMake(0, top, self.view.frame.size.width, ReportProbVC_viewServiceRequest_Height);
        _viewCreateServiceRequest = [[CreateServiceRequestView alloc] initWithFrame:rect];
        _viewCreateServiceRequest.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        _viewCreateServiceRequest.backgroundColor = [Globals shared].themingAssistant.blueNorm;
        [_viewCreateServiceRequest updateUI];
        _viewCreateServiceRequest.onCreateRequest = ^(id sender) {
            [weakSelf createServiceRequest];
        };
    }
    return _viewCreateServiceRequest;
}

- (UIBarButtonItem *)bbiSearch
{
    if (_bbiSearch == nil)
    {
        _bbiSearch = [[UIBarButtonItem alloc] initWithTitle:[IconFontCodes shared].search style:UIBarButtonItemStylePlain target:self action:@selector(onbbiSearch:)];
        [_bbiSearch setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[Globals shared].bbiIconFont, NSFontAttributeName, [Globals shared].themingAssistant.defaultIconColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    }
    return _bbiSearch;
}

- (void) onbbiSearch:(UIBarButtonItem *)sender
{
    [self searchHistory];
}

@end
