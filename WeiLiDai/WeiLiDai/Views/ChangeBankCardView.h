//
//  ChangeBankCardView.h
//  WeiLiDai
//
//  Created by j on 2018/2/6.
//  Copyright © 2018年 j. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JieQianViewController;
@class ChengeBankCardFrontView;
@interface ChangeBankCardView : UIView

@property (nonatomic, strong) ChengeBankCardFrontView * chengeBankCardFrontView;

@property (nonatomic, strong) JieQianViewController * jieqianVC;

@property (nonatomic, copy) NSString * kahao;
@property (nonatomic, assign) NSInteger index;

-(instancetype)initWithFrame:(CGRect)frame firstBankCardIndex:(NSInteger)index cardNum:(NSString *)cardNum;

-(void)showView;

-(void)hideView;

@end
