//
//  UIScrollView+XZHRefresh.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/10/26.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XZHRefreshFooterView, XZHRefreshHeaderView;
@interface UIScrollView (XZHRefresh)
/** 下拉刷新控件 */
@property (strong, nonatomic) XZHRefreshHeaderView *refreshHeader;
/** 上拉刷新控件 */
@property (strong, nonatomic) XZHRefreshFooterView *refreshFooter;

- (NSInteger)allDataCount;//所有数据个数
@end
