//
//  ChoseBankCardViewController.h
//  WeiLiDai
//
//  Created by 王宗正 on 2018/7/2.
//  Copyright © 2018年 j. All rights reserved.
//

#import "BaseViewController.h"
#import "BankCardModel.h"

typedef void(^ChoseBankCardModelBlock)(BankCardModel *bankCardModel);

@interface ChoseBankCardViewController : BaseViewController

@property (nonatomic, copy) ChoseBankCardModelBlock block;

@end
