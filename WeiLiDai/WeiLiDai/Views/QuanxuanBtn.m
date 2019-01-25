//
//  QuanxuanBtn.m
//  WeiLiDai
//
//  Created by j on 2018/3/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import "QuanxuanBtn.h"

static CGFloat leftSpace = 48/3;
static CGFloat choseSignViewWH = 64/3;
static CGFloat rmbImageViewW = 34/3;
static CGFloat rmbImageViewH = 46/3;

@implementation QuanxuanBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    [self addSubview:self.choseSignView];
    [self addSubview:self.quanxuanLabel];
    [self addSubview:self.zongjiLabel];
    [self addSubview:self.rmbImageView];
    [self addSubview:self.zongjiCountLabel];
    weakify(self);
    [self.quanxuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize labelSz = [weakSelf.quanxuanLabel.text getSizeWithFont:weakSelf.quanxuanLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        make.size.mas_equalTo(labelSz);
        make.left.mas_equalTo(weakSelf.choseSignView.mas_right).with.offset(leftSpace);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
    
    [self.zongjiCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize labelSz = [weakSelf.zongjiCountLabel.text getSizeWithFont:weakSelf.zongjiCountLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        make.size.mas_equalTo(CGSizeMake(labelSz.width, labelSz.height));
        make.right.mas_equalTo(weakSelf.mas_right).with.offset(-94/3);
        make.bottom.mas_equalTo(weakSelf.quanxuanLabel.mas_bottom).with.offset(19/3);
    }];
    
    [self.rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(rmbImageViewW, rmbImageViewH));
        make.right.mas_equalTo(weakSelf.zongjiCountLabel.mas_left).with.offset(-10);
        make.top.mas_equalTo(weakSelf.zongjiCountLabel.mas_top).with.offset(27/3);
    }];
    
    [self.zongjiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize labelSz = [weakSelf.zongjiLabel.text getSizeWithFont:weakSelf.zongjiLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        make.size.mas_equalTo(labelSz);
        make.right.mas_equalTo(weakSelf.rmbImageView.mas_left).with.offset(-11);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
    }];
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

-(UILabel *)quanxuanLabel{
    if (!_quanxuanLabel) {
        _quanxuanLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _quanxuanLabel.text = @"全选";
        _quanxuanLabel.textColor = ColorWithRGB(144, 144, 144, 1);
        _quanxuanLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE-1];
        _quanxuanLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _quanxuanLabel;
}

-(UILabel *)zongjiLabel{
    if (!_zongjiLabel) {
        _zongjiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _zongjiLabel.text = @"总计";
        _zongjiLabel.textColor = ColorWithRGB(144, 144, 144, 1);
        _zongjiLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE-1];
        _zongjiLabel.textAlignment = NSTextAlignmentRight;
    }
    return _zongjiLabel;
}

-(UIImageView *)rmbImageView{
    if (!_rmbImageView) {
        _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RMBGray"]];
        _rmbImageView.frame = CGRectMake(0, 0, rmbImageViewW, rmbImageViewH);
        _rmbImageView.contentMode = UIViewContentModeScaleAspectFill;
        //        _rmbImageView.layer.masksToBounds = YES;
    }
    return _rmbImageView;
}

-(UILabel *)zongjiCountLabel{
    if (!_zongjiCountLabel) {
        _zongjiCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        _zongjiCountLabel.text = @"0";
        _zongjiCountLabel.textColor = ColorWithRGB(71, 67, 64, 1);
        //        _edLabel.font = [UIFont fontWithName:@"WeChat Sans SS" size:CELL_FONTSIZE * 4];
        _zongjiCountLabel.font = [UIFont fontWithName:@"WeChat Sans Std" size:30];
        _zongjiCountLabel.textAlignment = NSTextAlignmentCenter;
        _zongjiCountLabel.numberOfLines = 1;
        _zongjiCountLabel.adjustsFontSizeToFitWidth=YES;
        _zongjiCountLabel.minimumScaleFactor=0.1;
    }
    return _zongjiCountLabel;
}


@end
