//
//  XZJChoseBackCardView.h
//  WeiLiDai
//
//  Created by j on 2018/1/31.
//  Copyright © 2018年 j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoseBankCardBtn.h"

@interface XZJChoseBackCardView : UIView

@property (nonatomic, strong) UIImageView * juChiImageView;
@property (nonatomic, strong) ChoseBankCardBtn * choseBankCardBtn;
@property (nonatomic, strong) UIButton * supportBankBtn;

-(instancetype)initWithFrame:(CGRect)frame firstBankCardIndex:(NSInteger)index cardNum:(NSString *)cardNum;

@end
