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
/** 显示上次刷新时间的标签 */
@property (weak, nonatomic) UILabel *updatedTimeLabel;
/** 上次刷新时间 */
@property (strong, nonatomic) NSDate *updatedTime;
/** 显示状态文字的标签 */
@property (weak, nonatomic) UILabel *stateLabel;
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;

@end


@implementation XZHRefreshHeaderView
#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        UILabel *stateLabel = [[UILabel alloc] init];
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_stateLabel = stateLabel];
    }
    return _stateLabel;
}

- (UILabel *)updatedTimeLabel
{
    if (!_updatedTimeLabel) {
        // 1.创建控件
        UILabel *updatedTimeLabel = [[UILabel alloc] init];
        updatedTimeLabel.backgroundColor = [UIColor clearColor];
        updatedTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_updatedTimeLabel = updatedTimeLabel];
        
        // 2.设置更新时间
        self.updatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:self.dateKey];
    }
    return _updatedTimeLabel;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    // 设置默认的dateKey(赶在父类init之前)
    self.dateKey = XZHRefreshHeaderUpdatedTimeKey;
    
    if (self = [super initWithFrame:frame]) {
        // 设置为默认状态
        self.state = XZHRefreshHeaderStateNormal;
        
        // 初始化文字
        [self setTitle:XZHRefreshHeaderPullToRefresh forState:XZHRefreshHeaderStateNormal];
        [self setTitle:XZHRefreshHeaderReleaseToRefresh forState:XZHRefreshHeaderStatePulling];
        [self setTitle:XZHRefreshHeaderRefreshing forState:XZHRefreshHeaderStateRefreshing];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        self.height = XZHRefreshViewHeight;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置自己的位置
    self.y = - self.height;
    
    // 2个标签都隐藏
    if (self.stateHidden && self.updatedTimeHidden) return;
    
    if (self.updatedTimeHidden) { // 显示状态
        _stateLabel.frame = self.bounds;
    } else if (self.stateHidden) { // 显示时间
        self.updatedTimeLabel.frame = self.bounds;
    } else { // 都显示
        CGFloat stateH = self.height * 0.55;
        CGFloat stateW = self.width;
        // 1.状态标签
        _stateLabel.frame = CGRectMake(0, 0, stateW, stateH);
        
        // 2.时间标签
        CGFloat updatedTimeY = stateH;
        CGFloat updatedTimeH = self.height - stateH;
        CGFloat updatedTimeW = stateW;
        self.updatedTimeLabel.frame = CGRectMake(0, updatedTimeY, updatedTimeW, updatedTimeH);
    }
}



+ (instancetype)header {
    return [[XZHRefreshHeaderView alloc] init];
}

/*
- (void)setScrollView:(UIScrollView *)scrollView
{
    [super setScrollView:scrollView];
    
    // 1.设置边框
    self.frame = CGRectMake(0, - XZHRefreshViewHeight, scrollView.frame.size.width, XZHRefreshViewHeight);
    
    // 2.加载时间
    self.lastUpdateTime = [[NSUserDefaults standardUserDefaults] objectForKey:XZHRefreshHeaderTimeKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if (![keyPath isEqualToString:XZHRefreshContentOffset]) {
        return;
    }
    
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden
        || self.state == XZHRefreshStateRefreshing) {
        return;
    }
    
    // scrollView所滚动的Y值 * 控件的类型（头部控件是-1，尾部控件是1）
    CGFloat offsetY = self.scrollView.contentOffset.y * self.refreshType;
    CGFloat validY = 100;//self.validY;
    if (offsetY <= validY) {
        return;
    }
    
    if (self.scrollView.isDragging) {
        //拖拽中（）validOffsetY = validY + MJRefreshViewHeight;  validY加不加都可以
        CGFloat validOffsetY = validY + XZHRefreshViewHeight;
        if (self.state == XZHRefreshStatePulling && offsetY <= validOffsetY) {
            //全程拖拽中，虽然到达高度，但是自己又拉回来，还是回到正常状态
            // 转为普通状态
            [self setState:XZHRefreshStateNormal];
            // 通知代理
            if ([self.delegate respondsToSelector:@selector(refreshView:changeState:)]) {
                [self.delegate refreshView:self changeState:XZHRefreshStateNormal];
            }
            
            // 回调
            if (self.stateChangeBlock) {
                self.stateChangeBlock(self, XZHRefreshStateNormal);
            }
        } else if (self.state == XZHRefreshStateNormal && offsetY > validOffsetY) {
            // 转为即将刷新状态
            [self setState:XZHRefreshStatePulling];
            // 通知代理
            if ([self.delegate respondsToSelector:@selector(refreshView:changeState:)]) {
                [self.delegate refreshView:self changeState:XZHRefreshStatePulling];
            }
            
            // 回调
            if (self.stateChangeBlock) {
                self.stateChangeBlock(self, XZHRefreshStatePulling);
            }
        }
    } else { // 即将刷新 && 手松开
        if (self.state == XZHRefreshStatePulling) {
            // 开始刷新
            [self setState:XZHRefreshStateRefreshing];
            // 通知代理
            if ([self.delegate respondsToSelector:@selector(refreshView:changeState:)]) {
                [self.delegate refreshView:self changeState:XZHRefreshStateRefreshing];
            }
            
            
            // 回调
            if (self.stateChangeBlock) {
                self.stateChangeBlock(self, XZHRefreshStateRefreshing);
            }
        }
    }
}

#pragma mark 设置状态
- (void)setState:(XZHRefreshState)state
{
    if (self.state != XZHRefreshStateRefreshing) {
        // 存储当前的contentInset
        self.scrollViewOriginalInset = self.scrollView.contentInset;
    }
    
    // 1.一样的就直接返回
    if (self.state == state) return;
    
    // 2.根据状态执行不同的操作
    switch (state) {
        case XZHRefreshStateNormal: // 普通状态
            // 显示箭头
            self.directionImage.hidden = NO;
            // 停止转圈圈
            [self.activityView stopAnimating];
            
            // 说明是刚刷新完毕 回到 普通状态的
            if (XZHRefreshStateRefreshing == self.state) {
                // 通知代理
                if ([self.delegate respondsToSelector:@selector(refreshViewEndRefresh:)]) {
                    [self.delegate refreshViewEndRefresh:self];
                }
                
                // 回调
                if (self.endRefreshBlock) {
                    self.endRefreshBlock(self);
                }
            }
            
            break;
            
        case XZHRefreshStatePulling:
            break;
            
        case XZHRefreshStateRefreshing:
            // 开始转圈圈
            [self.activityView startAnimating];
            // 隐藏箭头
            self.directionImage.hidden = YES;
            self.directionImage.transform = CGAffineTransformIdentity;
            
            // 通知代理
            if ([self.delegate respondsToSelector:@selector(refreshViewBeginRefresh:)]) {
                [self.delegate refreshViewBeginRefresh:self];
            }
            
            // 回调
            if (self.beginRefreshBlock) {
                self.beginRefreshBlock(self);
            }
            break;
        default:
            break;
    }
    
    // 3.存储状态
    self.state = state;
    
    
}



*/
@end
