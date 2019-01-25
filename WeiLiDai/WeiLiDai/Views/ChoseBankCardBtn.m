//
//  ChoseBankCardBtn.m
//  WeiLiDai
//
//  Created by j on 2018/2/5.
//  Copyright © 2018年 j. All rights reserved.
//

#import "ChoseBankCardBtn.h"

#define headImageWH (Width_Scall * 56)

@interface ChoseBankCardBtn()

@property (nonatomic, strong) UIView * topLineView;
@property (nonatomic, strong) UIView * bottomLineView;

@end

@implementation ChoseBankCardBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = grayBorderColor.CGColor;
    self.layer.borderWidth = 1;
    [self addSubview:self.headImageView];
    [self addSubview:self.btnTitleLabel];
    [self addSubview:self.rightArrowView];
//    [self addSubview:self.topLineView];
//    [self addSubview:self.bottomLineView];
    weakify(self);
    CGFloat leftX = Width_Scall * 56;
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(headImageWH, headImageWH));
        make.left.mas_equalTo(weakSelf.mas_left).with.offset(leftX);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    [self.btnTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(headImageWH));
        make.left.mas_equalTo(weakSelf.headImageView.mas_right).with.offset(spaceMargin);
        make.right.mas_equalTo(weakSelf.rightArrowView.mas_left).with.offset(-spaceMargin);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    CGFloat rightArrowViewW = Width_Scall * 38;
    CGFloat rightArrowViewH = Width_Scall * 38;
    [self.rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(rightArrowViewW, rightArrowViewH));
        make.left.mas_equalTo(weakSelf.btnTitleLabel.mas_right).with.offset(spaceMargin);
//        make.right.mas_equalTo(weakSelf.mas_right).with.offset(-Width_Scall * 38);
        make.right.mas_equalTo(weakSelf.mas_right).with.offset(-spaceMargin);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    
//    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(@(1));
//        make.top.mas_equalTo(weakSelf.mas_top);
//        make.left.mas_equalTo(weakSelf.mas_left);
//        make.right.mas_equalTo(weakSelf.mas_right);
//    }];
//
//    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(@(1));
//        make.bottom.mas_equalTo(weakSelf.mas_bottom);
//        make.left.mas_equalTo(weakSelf.mas_left).with.offset(46/3);
//        make.right.mas_equalTo(weakSelf.mas_right);
//    }];
}

#pragma mark - 懒加载

-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gongshang"]];
        _headImageView.frame = CGRectMake(0, 0, headImageWH, headImageWH);
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.backgroundColor = [UIColor clearColor];
        _headImageView.layer.cornerRadius = headImageWH / 2;
    }
    return _headImageView;
}

-(UILabel *)btnTitleLabel{
    if (!_btnTitleLabel) {
        _btnTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _btnTitleLabel.text = @"工商银行储蓄卡(8888)";
        _btnTitleLabel.textColor = [UIColor blackColor];
        _btnTitleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _btnTitleLabel.textAlignment = NSTextAlignmentLeft;
        _btnTitleLabel.numberOfLines = 1;
        
    }
    return _btnTitleLabel;
}

-(UIImageView *)rightArrowView{
    if (!_rightArrowView) {
        CGFloat rightArrowViewW = Width_Scall * 36;
        CGFloat rightArrowViewH = Width_Scall * 36;
        _rightArrowView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - Width_Scall * 40 - rightArrowViewW, (self.frame.size.height - rightArrowViewH) / 2, rightArrowViewW, rightArrowViewH)];
        [_rightArrowView setImage:[UIImage imageNamed:@"yellowRightArrow"]];
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
