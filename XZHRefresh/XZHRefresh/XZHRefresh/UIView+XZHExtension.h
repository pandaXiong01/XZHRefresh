//
//  UIView+XZHExtension.h
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/12/2.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XZHExtension)
/*为避免与使用者 extension命名冲突，所以使用前缀
 */
@property (nonatomic, assign) CGFloat xzh_x;
@property (nonatomic, assign) CGFloat xzh_y;
@property (nonatomic, assign) CGFloat xzh_centerX;
@property (nonatomic, assign) CGFloat xzh_centerY;
@property (nonatomic, assign) CGFloat xzh_width;
@property (nonatomic, assign) CGFloat xzh_height;
@property (nonatomic, assign) CGSize xzh_size;
@property (nonatomic, assign) CGPoint xzh_origin;

@end
