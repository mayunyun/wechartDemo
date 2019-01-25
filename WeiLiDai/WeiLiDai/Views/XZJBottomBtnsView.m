
//
//  XZJBottomBtnsView.m
//  WeiLiDai
//
//  Created by 王宗正 on 2018/7/20.
//  Copyright © 2018年 j. All rights reserved.
//

#import "XZJBottomBtnsView.h"

static CGFloat btnH = 50;
static CGFloat imageViewW = 9;
static CGFloat imageViewH = 53/3;
static CGFloat imageViewX = 45;

@implementation XZJBottomBtnsView

-(instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, SCREEN_HEIGHT - btnH - iPhoneXSaftAreaH, SCREEN_WIDTH, btnH + iPhoneXSaftAreaH);
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = ColorWithRGB(249, 250, 252, 1);
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = ColorWithRGB(212, 213, 214, 1);
    [self addSubview:lineView];
}

-(void)showView{
    weakify(self);
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.frame = CGRectMake(0, SCREEN_HEIGHT - btnH - iPhoneXSaftAreaH, SCREEN_WIDTH, btnH + iPhoneXSaftAreaH);
    }];
}

-(void)hideView{
    weakify(self);
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.frame = CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, btnH + iPhoneXSaftAreaH);
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}
- (CGFloat)hideViewHight{
    return btnH + iPhoneXSaftAreaH;
}

-(void)setLeftBtnEnabled:(BOOL)enabled{
    self.leftBtn.enabled = enabled;
    if (enabled) {
        [self.leftBtnImageView setImage:[UIImage imageNamed:@"后退"]];
    }
    else{
        [self.leftBtnImageView setImage:[UIImage imageNamed:@"后退未选中"]];
    }
}
-(void)setRightBtnEnabled:(BOOL)enabled{
    self.rightBtn.enabled = enabled;
    if (enabled) {
        [self.rightBtnImageView setImage:[UIImage imageNamed:@"前进"]];
    }
    else{
        [self.rightBtnImageView setImage:[UIImage imageNamed:@"前进未选中"]];
    }
}

-(void)leftBtnClicked:(UIButton *)btn{
    self.leftClickedBlock();
}

-(void)rightBtnClicked:(UIButton *)btn{
    self.rightClickedBlock();
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [FactryFucClass createButtonWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, btnH)
                                      setBackgroundImage:nil
                                               addTarget:self
                                                  action:@selector(leftBtnClicked:)
                                        forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn addSubview:self.leftBtnImageView];
        _leftBtn.backgroundColor = [UIColor clearColor];
    }
    return _leftBtn;
}

-(UIImageView *)leftBtnImageView{
    if (!_leftBtnImageView) {
        _leftBtnImageView = [FactryFucClass createImageViewWithFrame:CGRectMake(self.leftBtn.frame.size.width - imageViewX - imageViewW, (btnH - imageViewH)/2, imageViewW, imageViewH)
                                                           imageName:@"后退"
                                                         contentMode:UIViewContentModeScaleAspectFill];
        _leftBtnImageView.layer.masksToBounds = NO;
    }
    return _leftBtnImageView;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [FactryFucClass createButtonWithFrame:CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, btnH)
                                      setBackgroundImage:nil
                                               addTarget:self
                                                  action:@selector(rightBtnClicked:)
                                        forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn addSubview:self.rightBtnImageView];
        _rightBtn.backgroundColor = [UIColor clearColor];
    }
    return _rightBtn;
}

-(UIImageView *)rightBtnImageView{
    if (!_rightBtnImageView) {
        _rightBtnImageView = [FactryFucClass createImageViewWithFrame:CGRectMake(imageViewX, (btnH - imageViewH)/2, imageViewW, imageViewH)
                                                           imageName:@"前进"
                                                         contentMode:UIViewContentModeScaleAspectFill];
        _rightBtnImageView.layer.masksToBounds = NO;
    }
    return _rightBtnImageView;
}



@end
