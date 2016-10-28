//
//  XZHRefreshFooterView.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/6/3.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshBaseView.h"

@interface XZHRefreshFooterView : XZHRefreshBaseView
/**
 *  设置尾部控件的文字
 */
@property (copy, nonatomic) NSString *footerDragText;//上拉可以加载更多数据
@property (copy, nonatomic) NSString *footerLetOffText;//松开立即加载更多数据
@property (copy, nonatomic) NSString *footerRefreshingText;//正在帮你加载数据...


+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;
@end
