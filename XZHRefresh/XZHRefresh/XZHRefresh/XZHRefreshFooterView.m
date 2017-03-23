//
//  XZHRefreshFooterView.m
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/3.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshFooterView.h"
#import <objc/message.h>

@interface XZHRefreshFooterView ()


@end
@implementation XZHRefreshFooterView
/*
 增加tableView的contentView footer算作tableView的底部
 
 */
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
    XZHRefreshFooterView *footer = [[self alloc] init];
    footer.refreshingTarget = target;
    footer.refreshingAction = action;
    return footer;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置位置
    self.xzh_y = self.scrollView.contentSize.height;
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:XZHRefreshContentSize context:nil];
    [self.superview removeObserver:self forKeyPath:XZHRefreshPanState context:nil];

    if (newSuperview) { // 新的父控件
        // 监听
        [newSuperview addObserver:self forKeyPath:XZHRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:XZHRefreshPanState options:NSKeyValueObservingOptionNew context:nil];
        
        [self setupFrame];
    }

    
}

- (void)setupFrame {
    self.xzh_height = XZHRefreshViewHeight;
    UIEdgeInsets inset = self.scrollView.contentInset;
    //在contentview下面加个尾巴，相当于增加了contentview的高度
    inset.bottom += self.xzh_height;
    self.scrollView.contentInset = inset;
    
    // 设置位置
    //self.y = self.scrollView.contentSize.height;
    NSLog(@"self.y : %lf", self.scrollView.contentSize.height);
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 不能跟用户交互，直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden || self.state == XZHRefreshStateNoMoreData) {
        
        return;
    }
    
    if ([XZHRefreshPanState isEqualToString:keyPath]){
        if (self.scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
            if (self.scrollView.contentInset.top+self.scrollView.contentInset.bottom+self.scrollView.contentSize.height <= self.scrollView.xzh_height) {
                //滚动区域小于scrollView的区域 向上滑动就刷新
                if (self.scrollView.contentOffset.y > -self.scrollView.contentInset.top) {
                    //向上拽
                    self.state = XZHRefreshStateRefreshing;
                }
                
            } else {
                if (self.scrollView.contentOffset.y > self.frame.origin.y + self.scrollView.contentInset.bottom - self.scrollView.frame.size.height) {
                    self.state = XZHRefreshStateRefreshing;
                }
            }
        }
    
    } else if ([XZHRefreshContentSize isEqualToString:keyPath]) {
        // 调整frame
        self.xzh_y = self.scrollView.contentSize.height;
    } else if ([XZHRefreshContentOffset isEqualToString:keyPath]) {
        // 如果正在刷新，直接返回
        if (self.state ==  XZHRefreshStateRefreshing) return;
        
        // 调整状态
        [self adjustStateWithContentOffset];
    }
}



- (void)adjustStateWithContentOffset {
    if (self.frame.origin.y == 0) {
        return;
    }
    if (self.scrollView.contentInset.top + self.scrollView.contentInset.bottom + self.scrollView.contentSize.height > self.scrollView.frame.size.height) {
        CGPoint point = [self convertPoint:self.bounds.origin toView:nil];
        if (CGRectContainsPoint(self.window.bounds, point)) {
            self.state = XZHRefreshStateRefreshing;
        }
    }
}
- (void)setState:(XZHRefreshState)state {
    XZHRefreshState oldState = self.state;
    if (state == oldState) return;
    [super setState:state];
    //TODO :下拉刷新触发这个方法，需要检查一下。（长度低于整个屏幕）
    switch (state) {
        case XZHRefreshStateRefreshing:
        {
            if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
                ((void (*)(void *, SEL, UIView *))objc_msgSend)((__bridge void *)(self.refreshingTarget), self.refreshingAction, self);
                
            }

        }
            break;
        case XZHRefreshStateNormal:
        {
            
        }
            break;
        case XZHRefreshStateNoMoreData:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
}
- (void)setNoMoreDataState {

}
@end
