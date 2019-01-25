//
//  XZJBaseViewController.h
//  HuaShiJinFu
//
//  Created by iMac on 2017/9/8.
//  Copyright © 2017年 FangLian. All rights reserved.
//

#import "BaseViewController.h"
#import "UITabBar+badge.h"
#import "XZJBottomBtnsView.h"
#import "BaseTabBarViewController.h"

@interface XZJBaseViewController : BaseViewController

@property (nonatomic, strong) BaseTabBarViewController * tabbar;
@property (nonatomic, strong) XZJBottomBtnsView * btnsView;


+(XZJBaseViewController *)sharedBaseViewController;

@end
