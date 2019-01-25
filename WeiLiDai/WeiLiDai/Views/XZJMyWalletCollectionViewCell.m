//
//  XZJMyWalletCollectionViewCell.m
//  WeiLiDai
//
//  Created by j on 2017/12/18.
//  Copyright © 2017年 j. All rights reserved.
//

#import "XZJMyWalletCollectionViewCell.h"

#define headImageViewWH (Width_Scall * 58)
#define spaceH (Width_Scall * 10)

@implementation XZJMyWalletCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.headImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.rightLine];
    [self addSubview:self.bottomLine];
    weakify(self);
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(headImageViewWH, headImageViewWH));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.bottom.mas_equalTo(weakSelf.mas_centerY).with.offset(-spaceH);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(30));
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(weakSelf.mas_centerY).with.offset(spaceH);
    }];
    
}

#pragma mark - 懒加载

-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _headImageView.frame = CGRectMake(0, 0, headImageViewWH, headImageViewWH);
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        _nameLabel.text = @"组头标题";
//        _nameLabel.textColor = ColorWithRGB(113, 111, 118, 1);
        _nameLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.numberOfLines = 1;
    }
    return _nameLabel;
}

-(UIView *)rightLine{
    if (!_rightLine) {
        _rightLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, 1, self.frame.size.height)];
        _rightLine.backgroundColor = TableViewBGColor;
    }
    return _rightLine;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 1)];
        _bottomLine.backgroundColor = TableViewBGColor;
    }
    return _bottomLine;
}

@end
