//
//  XZHRefreshView.m
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/6.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshView.h"
#import "XZHRefreshFooterView.h"
#import "XZHRefreshHeaderView.h"
#import "UIView+XZHExtension.h"
#import "XZHRefreshConst.h"
#import <objc/message.h>
// 运行时objc_msgSend
#define msgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define msgTarget(target) (__bridge void *)(target)


@interface XZHRefreshView ()

@end
@implementation XZHRefreshView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:XZHRefreshContentOffset context:nil];
    
    if (newSuperview) { // 新的父控件
        [newSuperview addObserver:self forKeyPath:XZHRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        
        // 设置宽度
        self.xzh_width = newSuperview.xzh_width;
        // 设置位置
        self.xzh_x = 0;
        
        // 记录UIScrollView
        self.scrollView = (UIScrollView *)newSuperview;
        // 设置永远支持垂直弹簧效果
        self.scrollView.alwaysBounceVertical = YES;
        // 记录UIScrollView最开始的contentInset
        self.scrollViewOriginalInset = self.scrollView.contentInset;
    }
   
}

- (void)beginRefreshing {
    
    self.state = XZHRefreshStateRefreshing;
}

- (void)endRefreshing {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.state = XZHRefreshStateNormal;
    });
    
}
- (void)setState:(XZHRefreshState)state {
    _state = state;
}
- (BOOL)isRefreshing {
    return NO;
}

/*
 一.分为三层  
 1.基类 XZHRefreshView 开始结束刷新方法，添加到父试图方法；持有scrollView控件 最初的偏移量。
 2.XZHRefreshHeaderView XZHRefreshFooterView  下拉与上拉的基类  在这里检测视图的偏移量根据偏移量改变控件的状态，控制刷新时的偏移量。
 3.XZHRefreshGeneralHeaderView 使用的控件  这里绘制使用控件的视图 使用state的set方法，改变控件上子视图的文字与动画状态。
 
 
 二、注意事项
 1.下拉控件 在显示cell不到整个屏幕时候隐藏
 2.上拉加载-》设置没有更多数据（不再触发上拉加载）    在用户再次刷新的时候 回复上拉加载
 3.检测tableView刷新 回调时获取dataSource 如果没有数据则不显示footer
 4.下拉刷新时 如果tableView显示不到整个屏幕，footer也会触发刷新***
 */
@end
