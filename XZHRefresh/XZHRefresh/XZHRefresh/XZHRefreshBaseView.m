//
//  XZHRefreshBaseView.m
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/3.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshBaseView.h"
#import "XZHRefreshConst.h"
@interface XZHRefreshBaseView ()


@end

@implementation XZHRefreshBaseView
#pragma mark 创建一个UILabel
- (UILabel *)labelWithFontSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] init];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:size];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
#pragma mark - 初始化方法
- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super init]) {
        self.scrollView = scrollView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!_hasOriginalInset) {
        self.scrollViewOriginalInset = _scrollView.contentInset;
        //手动调用KVO
        [self observeValueForKeyPath:XZHRefreshContentSize ofObject:nil change:nil context:nil];
        self.hasOriginalInset = YES;
        if (_state == XZHRefreshStateWillRefreshing) {
            [self setState:XZHRefreshStateRefreshing];
        }
    }
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //?????
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        //label
        self.lastUpdateTimeLabel = [self labelWithFontSize:TimeLabelSize];
        self.statusLabel = [self labelWithFontSize:StatusLabelSize];
        [self addSubview:_lastUpdateTimeLabel];
        [self addSubview:_statusLabel];
        //方向箭头
        self.directionImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        _directionImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_directionImage];
        //指示器
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.bounds = _directionImage.bounds;
        activityView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [self setState:XZHRefreshStateNormal];
    }
    return self;
}
- (void)setFrame:(CGRect)frame {
    frame.size.height = XZHRefreshViewHeight;
    [super setFrame:frame];
    
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    if (w == 0 || _directionImage.center.y == h * 0.5) return;
    
    CGFloat statusX = 0;
    CGFloat statusY = 5;
    CGFloat statusHeight = 20;
    CGFloat statusWidth = w;
    // 1.状态标签
    _statusLabel.frame = CGRectMake(statusX, statusY, statusWidth, statusHeight);
    
    // 2.时间标签
    CGFloat lastUpdateY = statusY + statusHeight + 5;
    _lastUpdateTimeLabel.frame = CGRectMake(statusX, lastUpdateY, statusWidth, statusHeight);
    
    // 3.箭头
    CGFloat arrowX = w * 0.5 - 100;
    _directionImage.center = CGPointMake(arrowX, h * 0.5);
    
    // 4.指示器
    _activityView.center = _directionImage.center;
    
    
}

- (void)setBounds:(CGRect)bounds {
    bounds.size.height = XZHRefreshViewHeight;
    [super setBounds:bounds];
}
#pragma mark 设置UIScrollView
- (void)setScrollView:(UIScrollView *)scrollView
{
    // 移除之前的监听器 ?????
    [_scrollView removeObserver:self forKeyPath:XZHRefreshContentOffset context:nil];
    // 监听contentOffset
    [scrollView addObserver:self forKeyPath:XZHRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
    
    // 设置scrollView
    _scrollView = scrollView;
    [_scrollView addSubview:self];
}


#pragma mark 设置状态
- (void)setState:(XZHRefreshState)state
{
    
}

- (void)beginRefresh {
    
    
}
- (void)endRefresh {
    
}
//结束时释放资源
- (void)free {
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
