//
//  InputUserInfoView.h
//  WeiLiDai
//
//  Created by j on 2018/2/6.
//  Copyright © 2018年 j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZJWriteNameOrIdNumView.h"
#import "XZJWriteIdNumView.h"

@interface InputUserInfoView : UIView

@property (nonatomic, strong) UIView * whiteBGView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) XZJWriteNameOrIdNumView * nameView;

@property (nonatomic, strong) XZJWriteIdNumView * IdNumView;
@property (nonatomic, strong) UIButton * moreBtn;
@property (nonatomic, strong) UIView * whiteBGViewBottomLineView;

/**
 创建线面的标签列表

 @param isBefore 是否是在点击下拉箭头之前
 */
-(void)createLabelsIfBeforeClickMoreBtn:(BOOL)isBefore;


@end
