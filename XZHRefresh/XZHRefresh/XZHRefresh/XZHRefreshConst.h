//
//  XZHRefreshConst.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/3.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef DEBUG
#define MJLog(...) NSLog(__VA_ARGS__)
#else
#define MJLog(...)
#endif

// 文字颜色
#define MJRefreshLabelTextColor [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0]

extern const NSInteger TimeLabelSize;
extern const NSInteger StatusLabelSize;

extern const CGFloat XZHRefreshViewHeight;
extern const CGFloat XZHRefreshAnimationDuration;

extern NSString *const XZHRefreshBundleName;
#define kSrcName(file) [MJRefreshBundleName stringByAppendingPathComponent:file]

extern NSString *const XZHRefreshFooterPullToRefresh;
extern NSString *const XZHRefreshFooterReleaseToRefresh;
extern NSString *const XZHRefreshFooterRefreshing;

extern NSString *const XZHRefreshHeaderPullToRefresh;
extern NSString *const XZHRefreshHeaderReleaseToRefresh;
extern NSString *const XZHRefreshHeaderRefreshing;
extern NSString *const XZHRefreshHeaderTimeKey;

extern NSString *const XZHRefreshContentOffset;
extern NSString *const XZHRefreshContentSize;