//
//  XZHRefreshHeaderView.m
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/3.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshHeaderView.h"
#import "XZHRefreshConst.h"
#import "UIView+XZHExtension.h"
#import <objc/message.h>

@interface XZHRefreshHeaderView ()

@end


@implementation XZHRefreshHeaderView


#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        // 初始化文字
        self.state = XZHRefreshStateDraging;//默认状态
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置自己的位置
    self.xzh_y = - self.xzh_height;
    
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        // 移除之前的监听器
        [self.scrollView removeObserver:self forKeyPath:XZHRefreshContentOffset context:nil];
        // 监听contentOffset
        [newSuperview addObserver:self forKeyPath:XZHRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        [self setupFrameWithNewSuperview:newSuperview];
        
        
    }
}

- (void)setupFrameWithNewSuperview:(UIView *)newSuperview {
    self.xzh_height = XZHRefreshViewHeight;
    
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
    
    // 设置位置
    //self.y = self.scrollView.contentSize.height;
    NSLog(@"self.y : %lf", self.scrollView.contentSize.height);
}


+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    XZHRefreshHeaderView *headerView = [[self alloc] init];
    headerView.refreshingTarget = target;
    headerView.refreshingAction = action;
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
        CGFloat LetOffsetY = OriginalOffsetY - self.xzh_height;
        
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

- (void)setState:(XZHRefreshState)state {
    //这里调整视图控件的状态
    XZHRefreshState oldState = self.state;
    if (state == oldState) return;
    [super setState:state];
    
    // 2.根据状态执行不同的操作
    switch (state) {
        case XZHRefreshStateNormal: // 普通状态
        {
            
            // 说明是刚刷新完毕 回到 普通状态的
            if (XZHRefreshStateRefreshing == oldState) {
                //刷新完毕
                [UIView animateWithDuration:XZHRefreshAnimationDuration animations:^{
                    
                    UIEdgeInsets inset = self.scrollView.contentInset;
                    inset.top -=  self.xzh_height;
                    self.scrollView.contentInset = inset;
                    
                }];
                
                
            } else {
                
            }
            
        }
            break;
            
        case XZHRefreshStateLetOffRefreshing:
        {
            
        }
            break;
            
        case XZHRefreshStateRefreshing:
        {
            if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
                ((void (*)(void *, SEL, UIView *))objc_msgSend)((__bridge void *)(self.refreshingTarget), self.refreshingAction, self);
                
            }
            
            // 执行动画
            [UIView animateWithDuration:XZHRefreshAnimationDuration animations:^{
                // 1.增加滚动区域
                CGFloat top = self.scrollViewOriginalInset.top + self.xzh_height;
                UIEdgeInsets inset = self.scrollView.contentInset;
                inset.top = top;
                self.scrollView.contentInset = inset;
                
                // 2.设置滚动位置
                //                CGPoint offset = self.scrollView.contentOffset;
                //                offset.y = - top;
                //                self.scrollView.contentOffset = offset;
                
            }];
            
            
        }
            
            break;
        case XZHRefreshStateDraging:
        {
            
            
        }
            break;
        default:
            break;
    }
    

}




@end
