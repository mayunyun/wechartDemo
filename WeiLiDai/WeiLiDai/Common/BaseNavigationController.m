//
//  BaseNavigationController.m
//  WeiLiDai
//
//  Created by j on 2017/12/18.
//  Copyright © 2017年 j. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = [[UIImage imageNamed:@"发现导航"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];//
    //去掉透明后导航栏下边的黑边
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
//    self.navigationBar.tintColor = [UIColor blackColor];
    //2.去掉底部线条
//    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
//    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -StatusBarHeight, SCREEN_WIDTH, NavigationBarHeight + StatusBarHeight)];
//    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
//    [self.navigationBar addSubview:bgView];
}



//只保证调用一次

+(void)initialize{
    
    if (self == [BaseNavigationController class]) {
        //设置所有的导航的背景颜色
        UINavigationBar  *bar = [UINavigationBar appearance];
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
            bar.barStyle = UIBarStyleBlack;
//            bar.barStyle = UIBarStyleDefault;
            bar.translucent = YES;
            bar.barTintColor = [UIColor blackColor];
//            bar.barTintColor = baseViewVCBG;
//            bar.backgroundColor = [UIColor blackColor];
//            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            //设置全局状态栏字体颜色为黑色
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            NSDictionary *dict =@{NSForegroundColorAttributeName:[UIColor whiteColor]
                                  };
            [bar setTitleTextAttributes:dict];
            //设置主题
            [bar setTintColor:[UIColor blackColor]];
            /**
             解决tabbar布局错乱
             只要 UITabBar 是磨砂的，并且 push viewController 时 hidesBottomBarWhenPushed = YES 则手势返回的时候就会触发，出现这个现象的直接原因是 tabBar 内的按钮 UITabBarButton 被设置了错误的 frame，frame.size 变为 (0, 0) 导致的。
             ---------------------
             作者：龙哥_love
             来源：CSDN
             原文：https://blog.csdn.net/longge_li/article/details/83654333
             版权声明：本文为博主原创文章，转载请附上博文链接！
             */
            [UITabBar appearance].translucent = NO;
            //隐藏系统自带返回按钮的文字
//            [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
        }
    }
}

//- (void)viewDidLayoutSubviews {
//    
//    [super viewDidLayoutSubviews];
//    
//    CGRect frame = self.navigationBar.frame;
//    
//    frame.size.height = 50;
//    
//    self.navigationBar.frame = frame;
//    
//    self.navigationBar.backgroundColor = ColorWithRGB(249, 249, 249, 1);
//    
//    self.navigationBar.barStyle = UIBarStyleDefault;
//    
//    //此处需要设置barStyle，否则颜色会分成上下两层
//    
//}

@end
