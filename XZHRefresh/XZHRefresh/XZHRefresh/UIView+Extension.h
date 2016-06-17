//
//  UIView+Extension.h
//  WeiBo
//
//  Created by lanou3g on 15/6/22.
//  Copyright (c) 2015年 杨建. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

/**
 *  创建视图
 *  @param frmae ViewFrame
 *  @param color ViewBackgroundColor
 *  @return 返回Label
 */
+ (UIView *)createViewFrame:(CGRect)frame backgroundColor:(UIColor *)color;

/**
 *  创建视图 固定颜色
 *  @param frmae ViewFrame
 *  @return 返回Label
 */
+ (UIView *)createViewFrame:(CGRect)frame;

@end
