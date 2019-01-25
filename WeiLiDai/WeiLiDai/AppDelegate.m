//
//  AppDelegate.m
//  WeiLiDai
//
//  Created by j on 2017/12/18.
//  Copyright © 2017年 j. All rights reserved.
//

#import "AppDelegate.h"
#import "XZJMyWalletViewController.h"
#import "BaseNavigationController.h"
#import "NSObject+LBLaunchImage.h"
#import "ShowAlertBGView.h"
#import "XZJBaseViewController.h"

@interface AppDelegate ()<ShowAlertBGViewDelegate>

@property (nonatomic, strong) XZJMyWalletViewController * myWVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window                    = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor    = [UIColor whiteColor];
    XZJBaseViewController * baseVC = [XZJBaseViewController sharedBaseViewController];
    self.window.rootViewController = baseVC;
    [self.window makeKeyAndVisible];
    
    /* FullScreenAdType 全屏广告
     * LogoAdType 带logo的广告类似网易广告，值得注意的是启动图片必须带logo图
     * localAdImgName  本地图片名字
     */
//    __weak typeof(self) weakSelf = self;
    [NSObject makeLBLaunchImageAdView:^(LBLaunchImageAdView *imgAdView) {
        
        //设置广告的类型
        imgAdView.getLBlaunchImageAdViewType(FullScreenAdType);
        
        //设置本地启动图片
        imgAdView.localAdImgName = @"";
//        imgAdView.imgUrl = @"http://img.zcool.cn/community/01316b5854df84a8012060c8033d89.gif";
        //自定义跳过按钮
//        imgAdView.skipBtn.backgroundColor = [UIColor blackColor];
        //各种点击事件的回调
        
        ShowAlertBGView * alertBGView = [[ShowAlertBGView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        alertBGView.delegate = self;
        [baseVC.tabbar.view addSubview:alertBGView];
        
        imgAdView.clickBlock = ^(clickType type){
            switch (type) {
                case clickAdType:{
                    NSLog(@"点击广告回调");
//                    TestViewController *vc = [[TestViewController alloc]init];
//                    vc.view.backgroundColor = [UIColor whiteColor];
//                    [weakSelf.window.rootViewController presentViewController:vc animated:YES completion:^{
//
//                    }];
                    [alertBGView showView];
                }
                    break;
                case skipAdType:{
                    NSLog(@"点击跳过回调");
                    [alertBGView showView];
                }
                    break;
                case overtimeAdType:{
                    NSLog(@"倒计时完成后的回调");
                    [alertBGView showView];
                }
                    break;
                default:
                    break;
            }
        };
        
    }];
    
    return YES;
}

-(void)showAlertBGView:(ShowAlertBGView *)showAlertBGView newYuE:(CGFloat)yuE newBorrowCount:(NSUInteger)borrowCount{
    [self.myWVC resetMeney];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    int i = [[user objectForKey:openCountKey] intValue];
//    i++;
//    [user setObject:@(i) forKey:openCountKey];
//    if (i > openCount) {
////        self.window.rootViewController = [UIViewController new];
//        SingleTon * singleTon = [SingleTon sharedSingleTon];
//        singleTon.borrowCount = 100;
//    }
//    [user synchronize];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
