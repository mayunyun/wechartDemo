//
//  HuanqianView.m
//  WeiLiDai
//
//  Created by j on 2018/3/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import "HuanqianView.h"

static CGFloat jieqianBtnY = 262/3;
static CGFloat jieqianBtnH = 207/3;

@implementation HuanqianView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = ColorWithRGB(219, 219, 219, 1).CGColor;
    [self addSubview:self.titleLabel];
    [self addSubview:self.jieqianBtn];
    [self addSubview:self.quanxuanBtn];
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 142/3, 150, 44/3)];
        _titleLabel.text = @"提前还清借款";
        _titleLabel.textColor = ColorWithRGB(164, 164, 164, 1);
    }
    return _titleLabel;
}

-(JieqianBtn *)jieqianBtn{
    if (!_jieqianBtn) {
        _jieqianBtn = [[JieqianBtn alloc] initWithFrame:CGRectMake(0, jieqianBtnY, self.frame.size.width, jieqianBtnH)];
    }
    return _jieqianBtn;
}

-(QuanxuanBtn *)quanxuanBtn{
    if (!_quanxuanBtn) {
        CGFloat quanxuanBtnH = 184/3;
        _quanxuanBtn = [[QuanxuanBtn alloc] initWithFrame:CGRectMake(0, self.frame.size.height - quanxuanBtnH, self.frame.size.width, quanxuanBtnH)];
    }
    return _quanxuanBtn;
}

@end
