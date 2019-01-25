//
//  XZJChoseHuanKuanQiShuBtn.m
//  WeiLiDai
//
//  Created by j on 2018/1/29.
//  Copyright © 2018年 j. All rights reserved.
//

#import "XZJChoseHuanKuanQiShuBtn.h"
#import "XZJHuanKuanQiShuTitleLabel.h"

@implementation XZJChoseHuanKuanQiShuBtn

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
    self.layer.borderColor = grayBorderColor.CGColor;
    [self addSubview:self.btnTitltLabel];
    [self addSubview:self.subtitltLabel];
    
    CGFloat rightArrowViewW = Width_Scall * 36;
    CGFloat rightArrowViewH = Width_Scall * 36;
    UIImageView * rightArrowView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - Width_Scall * 40 - rightArrowViewW, (self.frame.size.height - rightArrowViewH) / 2, rightArrowViewW, rightArrowViewH)];
    [rightArrowView setImage:[UIImage imageNamed:@"yellowRightArrow"]];
    rightArrowView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:rightArrowView];
}


#pragma mark - 懒加载
-(XZJHuanKuanQiShuTitleLabel *)btnTitltLabel{
    if (!_btnTitltLabel) {
        _btnTitltLabel = [[XZJHuanKuanQiShuTitleLabel alloc] initWithFrame:CGRectMake(huanKuanQiShuTitleLabelX, 0, self.frame.size.width - huanKuanQiShuTitleLabelX, self.frame.size.height)];
        _btnTitltLabel.text = @"还款期数";
    }
    return _btnTitltLabel;
}

-(UILabel *)subtitltLabel{
    if (!_subtitltLabel) {
        _subtitltLabel = [[UILabel alloc] initWithFrame:CGRectMake(huanKuanQiShuSubtitleLabelX, 0, huanKuanQiShuSubtitleLabelW, self.frame.size.height)];
        _subtitltLabel.text = @"10个月";
        _subtitltLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _subtitltLabel.textColor = [UIColor blackColor];
        _subtitltLabel.numberOfLines = 1;
    }
    return _subtitltLabel;
}

@end
