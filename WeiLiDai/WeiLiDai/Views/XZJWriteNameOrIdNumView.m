//
//  XZJWriteNameOrIdNumView.m
//  WeiLiDai
//
//  Created by j on 2018/2/8.
//  Copyright © 2018年 j. All rights reserved.
//

#import "XZJWriteNameOrIdNumView.h"

@interface XZJWriteNameOrIdNumView()

@end

@implementation XZJWriteNameOrIdNumView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    [self addSubview:self.valueLabel];
    [self addSubview:self.valueTextField];
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = grayBorderColor;
    [self addSubview:lineView];
    weakify(self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize labelSz = [@"身份证" getSizeWithFont:weakSelf.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        make.size.mas_equalTo(labelSz);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize labelSz = [weakSelf.valueLabel.text getSizeWithFont:weakSelf.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        make.size.mas_equalTo(labelSz);
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).with.offset(spaceMargin);
        make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);
    }];
    
    [self.valueTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(weakSelf.frame.size.height));
        make.left.mas_equalTo(weakSelf.valueLabel.mas_right).with.offset(spaceMargin / 3);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width, 1));
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    
}

-(void)setValueLabelText:(NSString *)valueLabelText{
    self.valueLabel.text = valueLabelText;
    weakify(self);
    [self.valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGSize labelSz = [weakSelf.valueLabel.text getSizeWithFont:weakSelf.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        make.size.mas_equalTo(labelSz);
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).with.offset(spaceMargin);
        make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);
    }];
}

#pragma mark - 懒加载

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"身份证";
        _titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

-(UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.text = @"8888**********";
        _valueLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _valueLabel.textAlignment = NSTextAlignmentLeft;
        _valueLabel.textColor = [UIColor blackColor];
        _valueLabel.numberOfLines = 1;
    }
    return _valueLabel;
}

-(UITextField *)valueTextField{
    if (!_valueTextField) {
        _valueTextField = [[UITextField alloc] init];
        _valueTextField.placeholder = @"补全后4位";
        _valueTextField.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
//        _valueTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _valueTextField;
}

@end
