//
//  FeedbackQuestionareViewController.m
//  ReddyIce
//
//  Created by Gagan on 27/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "FeedbackQuestionareViewController.h"
#import "FeedbackCommentsViewController.h"
#import "iCarousel.h"
#import "FeedbackView.h"

@interface FeedbackQuestionareViewController () <iCarouselDelegate, iCarouselDataSource>
@property (nonatomic, strong) iCarousel* carouselView;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) NSMutableArray* dataSource;
@property (nonatomic, strong) NSMutableArray<FeedbackView*>* feedbackViews;
@end

@implementation FeedbackQuestionareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.carouselView reloadData];
    self.bottomTabView.hidden = NO;
}

- (void)setupUI
{
    self.title = @"Feedback";
    self.bgImgv.image = nil;
    self.tableView.hidden = YES;

    [self.view addSubview:self.carouselView];
    [self.view addSubview:self.pageControl];
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
        [_dataSource addObject:@"We delivered your order is everything okay ?"];
        [_dataSource addObject:@"How would you rate Timely arrival of driver?"];
        [_dataSource addObject:@"How satisfied are you with our billing and invoicing?"];
        [_dataSource addObject:@"How satisfied are you with our billing and invoicing?"];
    }
    return _dataSource;
}

#pragma mark - Logical Flow Methods

- (void) feedbackForView:(FeedbackView *)view
{
    if (view.indexPath.row < (self.dataSource.count-1))
    {
        [self.carouselView scrollToItemAtIndex:view.indexPath.row+1 animated:YES];
    }
    else
    {
        [self completedQuestionary];
    }
}

- (void) completedQuestionary
{
    FeedbackCommentsViewController* view = [[FeedbackCommentsViewController alloc] initWithStyle:UITableViewStylePlain];
    [self safePush:view animated:NO];
}

#pragma mark - Carusel Delegates

- (NSInteger) numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.dataSource.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view
{
    if (view == nil)
    {
        FeedbackView* feedbackView = [self.feedbackViews objectAtIndex:index];
        feedbackView.frame = carousel.bounds;
        view = feedbackView;
    }
    else
    {
        view = [self.feedbackViews objectAtIndex:index];
    }

    return view;
}

#pragma mark - UI Methods

- (iCarousel *)carouselView
{
    if (_carouselView == nil)
    {
        CGRect rect = CGRectZero;
        rect.origin.y = self.navigationBarHeight + self.statusBarHeight;
        rect.size.width = self.view.frame.size.width;
        rect.size.height = (self.pageControl.frame.origin.y - rect.origin.y - bottomMargin_20px);
        _carouselView = [[iCarousel alloc] initWithFrame:rect];
        _carouselView.type = iCarouselTypeCylinder;
        
        _carouselView.pagingEnabled = YES;
        
        _carouselView.delegate = self;
        _carouselView.dataSource = self;
        
        _carouselView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _carouselView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil)
    {
        CGRect rect = CGRectZero;
        rect.size.height = viewHeight_20px;
        rect.origin.y = self.view.frame.size.height - (viewHeight_20px + bottomMargin_20px);
        rect.size.width = self.view.frame.size.width;

        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.numberOfPages = self.dataSource.count;
        _pageControl.tintColor = [Globals shared].themingAssistant.blueNorm;
        _pageControl.pageIndicatorTintColor = [Globals shared].themingAssistant.blueHigh;

        _pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    return _pageControl;
}

- (NSMutableArray<FeedbackView*>*) feedbackViews
{
    if (_feedbackViews == nil)
    {
        __weak FeedbackQuestionareViewController* weakSelf = self;
        _feedbackViews = [NSMutableArray new];
        NSInteger row = 0;
        for (NSString* value in self.dataSource)
        {
            FeedbackView* view = [FeedbackView instance];
            [view updateUI];
            view.onRattingValue = ^(id sender) {
                if ([sender isKindOfClass:[FeedbackView class]])
                {
                    [weakSelf feedbackForView:sender];
                }
            };
            view.indexPath = [NSIndexPath indexPathForRow:(row++) inSection:0];
            view.lblQuestion.text = value;
            [_feedbackViews addObject:view];
        }
    }
    return _feedbackViews;
}

@end
