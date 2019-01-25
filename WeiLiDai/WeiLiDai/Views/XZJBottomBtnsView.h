//
//  XZJBottomBtnsView.h
//  WeiLiDai
//
//  Created by 王宗正 on 2018/7/20.
//  Copyright © 2018年 j. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LeftBtnClickedBlock)(void);
typedef void(^RightBtnClickedBlock)(void);

@interface XZJBottomBtnsView : UIView

@property (nonatomic, strong) UIButton * leftBtn;
@property (nonatomic, strong) UIImageView * leftBtnImageView;
@property (nonatomic, strong) UIButton * rightBtn;
@property (nonatomic, strong) UIImageView * rightBtnImageView;

@property (nonatomic, copy) LeftBtnClickedBlock leftClickedBlock;
@property (nonatomic, copy) RightBtnClickedBlock rightClickedBlock;

-(void)showView;
-(void)hideView;
- (CGFloat)hideViewHight;

-(void)setLeftBtnEnabled:(BOOL)enabled;
-(void)setRightBtnEnabled:(BOOL)enabled;

@end
