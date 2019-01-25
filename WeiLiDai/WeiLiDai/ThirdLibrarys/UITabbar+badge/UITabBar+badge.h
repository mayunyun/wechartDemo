//
//  UITabBar+badge.h
//  zhifubao
//
//  Created by iMac on 2018/3/23.
//  Copyright © 2018年 zhifubao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
