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

@implementation XZHRefreshView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (XZHRefreshView *)refreshViewWithType:(RefreshViewType)type {
    if (type == RefreshHeaderType) {
        return [XZHRefreshHeaderView header];
    } else if (type == RefreshFooterType) {
        return [XZHRefreshFooterView footer];
    } else {
        return nil;
    }
}

- (void)addRefreshTarget:(id)target action:(SEL)action forRefreshState:(RefreshState)state {
    //子类实现
}
@end
