//
//  XZHRefreshHeaderView.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/3.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshBaseView.h"

@interface XZHRefreshHeaderView : XZHRefreshBaseView

/**
 * 设置state状态下的状态文字内容title(别直接拿stateLabel修改文字)
 */
- (void)setTitle:(NSString *)title forState:(XZHRefreshState)state;
/** 刷新控件的状态 */




#pragma mark - 交给子类重写
/** 下拉的百分比(交给子类重写) */
@property (assign, nonatomic) CGFloat pullingPercent;

+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;
- (void)endRefresh;
@end
