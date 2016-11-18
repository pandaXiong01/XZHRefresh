//
//  XZHRefreshBaseView.m
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/3.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshBaseView.h"
#import "XZHRefreshConst.h"
#import "UIView+Extension.h"
#import <objc/message.h>
@interface XZHRefreshBaseView ()


@end
static const CGFloat animateDuration  =  0.3;

@implementation XZHRefreshBaseView
#pragma mark 创建一个UILabel
- (UILabel *)labelWithFontSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] init];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:size];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor lightGrayColor];
    return label;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (!_hasOriginalInset) {
        self.scrollViewOriginalInset = _scrollView.contentInset;
        self.hasOriginalInset = YES;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //?????
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        _state = XZHRefreshStateDraging;//默认状态
        //label
        _statusLabel = [self labelWithFontSize:StatusLabelSize];
        [self addSubview:_statusLabel];
        //方向箭头
        _directionImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        _directionImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_directionImage];
        //指示器
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [self addSubview:_activityView];
        
    }
    return self;
}



- (void)setFrame:(CGRect)frame {
    frame.size.height = XZHRefreshViewHeight;
    [super setFrame:frame];
    
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    if (w == 0) {
        return;
    }
    CGFloat statusX = 0;
    CGFloat statusY = 5;
    CGFloat statusHeight = 20;
    CGFloat statusWidth = w;
    // 1.状态标签
    _statusLabel.frame = CGRectMake(statusX, statusY, statusWidth, statusHeight);
    
    // 2.箭头
    CGFloat arrowX = w * 0.35;
    _directionImage.center = CGPointMake(arrowX, h * 0.5);
    
    // 3.指示器
    _activityView.bounds = _directionImage.bounds;
    _activityView.center = _directionImage.center;
    
    
}

- (void)setBounds:(CGRect)bounds {
    bounds.size.height = XZHRefreshViewHeight;
    [super setBounds:bounds];
}


- (void)setStatusLabelText {
    switch (_state) {
        case XZHRefreshStateDraging:
            _statusLabel.text = _dragText;
            break;
        case XZHRefreshStateLetOffRefreshing:
            _statusLabel.text = _letOffText;
            break;
        case XZHRefreshStateRefreshing:
            _statusLabel.text = _refreshingText;
            break;
            
        default:
            break;
    }
}

#pragma mark 设置状态

- (void)setState:(XZHRefreshState)state {
    
    // 1.一样的就直接返回
    if (self.state == state) return;
    
    // 2.根据状态执行不同的操作
    switch (state) {
        case XZHRefreshStateNormal: // 普通状态
        {
            // 显示箭头
            self.directionImage.hidden = NO;
            // 停止转圈圈
            [self.activityView stopAnimating];
            
            // 说明是刚刷新完毕 回到 普通状态的
            if (XZHRefreshStateRefreshing == self.state) {
                //刷新完毕
                _directionImage.transform = CGAffineTransformIdentity;
                
                [UIView animateWithDuration:animateDuration animations:^{
                    
                    UIEdgeInsets inset = self.scrollView.contentInset;
                    inset.top -=  self.height;
                    self.scrollView.contentInset = inset;
                    
                }];
                
                
            } else {
                // 执行动画
                [UIView animateWithDuration:animateDuration animations:^{
                    _directionImage.transform = CGAffineTransformIdentity;
                }];
            }
            
        }
            break;
            
        case XZHRefreshStateLetOffRefreshing:
        {
            // 执行动画
            [UIView animateWithDuration:animateDuration animations:^{
                _directionImage.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
            
        case XZHRefreshStateRefreshing:
        {
            // 开始转圈
            [self.activityView startAnimating];
            // 隐藏箭头
            self.directionImage.hidden = YES;
            self.directionImage.transform = CGAffineTransformIdentity;
            // 执行动画
            [UIView animateWithDuration:animateDuration animations:^{
                // 1.增加滚动区域
                CGFloat top = self.scrollViewOriginalInset.top + self.height;
                UIEdgeInsets inset = self.scrollView.contentInset;
                inset.top = top;
                self.scrollView.contentInset = inset;
                
                // 2.设置滚动位置
                //                CGPoint offset = self.scrollView.contentOffset;
                //                offset.y = - top;
                //                self.scrollView.contentOffset = offset;
                
            }];
            
            //开始刷新
            // 回调
            if ([self.beginRefreshingTaget respondsToSelector:self.beginRefreshingAction]) {
                ((void (*)(void *, SEL, UIView *))objc_msgSend)((__bridge void *)(self.beginRefreshingTaget), self.beginRefreshingAction, self);
                
            }
            
        }
            
            break;
        case XZHRefreshStateDraging:
        {
            if (_state == XZHRefreshStateLetOffRefreshing) {
                // 执行动画  转换一下方向
                [UIView animateWithDuration:animateDuration animations:^{
                    _directionImage.transform = CGAffineTransformIdentity;
                }];
            }
            
        }
            break;
        default:
            break;
    }
    
    // 3.存储状态
    _state = state;
    
    [self setStatusLabelText];
}


#pragma mark 设置状态

- (void)beginRefresh {
    if (self.state == XZHRefreshStateRefreshing) {
        //已经是刷新状态 不执行刷新动作， 执行下刷新方法
        ((void (*)(void *, SEL, UIView *))objc_msgSend)((__bridge void *)(self.beginRefreshingTaget), self.beginRefreshingAction, self);
        return;
    }
    self.state = XZHRefreshStateRefreshing;
    
}
- (void)endRefresh {
    self.state = XZHRefreshStateNormal;
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
