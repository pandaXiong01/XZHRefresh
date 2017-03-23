//
//  XZHRefreshGeneralHeaderView.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/12/2.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshHeaderView.h"

@interface XZHRefreshGeneralHeaderView : XZHRefreshHeaderView
/*
 刷新文字
 */
@property (copy, nonatomic) NSString *dragText; // 下拉可以刷新
@property (copy, nonatomic) NSString *letOffText; // 松开立即刷新
@property (copy, nonatomic) NSString *refreshingText; // 正在帮你刷新...


@end
