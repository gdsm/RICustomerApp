//
//  GridPanelObject.h
//  ReddyIce
//
//  Created by Gagan on 24/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GridPanelObject : NSObject

+ (GridPanelObject *) problemRequestGridStyle;

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* detail;

@property (nonatomic) NSTextAlignment titleAlignment;
@property (nonatomic) NSTextAlignment detailAlignment;

@property (nonatomic) BOOL buttonObject;
@property (nonatomic) CGSize gridSize;
@property (nonatomic) CGFloat titleDetailDividerRatio;

@property (nonatomic) CGFloat borderWidth;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic, weak) UIColor* borderColor;

@property (nonatomic, weak) UIColor* normalColor;
@property (nonatomic, weak) UIColor* highlightedColor;
@property (nonatomic, weak) UIColor* textColor;

@property (nonatomic) UIEdgeInsets contentInset;
@property (nonatomic) CGSize contentSize;

@end
