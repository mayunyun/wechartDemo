//
//  ShowAlertBGView.h
//  WeiLiDai
//
//  Created by j on 2017/12/23.
//  Copyright © 2017年 j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowAlertView.h"

@class ShowAlertBGView;
@protocol ShowAlertBGViewDelegate <NSObject>
@required

/**
 用于重设高度
 
 @param showAlertBGView 视图自身
 @param yuE 钱包余额
 @param borrowCount 可借额度
 */
-(void)showAlertBGView:(ShowAlertBGView *)showAlertBGView newYuE:(CGFloat)yuE newBorrowCount:(NSUInteger)borrowCount;

@end

@interface ShowAlertBGView : UIView<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;

@property (nonatomic, strong) ShowAlertView * alertView;

@property (nonatomic, strong) id<ShowAlertBGViewDelegate> delegate;

-(void)showView;

-(void)hideView;

@end
