//
//  XZHRefreshGeneralHeaderView.m
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/12/2.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshGeneralHeaderView.h"

@interface XZHRefreshGeneralHeaderView ()
/**
 *  视图
 */

@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIImageView *directionImage;//下拉上拉方向
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end
@implementation XZHRefreshGeneralHeaderView
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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        //TODO 这个移动
        self.state = XZHRefreshStateDraging;//默认状态
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
        //默认刷新提示词
        _dragText = XZHRefreshHeaderDragText;
        _letOffText = XZHRefreshHeaderLetOffText;
        _refreshingText = XZHRefreshHeaderRefreshingText;
        
        [self addSubview:_activityView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupSubviews];
}
- (void)setupSubviews {
    
    CGFloat w = self.xzh_width;
    CGFloat h = self.xzh_height;
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





- (void)setState:(XZHRefreshState)state {
    //这里调整视图控件的状态
    XZHRefreshState oldState = self.state;
    if (state == oldState) return;
    [super setState:state];
    
    // 2.根据状态执行不同的操作
    switch (state) {
        case XZHRefreshStateNormal: // 普通状态
        {
            // 显示箭头
            self.directionImage.hidden = NO;
            // 停止转圈圈
            [self.activityView stopAnimating];
            
            // 说明是刚刷新完毕 回到 普通状态的
            if (XZHRefreshStateRefreshing == oldState) {
                //刷新完毕
                _directionImage.transform = CGAffineTransformIdentity;
                
            } else {
                // 执行动画
                [UIView animateWithDuration:XZHRefreshAnimationDuration animations:^{
                    _directionImage.transform = CGAffineTransformIdentity;
                }];
            }
            
        }
            break;
            
        case XZHRefreshStateLetOffRefreshing:
        {
            // 执行动画
            [UIView animateWithDuration:XZHRefreshAnimationDuration animations:^{
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
           
        }
            
            break;
        case XZHRefreshStateDraging:
        {
            if (XZHRefreshStateLetOffRefreshing == oldState) {
                // 执行动画  转换一下方向
                [UIView animateWithDuration:XZHRefreshAnimationDuration animations:^{
                    _directionImage.transform = CGAffineTransformIdentity;
                }];
            }
            
        }
            break;
        default:
            break;
    }
    
    
    
    [self setStatusLabelText];
    
}


- (void)setStatusLabelText {
    switch (self.state) {
        case XZHRefreshStateDraging:
            _statusLabel.text = _dragText;
            break;
        case XZHRefreshStateLetOffRefreshing:
            _statusLabel.text = _letOffText;
            break;
        case XZHRefreshStateRefreshing:
            _statusLabel.text = _refreshingText;
            break;
        case XZHRefreshStateNormal:
            _statusLabel.text = _dragText;
            break;
        default:
            break;
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
