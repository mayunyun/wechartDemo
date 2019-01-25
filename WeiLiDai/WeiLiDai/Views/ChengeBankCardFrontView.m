//
//  ChengeBankCardFrontView.m
//  WeiLiDai
//
//  Created by j on 2018/2/6.
//  Copyright © 2018年 j. All rights reserved.
//

#import "ChengeBankCardFrontView.h"
#import "BankCardModel.h"

#define chengeBankCardBtnH (185/3)
#define chengeBankCardTitleH (151/3)
#define chengeBankCardAddBtnH (154/3)

@implementation ChengeBankCardFrontView

-(instancetype)initWithFrame:(CGRect)frame firstBankCardIndex:(NSInteger)index cardNum:(NSString *)cardNum{
    if (self = [super initWithFrame:frame]) {
        self.kahao = cardNum;
        self.index = index;
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 17/3;
    [self addSubview:self.titleLabel];
    [self addSubview:self.closeBtn];
//    [self addSubview:self.bankCardBtn1];
//    [self addSubview:self.bankCardBtn2];
//    [self addSubview:self.bankCardBtn3];
//    [self addSubview:self.bankCardBtn4];
    weakify(self);
//    CGFloat labelH = Width_Scall * 100;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width, chengeBankCardTitleH));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(weakSelf.mas_top);
    }];
    
    CGFloat closeBtnWH = Width_Scall * 36;
    self.closeBtn.frame = CGRectMake(0, 0, closeBtnWH, closeBtnWH);
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(closeBtnWH, closeBtnWH));
        make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.mas_right).with.offset(-spaceMargin);
    }];
    
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    UIView * lastView = self.titleLabel;
    
    for (BankCardModel * model in cingleTon.bankCardModels) {
        ChoseBankCardBtn * btn = [[ChoseBankCardBtn alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, chengeBankCardBtnH)];
        NSString * title = [NSString stringWithFormat:@"%@ 储蓄卡(%@)",model.bBankName,model.bBankCardNum];
        [btn.headImageView setImage:[UIImage imageNamed:model.bBankSignImageName]];
        btn.btnTitleLabel.text = title;
        btn.index = model.bBankSignIndex;
        btn.kahao = model.bBankCardNum;
        [self.btnArray addObject:btn];
        [self addSubview:btn];
        btn.layer.borderWidth = 0;
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(46/3, chengeBankCardBtnH-1, self.frame.size.width - 46/3, 1)];
        lineView.backgroundColor = grayBorderColor;
        [btn addSubview:lineView];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width, chengeBankCardBtnH));
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
//            make.top.mas_equalTo(lastView.mas_bottom).with.offset(-1);
            make.top.mas_equalTo(lastView.mas_bottom);
        }];
        lastView = btn;
    }
    
    [self addSubview:self.addBankCardBtn];
    if (cingleTon.bankCardModels.count == maxCardNum) {
        self.addBankCardBtn.hidden = YES;
    }
    else{
        self.addBankCardBtn.hidden = NO;
    }
    [self bringSubviewToFront:self.titleLabel];
    
}

#pragma mark - 懒加载

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"更换银行卡";
        _titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 4];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, chengeBankCardTitleH-2, self.frame.size.width, 1)];
        lineView.backgroundColor = grayBorderColor;
        [_titleLabel addSubview:lineView];
    }
    return _titleLabel;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    return _closeBtn;
}

-(ChoseBankCardBtn *)bankCardBtn1{
    if (!_bankCardBtn1) {
        _bankCardBtn1 = [[ChoseBankCardBtn alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, Width_Scall * 100)];
    }
    return _bankCardBtn1;
}

-(ChoseBankCardBtn *)bankCardBtn2{
    if (!_bankCardBtn2) {
        _bankCardBtn2 = [[ChoseBankCardBtn alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, Width_Scall * 100)];
    }
    return _bankCardBtn2;
}

-(ChoseBankCardBtn *)bankCardBtn3{
    if (!_bankCardBtn3) {
        _bankCardBtn3 = [[ChoseBankCardBtn alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, Width_Scall * 100)];
    }
    return _bankCardBtn3;
}


-(ChoseBankCardBtn *)bankCardBtn4{
    if (!_bankCardBtn4) {
        _bankCardBtn4 = [[ChoseBankCardBtn alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, Width_Scall * 100)];
    }
    return _bankCardBtn4;
}


-(UIButton *)addBankCardBtn{
    if (!_addBankCardBtn) {
        _addBankCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBankCardBtn.frame = CGRectMake(0, self.frame.size.height - chengeBankCardAddBtnH, self.frame.size.width, chengeBankCardAddBtnH);
//        [_addBankCardBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
//        [_addBankCardBtn setTitle:@"添加新的储蓄卡" forState:UIControlStateNormal];
        CGFloat leftX = Width_Scall * 56;
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, 0, self.frame.size.width - leftX , chengeBankCardAddBtnH)];
        titleLabel.text = @"添加新的储蓄卡";
        titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 2];
        [_addBankCardBtn addSubview:titleLabel];
        _addBankCardBtn.backgroundColor = [UIColor whiteColor];
        
        CGFloat rightArrowViewW = Width_Scall * 36;
        CGFloat rightArrowViewH = Width_Scall * 36;
        UIImageView * rightArrowView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - spaceMargin - rightArrowViewW, (chengeBankCardAddBtnH - rightArrowViewH) / 2, rightArrowViewW, rightArrowViewH)];
        [rightArrowView setImage:[UIImage imageNamed:@"rightArraowRight"]];
        rightArrowView.contentMode = UIViewContentModeScaleAspectFill;
        [_addBankCardBtn addSubview:rightArrowView];
    }
    return _addBankCardBtn;
}

-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _btnArray;
}


@end
