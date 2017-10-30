//
//  ItemViewController.m
//  ReddyIce
//
//  Created by Gagan on 13/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "ItemViewController.h"
#import "ItemDetailViewController.h"
#import "BottomTabView.h"
#import "ItemCell.h"

const CGFloat ItemsVC_itemCellHeight = 200;

@interface ItemViewController ()
@end

@implementation ItemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI
{
    //TODO:[GM]: Add localisation
    self.title = @"Products";
    self.bgImgv.image = nil;

    CGFloat top = (self.navigationBarHeight + self.statusBarHeight);
    self.tableOffset = UIEdgeInsetsMake(top, 0, self.bottomTabView.frame.size.height, 0);

    self.navigationItem.hidesBackButton = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.bottomTabView.hidden = NO;
}

#pragma mark - Logical Flow Methods

- (void) itemVariationSelected
{
    ItemDetailViewController* view = [[ItemDetailViewController alloc] init];
    [self safePush:view animated:YES];
}


#pragma mark - TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ItemsVC_itemCellHeight;
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
    ItemCell *cell = [ItemCell dequeueFrom:tableView loadFromNib:@"ItemCell"];
    cell.indexPath = indexPath;
    [cell updateCell];

    cell.itemView.lblPriceDescr.text = @"Cost per lb $0.00";
    cell.itemView.lblVariationDescr.text = @"Avaliable Size.";
    cell.itemView.lblCartQuantity.text = @"20 lbs X 2 in cart.";
    if (indexPath.row == 0)
    {
        cell.itemView.imgvItem.image = [UIImage imageNamed:@"prod_sample_0.png"];
        cell.itemView.lblTitle.text = @"Crystal Classic Cubes™";
    }
    else if (indexPath.row == 1)
    {
        cell.itemView.imgvItem.image = [UIImage imageNamed:@"prod_sample_1.png"];
        cell.itemView.lblTitle.text = @"Cubed Ice";
    }
    else if (indexPath.row == 2)
    {
        cell.itemView.imgvItem.image = [UIImage imageNamed:@"prod_sample_2.png"];
        cell.itemView.lblTitle.text = @"Block Ice";
    }
    else
    {
        cell.itemView.imgvItem.image = [UIImage imageNamed:@"prod_sample_3.png"];
        cell.itemView.lblTitle.text = @"Dry Ice";
    }
    
    __weak ItemViewController* weakSelf = self;
    cell.itemView.varSelected = ^(NSIndexPath *indexPath) {
        [weakSelf itemVariationSelected];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
