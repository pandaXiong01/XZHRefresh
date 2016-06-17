//
//  XZHRefreshView.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/6.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef enum {
//    RefreshStateBeginRefreshing,//开始刷新
//    RefreshStateEndRefreshing//结束刷新
//    
//} RefreshState;
typedef enum {
    MJRefreshStatePulling = 1, // 松开就可以进行刷新的状态
    MJRefreshStateNormal = 2, // 普通状态
    MJRefreshStateRefreshing = 3, // 正在刷新中的状态
    MJRefreshStateWillRefreshing = 4
} MJRefreshState;

/**
 控件类型
 */
typedef enum {
    RefreshHeaderType,
    RefreshFooterType
} RefreshViewType;

@interface XZHRefreshView : UIView
@property (weak, nonatomic) id refreshingTarget;
@property (assign, nonatomic) SEL refreshingAction;
/** 记录scrollView刚开始的inset */
@property (assign, nonatomic) UIEdgeInsets scrollViewOriginalInset;
/** 父控件 */
@property (nonatomic, weak) UIScrollView *scrollView;
//@property (nonatomic, weak) UILabel *lastUpdateTimeLabel;
//@property (nonatomic, weak) UILabel *statusLabel;
//@property (nonatomic, weak) UIImageView *arrowImage;
//@property (nonatomic, weak) UIActivityIndicatorView *activityView;


- (void)addRefreshTarget:(id)target action:(SEL)action;

+ (XZHRefreshView *)refreshViewAtScrollView:(UIScrollView *)scrollView WithType:(RefreshViewType)type;

/** 进入刷新状态 */
- (void)beginRefreshing;
/** 结束刷新状态 */
- (void)endRefreshing;
/** 是否正在刷新 */
- (BOOL)isRefreshing;

@end
