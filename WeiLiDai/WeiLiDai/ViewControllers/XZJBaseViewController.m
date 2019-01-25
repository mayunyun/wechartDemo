//
//  XZJBaseViewController.m
//  HuaShiJinFu
//
//  Created by iMac on 2017/9/8.
//  Copyright © 2017年 FangLian. All rights reserved.
//

#import "XZJBaseViewController.h"
#import "BaseNavigationController.h"
#import "AppDelegate.h"
#import "MineViewController.h"
#import "TimeLineViewController.h"
#import "ContactsViewController.h"
#import "MessageViewController.h"

//两次提示的默认间隔
//static const CGFloat kDefaultPlaySoundInterval = 3.0;
//static NSString *kMessageType = @"MessageType";
//static NSString *kConversationChatter = @"ConversationChatter";
//static NSString *kGroupName = @"GroupName";

@interface XZJBaseViewController ()<UITabBarControllerDelegate>

@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@end

@implementation XZJBaseViewController

+(XZJBaseViewController *)sharedBaseViewController{
    static XZJBaseViewController * baseVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseVC = [[XZJBaseViewController alloc] init];
    });
    return baseVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //if 使tabBarController中管理的viewControllers都符合 UIRectEdgeNone
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout: UIRectEdgeNone];
    }
    [self goMain];
    
}

-(void)goMain{
    //设置根视图
    AppDelegate * appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.window.rootViewController = self.tabbar;
    
    UIApplication *ap = [UIApplication sharedApplication];
    [[ap.windows lastObject] addSubview:self.btnsView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    int tabIndex = 0;
    NSString * unreadCount = nil;
    BOOL haveUnreadPoint = NO;
    if (![viewController.title isEqualToString:@"我"]){
        
        if ([viewController.title isEqualToString:@"微信"]) {
            self.tabbar.selectedIndex = 0;
//            tabIndex = 0;
//            unreadCount = cingleTon.unreadHomeCount;
//            haveUnreadPoint = cingleTon.haveUnreadHomePoint;
//            UIAlertController * alertT = [FactryFucClass showDoubleBtnWithTextFieldAlertControllerWithTitle:@"修改未读消息数"
//                                                                                                    Message:nil
//                                                                                               doneBtnTitle:nil
//                                                                                             cancelBtnTitle:nil
//                                                                                              textFieldText:unreadCount
//                                                                                      textFieldKeyboardType:UIKeyboardTypeNumberPad
//                                                                                               andDoneBlock:^(UIAlertAction * _Nonnull action, NSArray<UITextField *> * _Nullable textFields) {
//                                                                                                   UITabBarItem * item1 = [self.tabbar.tabBar.items objectAtIndex:tabIndex];
//                                                                                                   UITextField * textfield = [textFields firstObject];
//                                                                                                   if (textfield.text.length > 2) {
//                                                                                                       item1.badgeValue = @"...";
//                                                                                                   }
//                                                                                                   else if ([textfield.text isEqualToString:@"0"]||textfield.text.length == 0){
//                                                                                                       item1.badgeValue = nil;
//                                                                                                   }
//                                                                                                   else{
//                                                                                                       item1.badgeValue = textfield.text;
//                                                                                                   }
//
//                                                                                                   switch (tabIndex) {
//                                                                                                       case 0:{
//                                                                                                           cingleTon.unreadHomeCount = textfield.text;
//                                                                                                           cingleTon.haveUnreadHomePoint = NO;
//                                                                                                       }
//                                                                                                           break;
//                                                                                                       case 1:{
//                                                                                                           cingleTon.unreadWealthCount = textfield.text;
//                                                                                                           cingleTon.haveUnreadWealthPoint = NO;
//                                                                                                       }
//                                                                                                           break;
//                                                                                                       case 2:{
//                                                                                                           cingleTon.unreadPraiseCount = textfield.text;
//                                                                                                           cingleTon.haveUnreadPraisePoint = NO;
//                                                                                                       }
//                                                                                                           break;
//                                                                                                       case 3:{
//                                                                                                           cingleTon.unreadFriendCount = textfield.text;
//                                                                                                           cingleTon.haveUnreadFriendPoint = NO;
//                                                                                                       }
//                                                                                                           break;
//
//                                                                                                       default:
//                                                                                                           break;
//                                                                                                   }
//                                                                                               }
//                                                                                             andCancelBlock:^(UIAlertAction * _Nonnull action) {
//
//                                                                                             }];
//            [self.tabbar presentViewController:alertT animated:YES completion:^{
//
//            }];
        }
        else if ([viewController.title isEqualToString:@"通讯录"]) {
            tabIndex = 1;
            self.tabbar.selectedIndex = 1;
//            unreadCount = cingleTon.unreadWealthCount;
//            haveUnreadPoint = cingleTon.haveUnreadWealthPoint;
//            if (haveUnreadPoint) {
//                cingleTon.haveUnreadWealthPoint = NO;
//                [self.tabbar.tabBar hideBadgeOnItemIndex:tabIndex];
//            }
//            else{
//                cingleTon.haveUnreadWealthPoint = YES;
//                [self.tabbar.tabBar showBadgeOnItemIndex:tabIndex];
//            }
        }
        else if ([viewController.title isEqualToString:@"发现"]){
            self.tabbar.selectedIndex = 2;
//            tabIndex = 2;
//            unreadCount = cingleTon.unreadFriendCount;
//            haveUnreadPoint = cingleTon.haveUnreadFriendPoint;
//            if (haveUnreadPoint) {
//                cingleTon.haveUnreadFriendPoint = NO;
//                [self.tabbar.tabBar hideBadgeOnItemIndex:tabIndex];
//            }
//            else{
//                cingleTon.haveUnreadFriendPoint = YES;
//                [self.tabbar.tabBar showBadgeOnItemIndex:tabIndex];
//            }
        }
//       {
//            tabIndex = 2;
////            unreadCount = cingleTon.unreadPraiseCount;
////            haveUnreadPoint = cingleTon.haveUnreadPraisePoint;
////            if (haveUnreadPoint) {
////                cingleTon.haveUnreadPraisePoint = NO;
////                [self.tabbar.tabBar hideBadgeOnItemIndex:tabIndex];
////            }
////            else{
////                cingleTon.haveUnreadPraisePoint = YES;
////                [self.tabbar.tabBar showBadgeOnItemIndex:tabIndex];
////            }
//
//            //隐藏
//            UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"设置按钮上的未读消息数" preferredStyle:UIAlertControllerStyleActionSheet];
//            UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//            }];
//            weakify(self);
//            UIAlertAction * okAction2 = [UIAlertAction actionWithTitle:@"未读消息数" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [weakSelf.tabbar.tabBar hideBadgeOnItemIndex:tabIndex];
//                UIAlertController * alertT = [FactryFucClass showDoubleBtnWithTextFieldAlertControllerWithTitle:@"修改未读消息数"
//                                                                                                         Message:nil
//                                                                                                    doneBtnTitle:nil
//                                                                                                  cancelBtnTitle:nil
//                                                                                                   textFieldText:unreadCount
//                                                                                           textFieldKeyboardType:UIKeyboardTypeNumberPad
//                                                                                                    andDoneBlock:^(UIAlertAction * _Nonnull action, NSArray<UITextField *> * _Nullable textFields) {
//                                                                                                        UITabBarItem * item1 = [weakSelf.tabbar.tabBar.items objectAtIndex:tabIndex];
//                                                                                                        UITextField * textfield = [textFields firstObject];
//                                                                                                        if (textfield.text.length > 2) {
//                                                                                                            item1.badgeValue = @"...";
//                                                                                                        }
//                                                                                                        else{
//                                                                                                            item1.badgeValue = textfield.text;
//                                                                                                        }
//
//                                                                                                        cingleTon.unreadPraiseCount = textfield.text;
//                                                                                                        cingleTon.haveUnreadPraisePoint = NO;
//                                                                                                    }
//                                                                                                  andCancelBlock:^(UIAlertAction * _Nonnull action) {
//
//                                                                                                  }];
//                [weakSelf.tabbar presentViewController:alertT animated:YES completion:^{
//
//                }];
//
//            }];
//            UIAlertAction * okAction3 = [UIAlertAction actionWithTitle:@"消息提醒(小圆点)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [weakSelf.tabbar.tabBar showBadgeOnItemIndex:tabIndex];
//                UITabBarItem * item1 = [weakSelf.tabbar.tabBar.items objectAtIndex:tabIndex];
//                item1.badgeValue = nil;
//                cingleTon.unreadPraiseCount = nil;
//                cingleTon.haveUnreadPraisePoint = YES;
//            }];
//            UIAlertAction * okAction4 = [UIAlertAction actionWithTitle:@"还原" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [weakSelf.tabbar.tabBar hideBadgeOnItemIndex:tabIndex];
//                UITabBarItem * item1 = [weakSelf.tabbar.tabBar.items objectAtIndex:tabIndex];
//                item1.badgeValue = nil;
//                cingleTon.unreadPraiseCount = nil;
//                cingleTon.haveUnreadPraisePoint = NO;
//            }];
//
//            [alert addAction:okAction];
//            [alert addAction:okAction2];
//            [alert addAction:okAction3];
//            [alert addAction:okAction4];
//            [self.tabbar presentViewController:alert animated:YES completion:^{
//
//            }];
//        }
        return NO;
    }
    else{
        _tabbar.selectedIndex = 3;
//        tabIndex = 3;
//        unreadCount = cingleTon.unreadFriendCount;
//        haveUnreadPoint = cingleTon.haveUnreadFriendPoint;
//        if (haveUnreadPoint) {
//            cingleTon.haveUnreadFriendPoint = NO;
//            [self.tabbar.tabBar hideBadgeOnItemIndex:tabIndex];
//        }
//        else{
//            cingleTon.haveUnreadFriendPoint = YES;
//            [self.tabbar.tabBar showBadgeOnItemIndex:tabIndex];
//        }
    }
    return YES;
}

#pragma mark - 懒加载
-(UITabBarController *)tabbar{
    if (!_tabbar) {
        MessageViewController * messageVC = [[MessageViewController alloc] init];
        ContactsViewController  * contactVC = [[ContactsViewController alloc] init];
        TimeLineViewController * timeLineVC = [[TimeLineViewController alloc] init];
        MineViewController * mineVC = [[MineViewController alloc] init];
//
        _tabbar = [[BaseTabBarViewController alloc] init];
        _tabbar.delegate = self;
        NSArray * vcArray            = @[messageVC,contactVC,timeLineVC,mineVC];
        NSArray * titleArray         = @[@"微信",@"通讯录",@"发现",@"我"];
//        NSArray * imageArray         = @[@"tabbar_mainframe",@"tabbar_contacts",@"tabbar_discover",@"tabbar_me"];
//        NSArray * selectedImageArray = @[@"tabbar_mainframeHL",@"tabbar_contactsHL",@"tabbar_discoverHL",@"tabbar_meHL"];
        NSArray * imageArray         = @[@"微信",@"通讯录",@"发现",@"我"];
        NSArray * selectedImageArray = @[@"选中微信",@"选中通讯录",@"选中发现",@"选中我"];
        int i = 0;
        NSMutableArray * controllers = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (UIViewController * vc in vcArray) {
            BaseNavigationController * navC = [[BaseNavigationController alloc] initWithRootViewController:vc];
            vc.tabBarItem.image            = [[UIImage imageNamed:[imageArray objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            vc.tabBarItem.selectedImage    = [[UIImage imageNamed:[selectedImageArray objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            vc.title                       = [titleArray objectAtIndex:i];
            [navC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:tabbarSelectedColor, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
            [navC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:tabbarDefaultColor, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
            [controllers addObject:navC];
            i++;
        }
        _tabbar.viewControllers = controllers;
        _tabbar.selectedIndex = 3;
    }
    return _tabbar;
}

-(XZJBottomBtnsView *)btnsView{
    if (!_btnsView) {
        _btnsView = [[XZJBottomBtnsView alloc] init];
        [_btnsView hideView];
    }
    return _btnsView;
}

@end
