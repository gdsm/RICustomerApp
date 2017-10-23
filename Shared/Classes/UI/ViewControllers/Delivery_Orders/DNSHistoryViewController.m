//
//  DNSHistoryViewController.m
//  ReddyIce
//
//  Created by Gagan on 21/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "DNSHistoryViewController.h"
#import "DeliveryOrderViewController.h"
#import "ReportLineCell.h"
#import "DeliveryHistoryCell.h"


@interface DNSHistoryViewController ()

@end

@implementation DNSHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 1;
    if (indexPath.row == 0)
    {
        height = DeliveryOrderVC_HeaderCell_Height;
    }
    else
    {
        height = DeliveryOrderVC_OrderCell_Height;
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
        [cell.reportLineView setTitles:@"Invoice No.", @"Total Amount", @"DNS", nil];
        [cell.reportLineView labelAtIndex:0].textAlignment = NSTextAlignmentLeft;
        [cell.reportLineView labelAtIndex:1].textAlignment = NSTextAlignmentCenter;
        [cell.reportLineView labelAtIndex:2].textAlignment = NSTextAlignmentRight;

        return cell;
    }
    else
    {
        DeliveryHistoryCell* cell = [DeliveryHistoryCell dequeueFrom:tableView loadFromNib:@"DeliveryHistoryCell"];
        [cell updateCell];
        cell.deliveryHistoryView.historyType = DeliveryHistoryType_DNS;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((self.onDNSTap != nil) && (self.detailHistory == false))
    {
        self.onDNSTap(indexPath);
    }
}

@end
