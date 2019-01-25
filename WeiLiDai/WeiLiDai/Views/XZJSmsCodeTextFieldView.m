//
//  XZJSmsCodeTextFieldView.m
//  WeiLiDai
//
//  Created by j on 2018/2/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import "XZJSmsCodeTextFieldView.h"

@implementation XZJSmsCodeTextFieldView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = Width_Scall * 8;
//    self.layer.borderColor = grayBorderColor.CGColor;
//    self.layer.borderWidth = 1;
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 549/3, self.frame.size.height)];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = Width_Scall * 8;
    view.layer.borderColor = grayBorderColor.CGColor;
    view.layer.borderWidth = 1;
    [self addSubview:view];
    [self addSubview:self.textField];
}

-(HTTextField *)textField{
    if (!_textField) {
//        _textField = [[HTTextField alloc] initWithFrame:CGRectMake(spaceMargin, 0, self.frame.size.width - spaceMargin * 2, self.frame.size.height)];
        _textField = [[HTTextField alloc] initWithFrame:CGRectMake(spaceMargin, 0, 800/3, self.frame.size.height)];
        _textField.placeholder = @"填写验证码";
        _textField.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField setKeyboardType:HTKeyboardTypeNumber];
        [_textField setNumberKeyboardType:HTNumberKeyboardNumber];
    }
    return _textField;
}

@end
