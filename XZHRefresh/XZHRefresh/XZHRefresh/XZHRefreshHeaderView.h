//
//  XZHRefreshHeaderView.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/3.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshView.h"
// 下拉刷新控件的状态
typedef enum {
    /** 普通闲置状态 */
    XZHRefreshHeaderStateNormal = 1,
    /** 松开就可以进行刷新的状态 */
    XZHRefreshHeaderStatePulling,
    /** 正在刷新中的状态 */
    XZHRefreshHeaderStateRefreshing,
} XZHRefreshHeaderState;

@interface XZHRefreshHeaderView : XZHRefreshView
/** 利用这个key来保存上次的刷新时间（不同界面的刷新控件应该用不同的dateKey，以区分不同界面的刷新时间） */
@property (copy, nonatomic) NSString *dateKey;

/**
 * 设置state状态下的状态文字内容title(别直接拿stateLabel修改文字)
 */
- (void)setTitle:(NSString *)title forState:(XZHRefreshHeaderState)state;
/** 刷新控件的状态 */
@property (assign, nonatomic) XZHRefreshHeaderState state;

#pragma mark - 文字控件的可见性处理
/** 是否隐藏状态标签 */
@property (assign, nonatomic, getter=isStateHidden) BOOL stateHidden;
/** 是否隐藏刷新时间标签 */
@property (assign, nonatomic, getter=isUpdatedTimeHidden) BOOL updatedTimeHidden;

#pragma mark - 交给子类重写
/** 下拉的百分比(交给子类重写) */
@property (assign, nonatomic) CGFloat pullingPercent;

+ (id)header;
@end
