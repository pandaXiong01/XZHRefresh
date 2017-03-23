//
//  XZHRefreshHeaderView.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/3.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshView.h"

@interface XZHRefreshHeaderView : XZHRefreshView


+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@end
