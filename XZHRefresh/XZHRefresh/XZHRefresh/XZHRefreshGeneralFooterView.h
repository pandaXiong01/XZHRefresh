//
//  XZHRefreshGeneralFooterView.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/10/31.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHRefreshFooterView.h"

@interface XZHRefreshGeneralFooterView : XZHRefreshFooterView
/**
 *  设置尾部控件的文字
 */
@property (copy, nonatomic) NSString *footerRefreshingText;//正在帮你加载数据...
@property (copy, nonatomic) NSString *footerNoMoreDataText;//没有更多数据提醒
@end
