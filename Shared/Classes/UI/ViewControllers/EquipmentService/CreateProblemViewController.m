//
//  CreateProblemViewController.m
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "CreateProblemViewController.h"
#import "ProblemCategoryViewController.h"
#import "GridPanelView.h"
#import "Globals.h"

@interface CreateProblemViewController ()
@property (weak, nonatomic) IBOutlet BaseLabel *lblHeader;
@property (nonatomic, strong) GridPanelView* gridPanelView;
@property (nonatomic, strong) NSMutableArray* dataSource;
@end


@implementation CreateProblemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.gridPanelView reloadGrid];
}

- (void)setupUI
{
    //TODO:[GM]: Add localisation
    self.title = @"New Problem Request.";
    self.bgImgv.image = nil;
    self.bottomTabView.hidden = YES;
    self.lblHeader.text = @"Please Select your equipment type.";
    [self.lblHeader defaultStyling];
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
        [_dataSource addObject:@"Ice Factory"];
        [_dataSource addObject:@"Inline Freezer"];
        [_dataSource addObject:@"Merchandiser"];
        [_dataSource addObject:@"Satelite Box"];
        [_dataSource addObject:@"Don't know"];
    }
    return _dataSource;
}

#pragma mark - Logical Methods

- (void) problemOptionSelected:(NSUInteger)option
{
    ProblemCategoryViewController* view = [[ProblemCategoryViewController alloc] init];
    [self safePush:view animated:YES];
}

#pragma mark - Layout Methods

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect rect_gridView = self.gridPanelView.frame;
    rect_gridView.origin.x = (self.view.frame.size.width - rect_gridView.size.width) * 0.5;
    self.gridPanelView.frame = rect_gridView;
}


#pragma mark - UI Methods

- (GridPanelView *) gridPanelView
{
    if (_gridPanelView == nil)
    {
        CGFloat top = (self.lblHeader.frame.origin.y + self.lblHeader.frame.size.height + topMargin_20px);
        GridPanelObject* sampleObj = [GridPanelObject problemRequestGridStyle];
        CGFloat width = sampleObj.gridSize.width * 2;
        CGFloat height = sampleObj.gridSize.height * 3;
        
        CGRect rect = CGRectMake((self.view.frame.size.width - width) * 0.5, top, width, height);
        
        __weak CreateProblemViewController* weakSelf = self;
        
        blk_gridData data = ^GridPanelObject* (NSInteger row){
            GridPanelObject* obj = [GridPanelObject problemRequestGridStyle];
            obj.title = [weakSelf.dataSource objectAtIndex:row];
            return obj;
        };
        
        blk_gridAction action = ^(GridPanelObject *object, NSUInteger index){
            [weakSelf problemOptionSelected:index];
        };
        
        _gridPanelView = [[GridPanelView alloc] initWithFrame:rect
                                                numberOfGrids:self.dataSource.count scrollDirection:UICollectionViewScrollDirectionVertical
                                                     gridData:data
                                                   gridAction:action];
        _gridPanelView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_gridPanelView];
    }
    return _gridPanelView;
}

@end
