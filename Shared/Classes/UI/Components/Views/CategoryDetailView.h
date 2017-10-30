//
//  CategoryDetailView.h
//  ReddyIce
//
//  Created by Gagan on 17/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "BaseView.h"

typedef NS_ENUM(NSUInteger, CategoryDetailStyle){
    CategoryDetailStyle_Horizontal,
    CategoryDetailStyle_Vertical
};


@interface CategoryDetailView : BaseView

@property (nonatomic) CategoryDetailStyle categoryDetailStyle;

@property (nonatomic, strong) BaseLabel* lblCategory;
@property (nonatomic, strong) BaseLabel* lblDetail;
@property (nonatomic, strong) BaseView* viewUnderLine;

@property (nonatomic, strong) UIImageView* imgvCategory;
@property (nonatomic, strong) UIImageView* imgvDetail;

@property (nonatomic) CGFloat dividerRatio;

@property (nonatomic, strong) NSString* category;
@property (nonatomic, strong) NSString* detail;

@property (nonatomic, strong) NSString* imgCategory;
@property (nonatomic, strong) NSString* imgDetail;


@end
