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
#import "UIView+Extension.h"
#import "XZHRefreshConst.h"
#import <objc/message.h>
// 运行时objc_msgSend
#define msgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define msgTarget(target) (__bridge void *)(target)


@interface XZHRefreshView ()
{
    id _target;//存储响应目标
    SEL _action;//存储响应对象方法
}
@end
@implementation XZHRefreshView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 基本属性
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        
        // 默认文字颜色和字体大小
#warning 稍后设置
//        self.textColor = MJRefreshLabelTextColor;
//        self.font = MJRefreshLabelFont;
    }
    return self;
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:XZHRefreshContentOffset context:nil];
    
    if (newSuperview) { // 新的父控件
        [newSuperview addObserver:self forKeyPath:XZHRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        
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
#pragma mark -- 子类重写方法
- (void)addRefreshTarget:(id)target action:(SEL)action {
    //子类实现
    self.refreshingTarget = target;
    self.refreshingAction = action;
    
    if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
        //需要将objc_msgSend重新声明成自己想要的参数
        ((void (*)(id, SEL, UIView *))objc_msgSend)(self.refreshingTarget, self.refreshingAction, self);
        /**
         *  详情请参照苹果官方文档  Listing 2-14 Using a cast to call the Objective-C message sending functions。
         - (int) doSomething:(int) x { ... }
         - (void) doSomethingElse {
         int (*action)(id, SEL, int) = (int (*)(id, SEL, int)) objc_msgSend;
         action(self, @selector(doSomething:), 0);
         }
         
         */
    
        //msgSend(msgTarget(self.refreshingTarget), self.refreshingAction, self);
    
    }
}
- (void)beginRefreshing
{
    ((void (*)(id, SEL, UIView *))objc_msgSend)(self.refreshingTarget, self.refreshingAction, self);
}

- (void)endRefreshing
{
    
}

- (BOOL)isRefreshing {
    return NO;
}

@end
