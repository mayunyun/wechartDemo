//
//  BaseViewController.h
//  WeiLiDai
//
//  Created by j on 2017/12/18.
//  Copyright © 2017年 j. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView * bgView;

-(void)showBGView;

-(void)hideBGView;

- (void)showBack;

- (void)hideBack;

@end
