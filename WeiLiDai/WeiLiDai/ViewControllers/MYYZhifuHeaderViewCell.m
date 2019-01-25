//
//  MYYZhifuHeaderView.m
//  WeiLiDai
//
//  Created by LONG on 2019/1/4.
//  Copyright © 2019年 j. All rights reserved.
//

#import "MYYZhifuHeaderViewCell.h"

#define refreshImageW (Width_Scall * 72)
#define refreshImageH (Width_Scall * 72)

@implementation MYYZhifuHeaderViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = ColorWithRGB(51, 194, 94, 1);
    self.layer.cornerRadius =10;
    self.layer.cornerRadius =10;
    self.layer.masksToBounds =YES;
//    [self addSubview:_bgView];
    [self addSubview:self.paymentBtn];
    [self addSubview:self.changeBtn];
    [self addSubview:self.cardsBtn];
//    [self addSubview:self.refreshImageView];
    weakify(self);
//    [self.paymentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.mas_left).with.offset(0);
//        make.top.mas_equalTo(weakSelf.mas_top).with.offset(0);
//        make.bottom.mas_equalTo(weakSelf.mas_bottom).with.offset(0);
//    }];
//    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.paymentBtn.mas_right).with.offset(0);
//        make.top.mas_equalTo(weakSelf.mas_top).with.offset(0);
//        make.bottom.mas_equalTo(weakSelf.mas_bottom).with.offset(0);
//    }];
//    [self.cardsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.mas_equalTo(weakSelf.changeBtn.mas_right).with.offset(0);
//        make.top.mas_equalTo(weakSelf.mas_top).with.offset(0);
//        make.bottom.mas_equalTo(weakSelf.mas_bottom).with.offset(0);
//        make.right.mas_equalTo(weakSelf.mas_right).width.offset(0);
//    }];
    
//    // 实现masonry水平固定间隔方法
//    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:10 tailSpacing:10];
//    
//    // 设置array的垂直方向的约束
//    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.mas_equalTo(weakSelf.mas_top).with.offset(0);
//        make.height.mas_equalTo(weakSelf.mas_height).width.offset(0);
//    }];
    
    
}
- (NSMutableArray *)masonryViewArray {
    
    if (!_masonryViewArray) {
        
        _masonryViewArray = [NSMutableArray array];

        [_masonryViewArray addObject:_paymentBtn];
        [_masonryViewArray addObject:_changeBtn];
        [_masonryViewArray addObject:_cardsBtn];
    }
    
    return _masonryViewArray;
}

//-(void)cardsBtnClicked{
//
//}

#pragma mark - 懒加载

-(CollectionHeaderBtn *)paymentBtn{
    if (!_paymentBtn) {
        _paymentBtn = [[CollectionHeaderBtn alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 3, CollectionHeaderViewH)];
        _paymentBtn.nameLabel.text = @"收付款";
        [_paymentBtn.headImageView setImage:[UIImage imageNamed:@"shouFuKuan"]];
        _paymentBtn.moneyLabel.hidden = YES;
    }
    return _paymentBtn;
}

-(CollectionHeaderBtn *)changeBtn{
    if (!_changeBtn) {
        _changeBtn = [[CollectionHeaderBtn alloc] initWithFrame:CGRectMake((self.frame.size.width / 3), 0, self.frame.size.width / 3, CollectionHeaderViewH)];
        _changeBtn.nameLabel.text = @"零钱";
        [_changeBtn.headImageView setImage:[UIImage imageNamed:@"lingQian"]];
    }
    return _changeBtn;
}

-(CollectionHeaderBtn *)cardsBtn{
    if (!_cardsBtn) {
        _cardsBtn = [[CollectionHeaderBtn alloc] initWithFrame:CGRectMake((self.frame.size.width / 3) * 2, 0, self.frame.size.width / 3, CollectionHeaderViewH)];
        _cardsBtn.nameLabel.text = @"银行卡";
        [_cardsBtn.headImageView setImage:[UIImage imageNamed:@"yinHangKa"]];
        _cardsBtn.moneyLabel.hidden = YES;
        //        [_cardsBtn addTarget:self action:@selector(cardsBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cardsBtn;
}

-(UIImageView *)refreshImageView{
    if (!_refreshImageView) {
        //        _refreshImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wechatpay_offline_icon"]];
        _refreshImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logitech_Webcam_Software"]];
        
        _refreshImageView.frame = CGRectMake((self.frame.size.width - refreshImageW) / 2, (self.frame.size.height - refreshImageH) / 2, refreshImageW , refreshImageH);
        _refreshImageView.contentMode = UIViewContentModeScaleAspectFit;
        //        _refreshImageView.layer.masksToBounds = YES;
    }
    return _refreshImageView;
}

- (UIView*)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, CollectionHeaderViewH)];
        _bgView.backgroundColor = ColorWithRGB(51, 194, 94, 1);
        self.layer.cornerRadius =10;
        self.layer.cornerRadius =10;
        self.layer.masksToBounds =YES;
    }
    return _bgView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}


@end
