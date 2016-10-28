//
//  UIScrollView+Refresh.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/10/24.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XZHRefreshFooterView, XZHRefreshHeaderView;

@interface UIScrollView (Refresh)
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action;

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 *  @param dateKey 刷新时间保存的key值
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action dateKey:(NSString*)dateKey;

/**
 *  移除下拉刷新头部控件
 */
- (void)removeHeader;

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing;

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing;
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action;

/**
 *  移除上拉刷新尾部控件
 */
- (void)removeFooter;

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing;

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing;


/** 下拉刷新控件 */
@property (strong, nonatomic) XZHRefreshHeaderView *header;
/** 上拉刷新控件 */
@property (strong, nonatomic) XZHRefreshFooterView *footer;








@end
