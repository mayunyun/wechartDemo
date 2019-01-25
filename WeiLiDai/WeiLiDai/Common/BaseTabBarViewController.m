//
//  BaseTabBarViewController.m
//  WeiLiDai
//
//  Created by LONG on 2019/1/8.
//  Copyright © 2019年 j. All rights reserved.
//

#import "BaseTabBarViewController.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 10.0, *)) {
        self.tabBarItem.badgeColor = ColorWithRGB(250, 81, 80, 1);
    } else {
        // Fallback on earlier versions
    }
    
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    CGRect frame = self.tabBar.frame;
    
    frame.size.height = 55;
    
    frame.origin.y = self.view.frame.size.height - frame.size.height;
    
    self.tabBar.frame = frame;
    
    self.tabBar.backgroundColor = ColorWithRGB(249, 249, 249, 1);
    
    self.tabBar.barStyle = UIBarStyleDefault;
    
    //此处需要设置barStyle，否则颜色会分成上下两层
    
}

@end
