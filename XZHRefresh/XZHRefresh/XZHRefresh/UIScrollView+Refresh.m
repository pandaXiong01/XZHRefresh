//
//  UIScrollView+Refresh.m
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/10/24.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import "XZHRefreshHeaderView.h"
#import "XZHRefreshFooterView.h"
#import <objc/runtime.h>



@implementation UIScrollView (Refresh)

#pragma mark - header
static const void *XZHRefreshHeaderKey = &XZHRefreshHeaderKey;
- (void)setHeader:(XZHRefreshHeaderView *)header {
    // 删除旧的，添加新的
    [self.header removeFromSuperview];
    [self addSubview:header];
    objc_setAssociatedObject(self, XZHRefreshHeaderKey, header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (XZHRefreshHeaderView *)header
{
    return objc_getAssociatedObject(self, &XZHRefreshHeaderKey);
}

#pragma mark - footer
static const void *XZHRefreshFooterKey = &XZHRefreshFooterKey;
- (void)setFooter:(XZHRefreshFooterView *)footer
{
    // 删除旧的，添加新的
    [self.footer removeFromSuperview];
    [self addSubview:footer];
    objc_setAssociatedObject(self, XZHRefreshFooterKey, footer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XZHRefreshFooterView *)footer
{
    return objc_getAssociatedObject(self, &XZHRefreshFooterKey);
}


/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action {


}

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 *  @param dateKey 刷新时间保存的key值
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action dateKey:(NSString*)dateKey {

}

/**
 *  移除下拉刷新头部控件
 */
- (void)removeHeader {

}

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing {

}

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing {

}
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action {

}

/**
 *  移除上拉刷新尾部控件
 */
- (void)removeFooter {

}

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing {

}

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing {

}
@end
