//
//  CategoryDetailButton.h
//  ReddyIce
//
//  Created by Gagan on 23/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseButton.h"
#import "CategoryDetailView.h"

@interface CategoryDetailButton : BaseButton

+ (CategoryDetailButton *) instanceWithFrame:(CGRect)frame;
@property (nonatomic, strong) CategoryDetailView* categoryDetailView;

@end
