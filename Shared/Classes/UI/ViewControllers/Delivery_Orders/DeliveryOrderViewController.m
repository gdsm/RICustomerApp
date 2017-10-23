//
//  DeliveryHistoryViewController.m
//  ReddyIce
//
//  Created by Gagan on 20/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "DeliveryOrderViewController.h"
#import "DeliveryHistoryViewController.h"
#import "OrderHistoryViewController.h"
#import "DNSHistoryViewController.h"
#import "BaseNavigationController.h"
#import "Globals.h"


const CGFloat DeliveryOrderVC_HeaderCell_Height = 40.0;
const CGFloat DeliveryOrderVC_OrderCell_Height = 80.0;


@interface DeliveryOrderViewController ()
@property (nonatomic, strong) UISegmentedControl* segControl;
@property (nonatomic, strong) BaseNavigationController* navController;
@property (nonatomic, strong) UIBarButtonItem* bbiSearch;
@end


@implementation DeliveryOrderViewController


#pragma mark - View Life Cycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setSelectedSegment:0];
}

- (void)setupUI
{
    //TODO:[GM]: Add localisation
    self.title = @"Delivery History";
    self.bgImgv.image = nil;
    
    self.tableView.hidden = YES;
    
    self.bottomTabView.hidden = NO;
    
    self.navigationItem.rightBarButtonItem = self.bbiSearch;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Logical Methods

- (void) searchHistory
{
    
}
- (void) showFullOrderHistory
{
    __weak DeliveryOrderViewController* weakSelf = self;

    OrderHistoryViewController* view = [[OrderHistoryViewController alloc] init];
    view.detailHistory = true;
    view.onCancel = ^{
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    };
    [self safePresent:view onSelf:NO animated:YES callbackCompletion:nil];
}

- (void) showFullDNSHistory
{
    DNSHistoryViewController* view = [[DNSHistoryViewController alloc] init];
    view.detailHistory = true;
    [self safePresent:view onSelf:NO animated:YES callbackCompletion:nil];
}

- (void) showFullDeliveryHistory
{
    __weak DeliveryOrderViewController* weakSelf = self;
    DeliveryHistoryViewController* view = [[DeliveryHistoryViewController alloc] init];
    view.detailHistory = true;
    view.onCancel = ^{
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    };
    [self safePresent:view onSelf:NO animated:YES callbackCompletion:nil];
}

- (void) setSelectedSegment:(NSUInteger)segment
{
    __weak DeliveryOrderViewController* weakSelf = self;
    if (segment == 0)
    {
        OrderHistoryViewController* view = [[OrderHistoryViewController alloc] init];
        view.detailHistory = false;
        view.onOrderTap = ^(NSIndexPath *sender) {
            [weakSelf showFullOrderHistory];
        };
        [self.navController safePush:view animated:NO];
    }
    else if (segment == 1)
    {
        DeliveryHistoryViewController* view = [[DeliveryHistoryViewController alloc] init];
        view.detailHistory = false;
        view.onDeliveryTap = ^(NSIndexPath *sender) {
            [weakSelf showFullDeliveryHistory];
        };
        [self.navController safePush:view animated:NO];
    }
    else if (segment == 2)
    {
        DNSHistoryViewController* view = [[DNSHistoryViewController alloc] init];
        view.detailHistory = false;
        view.onDNSTap = ^(NSIndexPath *sender) {
            [weakSelf showFullDNSHistory];
        };
        [self.navController safePush:view animated:NO];
    }
}

#pragma mark - Layout Methods

- (void)layoutSubviews
{
    CGRect rect_navController = self.navController.view.frame;
    CGRect rect_segControl = self.segControl.frame;

    CGFloat yOffset = rect_segControl.origin.y;
    rect_segControl.size.width = self.view.frame.size.width - (leftMargin_20px + rightMargin_20px);
    
    yOffset += (rect_segControl.size.height + topMargin_20px);
    
    rect_navController.origin.x = leftMargin_20px;
    rect_navController.origin.y = yOffset;
    rect_navController.size.width = self.view.frame.size.width - (leftMargin_20px + rightMargin_20px);
    rect_navController.size.height = self.view.frame.size.height - (yOffset + self.bottomTabView.frame.size.height);

    self.navController.view.frame = rect_navController;
    self.segControl.frame = rect_segControl;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self layoutSubviews];
}

#pragma mark - UI Methods

- (BaseNavigationController *)navController
{
    if (_navController == nil)
    {
        _navController = [[BaseNavigationController alloc] init];
        _navController.navigationBarHidden = YES;
        [self.view addSubview:_navController.view];
    }
    return _navController;
}

- (UISegmentedControl *)segControl
{
    if (_segControl == nil)
    {
        CGFloat top = (self.navigationBarHeight + self.statusBarHeight);
        CGRect rect_segControl = self.view.bounds;
        rect_segControl.origin.x = leftMargin_20px;
        rect_segControl.origin.y = topMargin_20px + top;
        rect_segControl.size.height = viewHeight_40px;

        _segControl = [[UISegmentedControl alloc] initWithItems:@[@"Orders(4)", @"Delivery", @"DNS"]];
        _segControl.frame = rect_segControl;
        _segControl.clipsToBounds = YES;
        
        _segControl.backgroundColor = [UIColor lightGrayColor];
        _segControl.tintColor = [UIColor whiteColor];
        [_segControl addTarget:self action:@selector(onSegCtrlChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_segControl];
    }
    return _segControl;
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

- (void) onSegCtrlChanged:(UISegmentedControl *)segCtrl
{
    [self setSelectedSegment:segCtrl.selectedSegmentIndex];
}

- (void) onbbiSearch:(UIBarButtonItem *)sender
{
    [self searchHistory];
}

@end
