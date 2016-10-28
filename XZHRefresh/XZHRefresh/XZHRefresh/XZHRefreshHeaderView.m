//
//  XZHRefreshHeaderView.m
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/3.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshHeaderView.h"
#import "XZHRefreshConst.h"
#import "UIView+Extension.h"

@interface XZHRefreshHeaderView ()

@end


@implementation XZHRefreshHeaderView


#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        // 初始化文字
        [self setTitle:XZHRefreshHeaderDragText forState:XZHRefreshStateDraging];
        [self setTitle:XZHRefreshHeaderLetOffText forState:XZHRefreshStateLetOffRefreshing];
        [self setTitle:XZHRefreshHeaderRefreshingText forState:XZHRefreshStateRefreshing];
        [self setStatusLabelText];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置自己的位置
    self.y = - self.height;
    self.statusLabel.frame = self.bounds;
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        // 移除之前的监听器
        [self.scrollView removeObserver:self forKeyPath:XZHRefreshContentOffset context:nil];
        // 监听contentOffset
        [newSuperview addObserver:self forKeyPath:XZHRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        self.height = XZHRefreshViewHeight;
        
        
        // 设置宽度
        self.width = newSuperview.width;
        // 设置位置
        self.x = 0;
        // 记录UIScrollView
        self.scrollView = (UIScrollView *)newSuperview;
        // 设置永远支持垂直弹簧效果
        self.scrollView.alwaysBounceVertical = YES;
        // 记录UIScrollView最开始的contentInset
        self.scrollViewOriginalInset = self.scrollView.contentInset;
        
        
    }
}



+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    XZHRefreshHeaderView *headerView = [[XZHRefreshHeaderView alloc] init];
    headerView.beginRefreshingTaget = target;
    headerView.beginRefreshingAction = action;
    return headerView;
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 不能跟用户交互就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    // 如果正在刷新，直接返回
    if (self.state == XZHRefreshStateRefreshing ) return;

    if ([XZHRefreshContentOffset isEqualToString:keyPath]) {
        [self adjustStateWithContentOffset];
    }
}
- (void)adjustStateWithContentOffset {
    //在正在加载时scrollViewOriginalInset发生变化
    self.scrollViewOriginalInset = self.scrollView.contentInset;
    
    // 当前的contentOffset
    CGFloat currentOffsetY = self.scrollView.contentOffset.y; //往下拉变负
    // 头部控件刚好出现的offsetY
    CGFloat OriginalOffsetY = - self.scrollViewOriginalInset.top;  //有导航栏时-64
    
    NSLog(@"currentOffsetY:%f  happenOffsetY:%f", currentOffsetY , OriginalOffsetY);
    // 如果是向上滚动到看不见头部控件，直接返回
    if (currentOffsetY >= OriginalOffsetY) {
        return;
    }
    
    if (self.scrollView.isDragging) {
        // 即将刷新 的临界点
        CGFloat LetOffsetY = OriginalOffsetY - self.height;
        
        if (self.state == XZHRefreshStateDraging && currentOffsetY < LetOffsetY) {
            // 转为即将刷新状态
            self.state = XZHRefreshStateLetOffRefreshing  ;
        } else if (self.state == XZHRefreshStateLetOffRefreshing && currentOffsetY >= LetOffsetY) {
            // 转为普通拖拽状态
            self.state = XZHRefreshStateDraging;
        }else if (self.state == XZHRefreshStateNormal && currentOffsetY >= LetOffsetY) {
            self.state = XZHRefreshStateDraging;
        }
    } else if (self.state == XZHRefreshStateLetOffRefreshing) {// 即将刷新 && 手松开
        // 开始刷新
        self.state = XZHRefreshStateRefreshing;
    }

}

- (void)setTitle:(NSString *)title forState:(XZHRefreshState)state {
    switch (state) {
        case XZHRefreshStateDraging:
        {
            self.dragText = title;
        }
            break;
        case XZHRefreshStateLetOffRefreshing:
        {
            self.letOffText = title;
        }
            break;
        case XZHRefreshStateRefreshing:
        {
            self.refreshingText = title;
        }
            break;
            
        default:
            break;
    }
}
- (void)endRefresh {
    self.state = XZHRefreshStateNormal;
}

@end
