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
    XZHRefreshStatePulling = 1, // 松开就可以进行刷新的状态
    XZHRefreshStateNormal,   // 普通状态/拖拽
    XZHRefreshStateRefreshing,//刷新中……
    XZHRefreshStateWillRefreshing//
    
} XZHRefreshState;
/**
 控件类型
 */
typedef enum {
    XZHRefreshHeaderType = -1,
    XZHRefreshFooterType = 1
    
} XZHRefreshViewType;


/**
 *  Block回调
 */
typedef void (^BeginRefreshBlock)(XZHRefreshBaseView *refreshView);
typedef void (^EndRefreshBlock)(XZHRefreshBaseView *refreshView);
typedef void (^RefreshStateChangeBlock)(XZHRefreshBaseView *refreshView, XZHRefreshState state);

/**
 *  协议代理
 */
@protocol XZHRefreshBaseViewDelegate <NSObject>

- (void)refreshViewBeginRefresh:(XZHRefreshBaseView *)refreshView;
- (void)refreshViewEndRefresh:(XZHRefreshBaseView *)refreshView;
- (void)refreshView:(XZHRefreshBaseView *)refreshView changeState:(XZHRefreshState)state;
@end



@interface XZHRefreshBaseView : UIView

@property (nonatomic, weak) UIScrollView *scrollView;
/**
 *  block回调
 */
@property (nonatomic, copy) BeginRefreshBlock beginRefreshBlock;
@property (nonatomic, copy) EndRefreshBlock endRefreshBlock;
@property (nonatomic, copy) RefreshStateChangeBlock stateChangeBlock;
@property (nonatomic, weak) id<XZHRefreshBaseViewDelegate>delegate;
@property (nonatomic) XZHRefreshViewType refreshType;
@property (nonatomic) XZHRefreshState state;
@property (nonatomic, readonly) BOOL isRefreshing;
/**
 *  视图
 */
@property (nonatomic, strong) UILabel *lastUpdateTimeLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIImageView *directionImage;//下拉上拉方向
@property (nonatomic, strong) UIActivityIndicatorView *activityView;;
@property (nonatomic) UIEdgeInsets scrollViewOriginalInset;
@property (nonatomic) BOOL hasOriginalInset;

- (void)beginRefresh;
- (void)endRefresh;
//结束时释放资源
- (void)free;
/**
 交给子类去实现 和 调用
 */
//- (void)setState:(XZHRefreshState)state;
//- (int)totalDataCountInScrollView;

@end

