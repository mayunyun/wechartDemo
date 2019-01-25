//
//  XZJEidtSingleLineTextFieldViewController.h
//  HuaShiJinFu
//
//  Created by j on 2018/2/8.
//  Copyright © 2018年 FangLian. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^TextFieldValueBlock)(NSString * text);

@interface XZJEidtSingleLineTextFieldViewController : BaseViewController

@property (nonatomic, copy) TextFieldValueBlock block;

/**
 初始化文本框中填写的字符串

 @param oldText oldText description
 @return return value description
 */
-(instancetype)initWithText:(NSString *)oldText;

@property (nonatomic,strong)NSString* riLiLv;

@end
