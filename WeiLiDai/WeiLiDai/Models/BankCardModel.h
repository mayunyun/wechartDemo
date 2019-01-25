//
//  BankCardModel.h
//  WeiLiDai
//
//  Created by j on 2018/2/25.
//  Copyright © 2018年 j. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardModel : NSObject

/**
 银行名字
 */
@property (nonatomic, copy) NSString * bBankName;
/**
 银行标志下标
 */
@property (nonatomic, assign) NSUInteger bBankSignIndex;
/**
 银行标志名称
 */
@property (nonatomic, copy) NSString * bBankSignImageName;

/**
 银行卡号后四位
 */
@property (nonatomic, copy) NSString * bBankCardNum;

@end
