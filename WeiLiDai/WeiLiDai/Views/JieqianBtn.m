//
//  JieqianBtn.m
//  WeiLiDai
//
//  Created by j on 2018/3/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import "JieqianBtn.h"

static CGFloat leftSpace = 48/3;
static CGFloat choseSignViewWH = 64/3;

@implementation JieqianBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    [self addSubview:self.lineView];
    [self addSubview:self.lineView2];
    [self addSubview:self.choseSignView];
    [self addSubview:self.borrowMoneyLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.signLabel];
    weakify(self);
    CGFloat borrowMoneyLabelH = 52/3;
    [self.borrowMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat labelW = [weakSelf.borrowMoneyLabel.text getWidthWithFont:weakSelf.borrowMoneyLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, borrowMoneyLabelH)];
        make.size.mas_equalTo(CGSizeMake(labelW, borrowMoneyLabelH));
        make.left.mas_equalTo(weakSelf.choseSignView.mas_right).with.offset(borrowMoneyLabelH);
        make.bottom.mas_equalTo(weakSelf.mas_centerY);
    }];
    
    CGFloat timeLabelH = 34/3;
    CGFloat timeLabelY = 21/3;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, timeLabelH));
        make.left.mas_equalTo(weakSelf.borrowMoneyLabel.mas_left);
        make.top.mas_equalTo(weakSelf.mas_centerY).with.offset(timeLabelY);
    }];
    
    CGFloat signLabelR = 27/3;
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(leftSpace, leftSpace));
        make.right.mas_equalTo(weakSelf.mas_right).with.offset(-signLabelR);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, leftSpace));
        make.right.mas_equalTo(weakSelf.signLabel.mas_left).with.offset(-timeLabelY);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, 0, self.frame.size.width - leftSpace, 1)];
        _lineView.backgroundColor = ColorWithRGB(232, 232, 232, 1);
    }
    return _lineView;
}

-(UIView *)lineView2{
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, self.frame.size.height - 1, self.frame.size.width - leftSpace, 1)];
        _lineView2.backgroundColor = ColorWithRGB(232, 232, 232, 1);
    }
    return _lineView2;
}

-(UIView *)choseSignView{
    if (!_choseSignView) {
        _choseSignView = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, (self.frame.size.height - choseSignViewWH)/2, choseSignViewWH, choseSignViewWH )];
        _choseSignView.backgroundColor = ColorWithRGB(231, 229, 229, 1);
        _choseSignView.layer.masksToBounds = YES;
        _choseSignView.layer.cornerRadius = choseSignViewWH/2;
    }
    return _choseSignView;
}

-(UILabel *)borrowMoneyLabel{
    if (!_borrowMoneyLabel) {
        _borrowMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        _borrowMoneyLabel.text = [NSString stringWithFormat:@"借款¥%@.00",cingleTon.bBorrowCount];
        _borrowMoneyLabel.textColor = [UIColor blackColor];
        _borrowMoneyLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
    }
    return _borrowMoneyLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        _timeLabel.text = [NSString stringWithFormat:@"%@",cingleTon.bFrondTime];
        _timeLabel.textColor = ColorWithRGB(184, 184, 184, 1);
        _timeLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE - 1];
    }
    return _timeLabel;
}

-(UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        _subtitleLabel.text = @"明日起可还";
        _subtitleLabel.textColor = [UIColor blackColor];
        _subtitleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE - 1];
        _subtitleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _subtitleLabel;
}

-(UILabel *)signLabel{
    if (!_signLabel) {
        _signLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, leftSpace, leftSpace)];
        _signLabel.textColor = ColorWithRGB(217, 217, 217, 1);
        _signLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE - 2];
        _signLabel.text = @"i";
        _signLabel.layer.masksToBounds = YES;
        _signLabel.layer.cornerRadius = leftSpace / 2;
        _signLabel.layer.borderWidth = 1;
        _signLabel.layer.borderColor = ColorWithRGB(217, 217, 217, 1).CGColor;
        _signLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _signLabel;
}

@end
