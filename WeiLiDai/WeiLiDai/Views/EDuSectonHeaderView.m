//
//  EDuSectonHeaderView.m
//  WeiLiDai
//
//  Created by j on 2018/2/11.
//  Copyright © 2018年 j. All rights reserved.
//

#import "EDuSectonHeaderView.h"

@implementation EDuSectonHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    [self addSubview:self.whiteBGBtn];
    [self.whiteBGBtn addSubview:self.cellTitleLabel];
    [self.whiteBGBtn addSubview:self.cellSubtitleLabel];
    [self.whiteBGBtn addSubview:self.rightArrowView];
    [self.whiteBGBtn addSubview:self.topLineView];
    [self.whiteBGBtn addSubview:self.bottomLineView];
    
    weakify(self);
    CGFloat whiteBtnH = Width_Scall * 93;
    [self.whiteBGBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width, whiteBtnH));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
    }];
    CGFloat leftX = Width_Scall * 56;
    [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat labelW = [weakSelf.cellTitleLabel.text getWidthWithFont:weakSelf.cellTitleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, whiteBtnH)];
        make.width.mas_equalTo(@(labelW));
        make.left.mas_equalTo(weakSelf.whiteBGBtn.mas_left).with.offset(leftX);
        make.centerY.mas_equalTo(weakSelf.whiteBGBtn.mas_centerY);
    }];
    
    CGFloat rightArrowViewW = Width_Scall * 36;
    CGFloat rightArrowViewH = Width_Scall * 36;
    [self.rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(rightArrowViewW, rightArrowViewH));
        make.centerY.mas_equalTo(weakSelf.whiteBGBtn.mas_centerY);
        make.right.mas_equalTo(weakSelf.whiteBGBtn.mas_right).with.offset(-spaceMargin);
//        make.left.mas_equalTo(weakSelf.cellSubtitleLabel.mas_right).with.offset(spaceMargin);
    }];
//
    [self.cellSubtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(whiteBtnH);
        make.centerY.mas_equalTo(weakSelf.whiteBGBtn.mas_centerY);
        make.left.mas_equalTo(weakSelf.cellTitleLabel.mas_right);
        make.right.mas_equalTo(weakSelf.rightArrowView.mas_left).with.offset(-spaceMargin);
    }];
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width, 1));
        make.centerX.mas_equalTo(weakSelf.whiteBGBtn.mas_centerX);
        make.top.mas_equalTo(weakSelf.whiteBGBtn.mas_top);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        make.centerX.mas_equalTo(weakSelf.whiteBGBtn.mas_centerX);
        make.bottom.mas_equalTo(weakSelf.whiteBGBtn.mas_bottom);
    }];


}

#pragma mark - 懒加载

-(UIButton *)whiteBGBtn{
    if (!_whiteBGBtn) {
        _whiteBGBtn = [[UIButton alloc] init];
        _whiteBGBtn.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBGBtn;
}

-(UILabel *)cellTitleLabel{
    if (!_cellTitleLabel) {
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _cellTitleLabel.text = @"提前还清借款";
        _cellTitleLabel.textColor = ColorWithRGB(110, 110, 111, 1);
        _cellTitleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
        _cellTitleLabel.textAlignment = NSTextAlignmentLeft;
        _cellTitleLabel.numberOfLines = 1;
    }
    return _cellTitleLabel;
}

-(UILabel *)cellSubtitleLabel{
    if (!_cellSubtitleLabel) {
        _cellSubtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _cellSubtitleLabel.text = @"共1笔";
        _cellSubtitleLabel.textColor = ColorWithRGB(110, 110, 111, 1);
        _cellSubtitleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
        _cellSubtitleLabel.textAlignment = NSTextAlignmentRight;
        _cellSubtitleLabel.numberOfLines = 1;
    }
    return _cellSubtitleLabel;
}

-(UIImageView *)rightArrowView{
    if (!_rightArrowView) {
        CGFloat rightArrowViewW = Width_Scall * 36;
        CGFloat rightArrowViewH = Width_Scall * 36;
        _rightArrowView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - spaceMargin - rightArrowViewW, (self.frame.size.height - rightArrowViewH) / 2, rightArrowViewW, rightArrowViewH)];
        [_rightArrowView setImage:[UIImage imageNamed:@"rightArraowRight"]];
        _rightArrowView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _rightArrowView;
}

-(UIView *)topLineView{
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = grayBorderColor;
    }
    return _topLineView;
}

-(UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = grayBorderColor;
    }
    return _bottomLineView;
}



@end
