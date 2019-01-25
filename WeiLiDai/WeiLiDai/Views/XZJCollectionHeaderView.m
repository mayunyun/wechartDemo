//
//  XZJCollectionHeaderView.m
//  WeiLiDai
//
//  Created by j on 2017/12/18.
//  Copyright © 2017年 j. All rights reserved.
//

#import "XZJCollectionHeaderView.h"

#define refreshImageW (Width_Scall * 72)
#define refreshImageH (Width_Scall * 72)

@implementation XZJCollectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = CollectionHeaderViewBGColor;
    [self addSubview:self.paymentBtn];
    [self addSubview:self.changeBtn];
    [self addSubview:self.cardsBtn];
    [self addSubview:self.refreshImageView];
    
}

//-(void)cardsBtnClicked{
//    
//}

#pragma mark - 懒加载

-(CollectionHeaderBtn *)paymentBtn{
    if (!_paymentBtn) {
        _paymentBtn = [[CollectionHeaderBtn alloc] initWithFrame:CGRectMake(0, CollectionHeaderViewH * 2, self.frame.size.width / 3, CollectionHeaderViewH)];
        _paymentBtn.nameLabel.text = @"收付款";
        [_paymentBtn.headImageView setImage:[UIImage imageNamed:@"shouFuKuan"]];
        _paymentBtn.moneyLabel.hidden = YES;
    }
    return _paymentBtn;
}

-(CollectionHeaderBtn *)changeBtn{
    if (!_changeBtn) {
        _changeBtn = [[CollectionHeaderBtn alloc] initWithFrame:CGRectMake((self.frame.size.width / 3), CollectionHeaderViewH * 2, self.frame.size.width / 3, CollectionHeaderViewH)];
        _changeBtn.nameLabel.text = @"零钱";
        [_changeBtn.headImageView setImage:[UIImage imageNamed:@"lingQian"]];
    }
    return _changeBtn;
}

-(CollectionHeaderBtn *)cardsBtn{
    if (!_cardsBtn) {
        _cardsBtn = [[CollectionHeaderBtn alloc] initWithFrame:CGRectMake((self.frame.size.width / 3) * 2, CollectionHeaderViewH * 2, self.frame.size.width / 3, CollectionHeaderViewH)];
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

@end
