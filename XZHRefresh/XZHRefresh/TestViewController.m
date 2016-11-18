//
//  TestViewController.m
//  XZHRefresh
//
//  Created by gonghuiiOS on 16/11/2.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /*
     基本思路：
     
     通过贝塞尔曲线画一条半边圆角的路径
     
     将该路径作为CAShapeLayer的path
     
     将该CAShapeLayer作为视图的mask
     
     通过贝塞尔曲线画一条半边圆角的路径
     
     + (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii
     该方法会接受三个参数
     
     rect : 传控件的bounds
     
     corners : 圆角的位置 ，该值为枚举类型。指定圆角的位置，可以分别设置左上 、左下、右上、右下。并且可以同时指定，如左上和左下，即示例图中半边圆角效果 。 UIRectCornerBottomRight : 右下角 ...
     
     cornerRadii : 圆角大小
     */

    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 300)];
    view.image = [UIImage imageNamed:@"111.jpg"];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(200/2, 200/2)];
    
    // 初始化一个CAShapeLayer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    // 将曲线路径设置为layer的路径
    maskLayer.path = path.CGPath;
    
    // 设置控件的mask为CAShapeLayer
    view.layer.mask = maskLayer;
    [self.view addSubview:view];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
