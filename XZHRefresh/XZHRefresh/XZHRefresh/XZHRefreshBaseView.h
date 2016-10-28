//
//  XZHRefreshBaseView.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/3.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XZHRefreshBaseView;
/**
 控件状态
 */
typedef enum {
    XZHRefreshStateDraging = 1, // 拖拽
    XZHRefreshStateNormal,   // 普通状态
    XZHRefreshStateRefreshing,//刷新中……
    XZHRefreshStateLetOffRefreshing//松开就可以进行刷新的状态
    
} XZHRefreshState;





@interface XZHRefreshBaseView : UIView
//刷新控件添加到scrollView
@property (nonatomic, weak) UIScrollView *scrollView;
/**
 *  开始进入刷新状态的监听器
 */
@property (weak, nonatomic) id beginRefreshingTaget;
/**
 *  开始进入刷新状态的监听方法
 */
@property (assign, nonatomic) SEL beginRefreshingAction;


@property (nonatomic) XZHRefreshState state;
@property (nonatomic, readonly) BOOL isRefreshing;
/**
 *  视图
 */

@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIImageView *directionImage;//下拉上拉方向
@property (nonatomic, strong) UIActivityIndicatorView *activityView;;
@property (nonatomic) UIEdgeInsets scrollViewOriginalInset;
@property (nonatomic) BOOL hasOriginalInset;

/*
 刷新文字
 */
 @property (copy, nonatomic) NSString *dragText; // 下拉可以刷新
 @property (copy, nonatomic) NSString *letOffText; // 松开立即刷新
 @property (copy, nonatomic) NSString *refreshingText; // 正在帮你刷新...

- (void)setStatusLabelText;
- (void)beginRefresh;
//- (void)endRefresh;
//结束时释放资源
- (void)free;
/**
 交给子类去实现 和 调用
 */
//- (void)setState:(XZHRefreshState)state;
//- (int)totalDataCountInScrollView;

@end

