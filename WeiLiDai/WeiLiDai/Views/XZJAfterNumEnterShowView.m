//
//  XZJAfterNumEnterShowView.m
//  WeiLiDai
//
//  Created by j on 2018/1/29.
//  Copyright © 2018年 j. All rights reserved.
//

#import "XZJAfterNumEnterShowView.h"

//#define choseHuanKuanQiShuBtnH (Width_Scall * 86)
#define choseHuanKuanQiShuBtnH (142/3)
//#define titleSpace (Width_Scall * 25)
#define titleSpace (45/3)
#define subtitleLabelW (SCREEN_WIDTH - Width_Scall * 29 * 2 - Width_Scall * 295)

@interface XZJAfterNumEnterShowView()

@property (nonatomic, strong) UILabel * titltLabel1;
@property (nonatomic, strong) UILabel * titltLabel2;
@property (nonatomic, strong) UILabel * titltLabel3;
@property (nonatomic, strong) UILabel * titltLabel4;

@property (nonatomic, strong) UIButton * seeBtn;

@end

@implementation XZJAfterNumEnterShowView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = grayHuanKuanQiShuBGColor;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = grayBorderColor.CGColor;
    [self addSubview:self.choseHuanKuanQiShuBtn];
    [self addSubview:self.titltLabel1];
    [self addSubview:self.titltLabel2];
    [self addSubview:self.titltLabel3];
    [self addSubview:self.titltLabel4];
    [self addSubview:self.subtitltLabel1];
    [self addSubview:self.subtitltLabel2];
    [self addSubview:self.seeBtn];
    
}

#pragma mark - 懒加载

-(XZJChoseHuanKuanQiShuBtn *)choseHuanKuanQiShuBtn{
    if (!_choseHuanKuanQiShuBtn) {
        _choseHuanKuanQiShuBtn = [[XZJChoseHuanKuanQiShuBtn alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, choseHuanKuanQiShuBtnH)];
    }
    return _choseHuanKuanQiShuBtn;
}

-(UILabel *)titltLabel1{
    if (!_titltLabel1) {
        _titltLabel1 = [[UILabel alloc] init];
        _titltLabel1.text = @"首次还款";
        CGSize labelSize = [_titltLabel1.text getSizeWithFont:[UIFont systemFontOfSize:DEFAULT_FONTSIZE] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        _titltLabel1.frame = CGRectMake(huanKuanQiShuTitleLabelX, self.choseHuanKuanQiShuBtn.frame.origin.y + self.choseHuanKuanQiShuBtn.frame.size.height + 76/3, labelSize.width, 40/3);
        _titltLabel1.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _titltLabel1.textColor = grayHuanKuanQiShuTitleColor;
        _titltLabel1.numberOfLines = 1;
    }
    return _titltLabel1;
}

-(UILabel *)titltLabel2{
    if (!_titltLabel2) {
        _titltLabel2 = [[UILabel alloc] init];
        _titltLabel2.text = @"还款日";
        CGSize labelSize = [_titltLabel2.text getSizeWithFont:[UIFont systemFontOfSize:DEFAULT_FONTSIZE] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        _titltLabel2.frame = CGRectMake(huanKuanQiShuTitleLabelX, self.titltLabel1.frame.origin.y + self.titltLabel1.frame.size.height + titleSpace, labelSize.width, 40/3);
        _titltLabel2.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _titltLabel2.textColor = grayHuanKuanQiShuTitleColor;
        _titltLabel2.numberOfLines = 1;
    }
    return _titltLabel2;
}

-(UILabel *)titltLabel3{
    if (!_titltLabel3) {
        _titltLabel3 = [[UILabel alloc] init];
        _titltLabel3.text = @"还款详情";
        CGSize labelSize = [_titltLabel3.text getSizeWithFont:[UIFont systemFontOfSize:DEFAULT_FONTSIZE] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        _titltLabel3.frame = CGRectMake(huanKuanQiShuTitleLabelX, self.titltLabel2.frame.origin.y + self.titltLabel2.frame.size.height + titleSpace, labelSize.width, 40/3);
        _titltLabel3.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _titltLabel3.textColor = grayHuanKuanQiShuTitleColor;
        _titltLabel3.numberOfLines = 1;
    }
    return _titltLabel3;
}

-(UILabel *)titltLabel4{
    if (!_titltLabel4) {
        _titltLabel4 = [[UILabel alloc] init];
        _titltLabel4.text = @"次日起可提前还款，免违约金";
        CGSize labelSize = [_titltLabel4.text getSizeWithFont:[UIFont systemFontOfSize:DEFAULT_FONTSIZE] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        _titltLabel4.frame = CGRectMake(huanKuanQiShuTitleLabelX, self.titltLabel3.frame.origin.y + self.titltLabel3.frame.size.height + titleSpace, labelSize.width, 40/3);
        _titltLabel4.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _titltLabel4.textColor = grayHuanKuanQiShuTitleColor;
        _titltLabel4.numberOfLines = 1;
    }
    return _titltLabel4;
}

-(UILabel *)subtitltLabel1{
    if (!_subtitltLabel1) {
        _subtitltLabel1 = [[UILabel alloc] init];
        _subtitltLabel1.text = @"¥00.00(1月1号)";
        _subtitltLabel1.frame = CGRectMake(huanKuanQiShuSubtitleLabelW, self.titltLabel1.frame.origin.y, subtitleLabelW, self.titltLabel1.frame.size.height);
        _subtitltLabel1.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _subtitltLabel1.textColor = [UIColor blackColor];
        _subtitltLabel1.numberOfLines = 1;
    }
    return _subtitltLabel1;
}

-(UILabel *)subtitltLabel2{
    if (!_subtitltLabel2) {
        _subtitltLabel2 = [[UILabel alloc] init];
        _subtitltLabel2.text = @"每月1号";
        _subtitltLabel2.frame = CGRectMake(huanKuanQiShuSubtitleLabelW, self.titltLabel2.frame.origin.y, subtitleLabelW, self.titltLabel2.frame.size.height);
        _subtitltLabel2.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _subtitltLabel2.textColor = [UIColor blackColor];
        _subtitltLabel2.numberOfLines = 1;
    }
    return _subtitltLabel2;
}

-(UIButton *)seeBtn{
    if (!_seeBtn) {
        _seeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_seeBtn setTitle:@"查看" forState:UIControlStateNormal];
        CGSize labelSize = [_seeBtn.titleLabel.text getSizeWithFont:[UIFont systemFontOfSize:DEFAULT_FONTSIZE] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        _seeBtn.frame = CGRectMake(huanKuanQiShuSubtitleLabelW, self.titltLabel3.frame.origin.y, labelSize.width, labelSize.height);
        [_seeBtn setTitleColor:ColorWithRGB(100, 107, 148, 1) forState:UIControlStateNormal];
        [_seeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _seeBtn.titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        
    }
    return _seeBtn;
}

@end
