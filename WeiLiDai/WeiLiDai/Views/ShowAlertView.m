//
//  ShowAlertView.m
//  WeiLiDai
//
//  Created by j on 2017/12/23.
//  Copyright © 2017年 j. All rights reserved.
//

#import "ShowAlertView.h"

#define spaceX (Width_Scall * 24)
#define spaceY (Width_Scall * 30)

@implementation ShowAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    [self addSubview:self.nameLabel];
    [self addSubview:self.infoLabel];
    [self addSubview:self.yueTextField];
    [self addSubview:self.jieQianTextField];
    [self addSubview:self.doneBtn];
}

#pragma mark - 懒加载
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, spaceY, self.frame.size.width, 30)];
        _nameLabel.text = @"提示";
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:CELL_FONTSIZE + 5];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.numberOfLines = 1;
    }
    return _nameLabel;
}

-(UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nameLabel.frame.origin.y + self.nameLabel.frame.size.height + spaceY, self.frame.size.width + spaceY, 30)];
        _infoLabel.text = @"请输入钱包余额和可借金额";
        _infoLabel.textColor = [UIColor grayColor];
        _infoLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.numberOfLines = 1;
    }
    return _infoLabel;
}

-(UITextField *)yueTextField{
    if (!_yueTextField) {
        _yueTextField = [[UITextField alloc] initWithFrame:CGRectMake(spaceX, self.infoLabel.frame.origin.y + self.infoLabel.frame.size.height + spaceY, self.frame.size.width - spaceX * 2, 30)];
        _yueTextField.font = [UIFont boldSystemFontOfSize:DEFAULT_FONTSIZE];
        _yueTextField.textColor = [UIColor blackColor];
        _yueTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _yueTextField.placeholder = @"请输入钱包余额";
        _yueTextField.textAlignment = NSTextAlignmentCenter;
    }
    return _yueTextField;
}

-(UITextField *)jieQianTextField{
    if (!_jieQianTextField) {
        _jieQianTextField = [[UITextField alloc] initWithFrame:CGRectMake(spaceX, self.yueTextField.frame.origin.y + self.yueTextField.frame.size.height + spaceY, self.frame.size.width - spaceX * 2, 30)];
        _jieQianTextField.font = [UIFont boldSystemFontOfSize:DEFAULT_FONTSIZE];
        _jieQianTextField.textColor = [UIColor blackColor];
        _jieQianTextField.keyboardType = UIKeyboardTypeNumberPad;
        _jieQianTextField.placeholder = @"请输入可借金额";
        _jieQianTextField.textAlignment = NSTextAlignmentCenter;
    }
    return _jieQianTextField;
}

-(UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.jieQianTextField.frame.origin.y + self.jieQianTextField.frame.size.height + spaceY, self.frame.size.width, 60)];
        _doneBtn.backgroundColor = ColorWithRGB(234, 213, 163, 1);
        [_doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 5];
        [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        
    }
    return _doneBtn;
}


@end
