//
//  UIScrollView+XZHRefresh.m
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/10/26.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "UIScrollView+XZHRefresh.h"
#import "XZHRefreshHeaderView.h"
#import "XZHRefreshFooterView.h"
#import <objc/runtime.h>

@implementation UIScrollView (XZHRefresh)
#pragma mark - header
static const void *XZHRefreshHeaderKey = &XZHRefreshHeaderKey;

- (void)setRefreshHeader:(XZHRefreshHeaderView *)refreshHeader {
    // 删除旧的，添加新的
    [self.refreshHeader removeFromSuperview];
    [self addSubview:refreshHeader];
    objc_setAssociatedObject(self, XZHRefreshHeaderKey, refreshHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (XZHRefreshHeaderView *)refreshHeader {
    return objc_getAssociatedObject(self, &XZHRefreshHeaderKey);
}
#pragma mark - footer
static const void *XZHRefreshFooterKey = &XZHRefreshFooterKey;
- (void)setRefreshFooter:(XZHRefreshFooterView *)refreshFooter {
    // 删除旧的，添加新的
    [self.refreshFooter removeFromSuperview];
    [self addSubview:refreshFooter];
    objc_setAssociatedObject(self, XZHRefreshFooterKey, refreshFooter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (XZHRefreshFooterView *)refreshFooter {
    return objc_getAssociatedObject(self, &XZHRefreshFooterKey);
}




- (NSInteger)allDataCount {
    
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}


@end
