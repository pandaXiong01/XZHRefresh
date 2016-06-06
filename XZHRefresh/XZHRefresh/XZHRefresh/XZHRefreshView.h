//
//  XZHRefreshView.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/6.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    RefreshStateBeginRefreshing,//开始刷新
    RefreshStateEndRefreshing//结束刷新
    
} RefreshState;

/**
 控件类型
 */
typedef enum {
    RefreshHeaderType,
    RefreshFooterType
} RefreshViewType;

@interface XZHRefreshView : UIView

- (void)addRefreshTarget:(id)target action:(SEL)action forRefreshState:(RefreshState)state;


+ (XZHRefreshView *)refreshViewWithType:(RefreshViewType)type;

@end
