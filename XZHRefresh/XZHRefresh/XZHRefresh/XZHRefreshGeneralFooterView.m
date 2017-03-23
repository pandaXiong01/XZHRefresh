//
//  XZHRefreshGeneralFooterView.m
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/10/31.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshGeneralFooterView.h"


@interface XZHRefreshGeneralFooterView ()
@property (nonatomic, weak) UIActivityIndicatorView *activityView;

/** 显示状态文字的标签 */
@property (weak, nonatomic) UILabel *stateLabel;

/** 没有更多的数据 */
@property (weak, nonatomic) UILabel *noMoreLabel;

@end
@implementation XZHRefreshGeneralFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_activityView = activityView];
    }
    return _activityView;
}

- (UILabel *)noMoreLabel {
    if (!_noMoreLabel) {
        UILabel *noMoreLabel = [[UILabel alloc] init];
        noMoreLabel.backgroundColor = [UIColor clearColor];
        noMoreLabel.textAlignment = NSTextAlignmentCenter;
        noMoreLabel.font = [UIFont boldSystemFontOfSize:StatusLabelSize];
        noMoreLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_noMoreLabel = noMoreLabel];
    }
    return _noMoreLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        UILabel *stateLabel = [[UILabel alloc] init];
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.textAlignment = NSTextAlignmentCenter;
        stateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        stateLabel.font = [UIFont boldSystemFontOfSize:StatusLabelSize];
        stateLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_stateLabel = stateLabel];
    }
    return _stateLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _footerRefreshingText = XZHRefreshFooterRefreshing;
        _footerNoMoreDataText = XZHRefreshFooterNoData;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupSubviews];
}
- (void)setupSubviews {
    
    self.noMoreLabel.frame = self.bounds;
    
    self.stateLabel.frame = self.bounds;
    _stateLabel.hidden = YES;
    _stateLabel.text = _footerRefreshingText;
    self.activityView.frame = CGRectMake(0, 0, 30, 30);
    _activityView.center = CGPointMake(self.xzh_width * 0.3, self.xzh_height *0.5);
    
}
- (void)setState:(XZHRefreshState)state {
    //这里调整视图控件的状态
    XZHRefreshState oldState = self.state;
    if (state == oldState) return;
    [super setState:state];
    
    switch (state) {
        case XZHRefreshStateRefreshing:
        {
            [_activityView startAnimating];
            self.noMoreLabel.hidden = YES;
            self.stateLabel.hidden = NO;
            
        }
            break;
        case XZHRefreshStateNormal:
        {
            //闲置状态 最下面也是没有更多数据
            [_activityView stopAnimating];
            self.noMoreLabel.hidden = NO;
            self.stateLabel.hidden = YES;
        }
            break;
        case XZHRefreshStateNoMoreData:
        {
            [_activityView stopAnimating];
            self.noMoreLabel.hidden = NO;
            self.stateLabel.hidden = YES;
        }
            break;
            
        default:
            break;
    }

    [self setStateLabelText];
    
}
- (void)setStateLabelText {
    switch (self.state) {
        case XZHRefreshStateNormal:
            _noMoreLabel.text = _footerNoMoreDataText;
            break;
        case XZHRefreshStateNoMoreData:
            _noMoreLabel.text = _footerNoMoreDataText;
            break;
        case XZHRefreshStateRefreshing:
            _stateLabel.text = _footerRefreshingText;
            break;
            
        default:
            break;
    }
}

@end
