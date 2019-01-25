//
//  ChangeBankCardView.m
//  WeiLiDai
//
//  Created by j on 2018/2/6.
//  Copyright © 2018年 j. All rights reserved.
//

#import "ChangeBankCardView.h"
#import "ChengeBankCardFrontView.h"
#import "JieQianViewController.h"

//#define chengeBankCardX (Width_Scall * 85)
#define chengeBankCardX (124/3)
//#define chengeBankCardBtnH (Width_Scall * 100)
#define chengeBankCardBtnH (185/3)
#define chengeBankCardTitleH (151/3)
#define chengeBankCardAddBtnH (154/3)

@implementation ChangeBankCardView

-(instancetype)initWithFrame:(CGRect)frame firstBankCardIndex:(NSInteger)index cardNum:(NSString *)cardNum{
    self = [super initWithFrame:frame];
    if (self) {
        self.kahao = cardNum;
        self.index = index;
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.hidden = YES;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self addSubview:self.chengeBankCardFrontView];
}

-(void)cancelBtnClicked:(UIButton *)btn{
    
    [self hideView];
}

-(void)bankCardBtn1Clicked:(ChoseBankCardBtn *)btn{
//    JieQianViewController * jieqianVC = (JieQianViewController *)[ChangeBankCardView parentViewController:self];
    NSDictionary * dic = bankCards[btn.index];
    NSString * title1 = [NSString stringWithFormat:@"%@ 储蓄卡(%@)",dic[@"bankName"],btn.kahao];
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    cingleTon.bBankCardNumTemp = btn.kahao;
    cingleTon.bBankNameTemp = dic[@"bankName"];
    cingleTon.bBankSignIndex = btn.index;
//    jieqianVC.choseBankCardView
    [self.jieqianVC.choseBankCardView.choseBankCardBtn.headImageView setImage:btn.headImageView.image];
    self.jieqianVC.choseBankCardView.choseBankCardBtn.btnTitleLabel.text = title1;
    self.jieqianVC.choseBankCardView.choseBankCardBtn.index = btn.index;
    self.jieqianVC.choseBankCardView.choseBankCardBtn.kahao = btn.kahao;
    [self hideView];
}

//+(UIViewController *)parentViewController:(UIView *)obj{
//    for (UIView * next = [obj superview]; next; next = next.superview) {
//        UIResponder * nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController *)nextResponder;
//        }
//    }
//    return nil;
//}


//-(void)bankCardBtn2Clicked:(ChoseBankCardBtn *)btn{
//    [self hideView];
//}

-(void)showView{
    weakify(self);
    
    [UIView animateWithDuration:0.3 animations:^{
//        weakSelf.shaiXuanView.hidden = NO;
        weakSelf.hidden = NO;
//        weakSelf.shaiXuanView.frame = CGRectMake(spaceMargin, (SCREEN_HEIGHT - shaiXuanH) / 2, SCREEN_WIDTH - spaceMargin * 2, shaiXuanH);
    }];
    
}

-(void)hideView{
    weakify(self);
    [UIView animateWithDuration:0.2 animations:^{
//        weakSelf.shaiXuanView.frame = CGRectMake(spaceMargin, SCREEN_HEIGHT, SCREEN_WIDTH - spaceMargin * 2, shaiXuanH);
    } completion:^(BOOL finished) {
//        weakSelf.shaiXuanView.hidden = YES;
        weakSelf.hidden = YES;
//        weakSelf.shaiXuanView.frame = CGRectMake(spaceMargin, -shaiXuanH, SCREEN_WIDTH - spaceMargin * 2, shaiXuanH);
    }];
}

/**
 屏蔽子视图的收手势
 
 @param gestureRecognizer gestureRecognizer对象
 @param touch 手势
 @return 是否屏蔽
 */
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//
//    if ([touch.view isDescendantOfView:self.shaiXuanView]) {
//        return NO;
//    }
//
//    return YES;
//
//}

-(void)hideWriteEvaluationView:(UITapGestureRecognizer *)tapGesture{
    [self hideView];
}

#pragma mark - 懒加载
-(ChengeBankCardFrontView *)chengeBankCardFrontView{
    if (!_chengeBankCardFrontView) {
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        NSUInteger cardNum = cingleTon.bankCardModels.count;
        CGFloat viewH = 0;
        if (cardNum >= maxCardNum) {
            viewH += chengeBankCardBtnH * cardNum + chengeBankCardTitleH;
        }
        else{
            viewH += chengeBankCardBtnH * cardNum + chengeBankCardTitleH + chengeBankCardAddBtnH;
        }
        _chengeBankCardFrontView = [[ChengeBankCardFrontView alloc] initWithFrame:CGRectMake(chengeBankCardX, (self.frame.size.height - viewH) / 2, SCREEN_WIDTH - chengeBankCardX * 2, viewH) firstBankCardIndex:self.index cardNum:self.kahao];
        _chengeBankCardFrontView.hidden = NO;
        [_chengeBankCardFrontView.closeBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        for (ChoseBankCardBtn * btn in _chengeBankCardFrontView.btnArray) {
            [btn addTarget:self action:@selector(bankCardBtn1Clicked:) forControlEvents:UIControlEventTouchUpInside];
        }
//        [_chengeBankCardFrontView.bankCardBtn1 addTarget:self action:@selector(bankCardBtn1Clicked:) forControlEvents:UIControlEventTouchUpInside];
//        [_chengeBankCardFrontView.bankCardBtn2 addTarget:self action:@selector(bankCardBtn1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chengeBankCardFrontView;
}

@end
