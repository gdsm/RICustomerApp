//
//  GridPanelObject.m
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "GridPanelObject.h"
#import "Globals.h"

@implementation GridPanelObject

+ (GridPanelObject *) problemRequestGridStyle
{
    GridPanelObject* grid = [GridPanelObject new];
    grid.titleDetailDividerRatio = 0.999;
    grid.gridSize = CGSizeMake(150, 150);
    grid.borderColor = [Globals shared].themingAssistant.defaultBorderColor;
    grid.borderWidth = 1;
    grid.cornerRadius = 0;
    grid.textColor = [Globals shared].themingAssistant.defaultTextColor;
    grid.contentInset = UIEdgeInsetsMake(2, 2, 2, 2);
    grid.titleAlignment = NSTextAlignmentCenter;
    grid.detailAlignment = NSTextAlignmentCenter;
    return grid;
}

- (CGSize)contentSize
{
    CGSize retSize = CGSizeMake(self.gridSize.width - (self.contentInset.left + self.contentInset.right), self.gridSize.height - (self.contentInset.top + self.contentInset.bottom));
    return retSize;
}

@end
