//
//  EditBankCardViewController.h
//  WeiLiDai
//
//  Created by j on 2018/2/25.
//  Copyright © 2018年 j. All rights reserved.
//

#import "BaseViewController.h"
#import "BankCardModel.h"
//@class BankCardModel;
typedef void(^SaveCardMessageBlock)(BankCardModel * cardModel);
@interface EditBankCardViewController : BaseViewController

@property (nonatomic, copy) SaveCardMessageBlock block;

/**
 初始化方法
 
 @param isEditCard yes位编辑新航卡信息 NO为添加银行卡
 @param index cell的下标
 @return return value description
 */
-(instancetype)initIfEditCard:(BOOL)isEditCard listIndex:(NSUInteger)index;

@end
