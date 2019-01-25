//
//  ChengeBankCardFrontView.h
//  WeiLiDai
//
//  Created by j on 2018/2/6.
//  Copyright © 2018年 j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoseBankCardBtn.h"

@interface ChengeBankCardFrontView : UIView

@property (nonatomic, strong) UIButton * closeBtn;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) ChoseBankCardBtn * bankCardBtn1;
@property (nonatomic, strong) ChoseBankCardBtn * bankCardBtn2;
@property (nonatomic, strong) ChoseBankCardBtn * bankCardBtn3;
@property (nonatomic, strong) ChoseBankCardBtn * bankCardBtn4;
@property (nonatomic, strong) UIButton * addBankCardBtn;

@property (nonatomic, strong) NSMutableArray * btnArray;

@property (nonatomic, copy) NSString * kahao;
@property (nonatomic, assign) NSInteger index;

-(instancetype)initWithFrame:(CGRect)frame firstBankCardIndex:(NSInteger)index cardNum:(NSString *)cardNum;

@end
