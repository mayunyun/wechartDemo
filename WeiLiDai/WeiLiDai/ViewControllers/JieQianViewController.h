//
//  JieQianViewController.h
//  WeiLiDai
//
//  Created by j on 2017/12/20.
//  Copyright © 2017年 j. All rights reserved.
//

#import "BaseViewController.h"
#import "ChangeBankCardView.h"
#import "XZJChoseBackCardView.h"

@interface JieQianViewController : BaseViewController

/**
 选择银行卡
 */
@property (nonatomic, strong) XZJChoseBackCardView * choseBankCardView;

/**
 选择银行卡弹框
 */
@property (nonatomic, strong) ChangeBankCardView * chengeBankCardView1;


@end
