//
//  SYPasswordView.h
//  PasswordDemo
//
//  Created by aDu on 2017/2/6.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTextField.h"

typedef void(^CheckPwdBlock)(NSString * pwd);
@interface SYPasswordView : UIView<UITextFieldDelegate>

@property (nonatomic, copy) CheckPwdBlock block;
@property (nonatomic, strong) HTTextField *textField;

/**
 *  清除密码
 */
- (void)clearUpPassword;

@end
