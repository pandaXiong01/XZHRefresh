//
//  UIView+XZHExtension.m
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/12/2.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "UIView+XZHExtension.h"

@implementation UIView (XZHExtension)
- (void)setXzh_x:(CGFloat)xzh_x {
    CGRect frame = self.frame;
    frame.origin.x = xzh_x;
    self.frame = frame;
}
- (void)setXzh_y:(CGFloat)xzh_y {
    CGRect frame = self.frame;
    frame.origin.y = xzh_y;
    self.frame = frame;
}

- (CGFloat)xzh_x {
    return self.frame.origin.x;
}
- (CGFloat)xzh_y {
    return self.frame.origin.y;
}


- (void)setXzh_width:(CGFloat)xzh_width {
    CGRect frame = self.frame;
    frame.size.width = xzh_width;
    self.frame = frame;
}
- (void)setXzh_height:(CGFloat)xzh_height {
    CGRect frame = self.frame;
    frame.size.height = xzh_height;
    self.frame = frame;
}

- (CGFloat)xzh_width {
    return self.frame.size.width;
}

- (CGFloat)xzh_height {
    return self.frame.size.height;
}

- (void)setXzh_size:(CGSize)xzh_size {
    CGRect frame = self.frame;
    frame.size = xzh_size;
    self.frame = frame;
}
- (CGSize)xzh_size {
    return self.frame.size;
}


- (void)setXzh_origin:(CGPoint)xzh_origin {
    CGRect frame = self.frame;
    frame.origin = xzh_origin;
    self.frame = frame;
}
- (CGPoint)xzh_origin {
    return self.frame.origin;
}


- (void)setXzh_centerX:(CGFloat)xzh_centerX {
    CGPoint center = self.center;
    center.x = xzh_centerX;
    self.center = center;
}
- (CGFloat)xzh_centerX {
    return self.xzh_centerX;
}



- (void)setXzh_centerY:(CGFloat)xzh_centerY {
    CGPoint center = self.center;
    center.y = xzh_centerY;
    self.center = center;
}
- (CGFloat)xzh_centerY {
    return self.center.y;
}


@end
