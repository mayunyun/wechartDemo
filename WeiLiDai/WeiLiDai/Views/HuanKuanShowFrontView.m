//
//  HuanKuanShowFrontView.m
//  WeiLiDai
//
//  Created by j on 2018/3/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import "HuanKuanShowFrontView.h"

static CGFloat titleLabelH = 209/3;

@implementation HuanKuanShowFrontView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 14/3;
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.doneBtn];
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, titleLabelH)];
        _titleLabel.text = @"当天借款第二天起才可还款";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 1];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleLabelH, self.frame.size.width, 1)];
        _lineView.backgroundColor = ColorWithRGB(209, 209, 209, 1);
    }
    return _lineView;
}

-(UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneBtn.frame = CGRectMake(0, titleLabelH+1, self.frame.size.width, 157/3);
        [_doneBtn setTitle:@"知道了" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:ColorWithRGB(84, 184, 53, 1) forState:UIControlStateNormal];
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 1];
//        [_doneBtn addTarget:self action:@selector(doneBtnCLicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

@end
