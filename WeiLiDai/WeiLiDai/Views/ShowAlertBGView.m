//
//  ShowAlertBGView.m
//  WeiLiDai
//
//  Created by j on 2017/12/23.
//  Copyright © 2017年 j. All rights reserved.
//

#import "ShowAlertBGView.h"

#define shaiXuanH (Width_Scall * 30 * 5 + 180)
#define spaceMargin1 (Width_Scall * 60)

@implementation ShowAlertBGView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.hidden = YES;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self addSubview:self.alertView];
    [self addGestureRecognizer:self.tapGesture];
}

-(void)showView{
    weakify(self);
    
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.hidden = NO;
        weakSelf.hidden = NO;
        weakSelf.alertView.frame = CGRectMake(spaceMargin1, (SCREEN_HEIGHT - shaiXuanH) / 2 - 50, SCREEN_WIDTH - spaceMargin1 * 2, shaiXuanH);
    }];
    
}

-(void)hideView{
    weakify(self);
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf.alertView.yueTextField resignFirstResponder];
        [weakSelf.alertView.jieQianTextField resignFirstResponder];
        weakSelf.alertView.frame = CGRectMake(spaceMargin1, SCREEN_HEIGHT, SCREEN_WIDTH - spaceMargin1 * 2, shaiXuanH);
    } completion:^(BOOL finished) {
        weakSelf.alertView.hidden = YES;
        weakSelf.hidden = YES;
        weakSelf.alertView.frame = CGRectMake(spaceMargin1, -shaiXuanH, SCREEN_WIDTH - spaceMargin1 * 2, shaiXuanH);
    }];
}

/**
 屏蔽子视图的收手势
 
 @param gestureRecognizer gestureRecognizer对象
 @param touch 手势
 @return 是否屏蔽
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.alertView]) {
        return NO;
    }
    
    return YES;
    
}

-(void)hideWriteEvaluationView:(UITapGestureRecognizer *)tapGesture{
//    [self hideView];
    [self.alertView.yueTextField resignFirstResponder];
    [self.alertView.jieQianTextField resignFirstResponder];
}

-(void)doneBtnClicked:(UIButton *)btn{
    
    SingleTon * singleTon = [SingleTon sharedSingleTon];
    singleTon.yuECount = [self.alertView.yueTextField.text floatValue];
    
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    int i = [[user objectForKey:openCountKey] intValue];
//    if (i >openCount) {
//        singleTon.borrowCount = 100;
//    }
//    else{
        singleTon.borrowCount = [self.alertView.jieQianTextField.text integerValue];
//    }
    
//    singleTon.borrowCount = [self.alertView.jieQianTextField.text integerValue];
    singleTon.keBorrowCount = singleTon.borrowCount;
    [self hideView];
    if ([self.delegate respondsToSelector:@selector(showAlertBGView:newYuE:newBorrowCount:)]) {
        [self.delegate showAlertBGView:self newYuE:singleTon.yuECount newBorrowCount:(NSUInteger)singleTon.borrowCount];
    }

}

#pragma mark - 懒加载
-(ShowAlertView *)alertView{
    if (!_alertView) {
        _alertView = [[ShowAlertView alloc] initWithFrame:CGRectMake(spaceMargin1, -shaiXuanH, SCREEN_WIDTH - spaceMargin1 * 2, shaiXuanH)];
        _alertView.hidden = YES;
//        [_alertView.cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView.doneBtn addTarget:self action:@selector(doneBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        SingleTon * singleTon = [SingleTon sharedSingleTon];
        _alertView.yueTextField.text = singleTon.yuECount == 0?@"":[NSString stringWithFormat:@"%.2f",singleTon.yuECount];
        _alertView.jieQianTextField.text = singleTon.borrowCount == 0?@"":[NSString stringWithFormat:@"%ld",singleTon.borrowCount];
    }
    return _alertView;
}

-(UITapGestureRecognizer *)tapGesture{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWriteEvaluationView:)];
        _tapGesture.delegate = self;
    }
    return _tapGesture;
}

@end
