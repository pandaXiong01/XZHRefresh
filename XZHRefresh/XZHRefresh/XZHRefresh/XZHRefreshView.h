//
//  XZHRefreshView.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/6.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZHRefreshConst.h"
#import "UIView+XZHExtension.h"

/**
 控件状态
 */
typedef enum {
    XZHRefreshStateDraging = 1, // 拖拽范围超过tableView的contentView（露出header头还没到可以放开刷新的时候，footer一到底开始刷新没有该状态）
    XZHRefreshStateNormal,   // 普通状态
    XZHRefreshStateRefreshing,//刷新中……
    XZHRefreshStateLetOffRefreshing,//松开就可以进行刷新的状态
    XZHRefreshStateNoMoreData //加载没有更多数据了
} XZHRefreshState;


@interface XZHRefreshView : UIView

@property (weak, nonatomic) id refreshingTarget;
@property (assign, nonatomic) SEL refreshingAction;
/** 记录scrollView刚开始的inset */
@property (assign, nonatomic) UIEdgeInsets scrollViewOriginalInset;
/** 父控件 */
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, assign) XZHRefreshState state;
/** 进入刷新状态 */
- (void)beginRefreshing;
/** 结束刷新状态 */
- (void)endRefreshing;


//状态是否更改
@end
