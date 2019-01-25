//
//  XZJChoseBackCardView.m
//  WeiLiDai
//
//  Created by j on 2018/1/31.
//  Copyright © 2018年 j. All rights reserved.
//

#import "XZJChoseBackCardView.h"
#import "JieQianViewController.h"
#import "BankCardModel.h"

@interface XZJChoseBackCardView()


@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * messageLabel;

@property (nonatomic, strong) UIView * leftLineView;
@property (nonatomic, strong) UIView * rightLineView;

@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, copy) NSString * kahao;

@end

@implementation XZJChoseBackCardView

-(instancetype)initWithFrame:(CGRect)frame firstBankCardIndex:(NSInteger)index cardNum:(NSString *)cardNum{
    if (self = [super initWithFrame:frame]) {
        self.kahao = cardNum;
        self.index = index;
        
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
//    self.layer.borderColor = grayBorderColor.CGColor;
//    self.layer.borderWidth = 1;
//    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    
    NSDictionary * dic = bankCards[self.index];
    NSString * title1 = [NSString stringWithFormat:@"%@ 储蓄卡(%@)",dic[@"bankName"],self.kahao];
    [self.choseBankCardBtn.headImageView setImage:[UIImage imageNamed:dic[@"imageName"]]];
    self.choseBankCardBtn.btnTitleLabel.text = title1;
    self.choseBankCardBtn.index = self.index;
    self.choseBankCardBtn.kahao = self.kahao;
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    cingleTon.bBankCardNumTemp = self.kahao;
    cingleTon.bBankNameTemp = dic[@"bankName"];
    cingleTon.bBankSignIndex = self.index;
    
    self.layer.masksToBounds = NO;
    [self addSubview:self.juChiImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.leftLineView];
    [self addSubview:self.rightLineView];
    [self addSubview:self.choseBankCardBtn];
    [self addSubview:self.messageLabel];
    [self addSubview:self.supportBankBtn];
    weakify(self);
    [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(1));
        make.left.mas_equalTo(weakSelf.mas_left);
        make.top.mas_equalTo(weakSelf.mas_top);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
    }];
    
    [self.rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(1));
        make.right.mas_equalTo(weakSelf.mas_right);
        make.top.mas_equalTo(weakSelf.mas_top);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
    }];
    CGFloat leftX = Width_Scall * 56;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        CGFloat labelH = [weakSelf.titleLabel.text getHeightWithFont:weakSelf.titleLabel.font constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
        make.height.mas_equalTo(@(43/3));
        make.left.mas_equalTo(weakSelf.mas_left).with.offset(leftX);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.top.mas_equalTo(weakSelf.mas_top).with.offset(125/3);
    }];
    
    [self.choseBankCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(155/3));
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(83/3);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        CGSize labelSZ = [weakSelf.messageLabel.text getSizeWithFont:weakSelf.messageLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//        make.size.mas_equalTo(labelSZ);
        make.width.mas_equalTo(weakSelf.bounds.size.width - 40);
        make.left.mas_equalTo(weakSelf.mas_left).with.offset(leftX);
        make.top.mas_equalTo(weakSelf.choseBankCardBtn.mas_bottom).with.offset(42/3);
    }];
    
    [self.supportBankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize labelSZ = [weakSelf.supportBankBtn.titleLabel.text getSizeWithFont:weakSelf.supportBankBtn.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        make.size.mas_equalTo(labelSZ);
        make.right.mas_equalTo(weakSelf.mas_right).with.offset(-leftX);
//        make.left.mas_equalTo(weakSelf.messageLabel.mas_right);
        make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);
    }];
    
}

-(void)choseBankCardBtnClicked:(UIButton *)btn{
    JieQianViewController * jieqianVC = (JieQianViewController *)[XZJChoseBackCardView parentViewController:self];
    if (jieqianVC.chengeBankCardView1.hidden) {
        [jieqianVC.chengeBankCardView1 showView];
    }
    else{
        [jieqianVC.chengeBankCardView1 hideView];
    }
}

+(UIViewController *)parentViewController:(UIView *)obj{
    for (UIView * next = [obj superview]; next; next = next.superview) {
        UIResponder * nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


#pragma mark - 懒加载

-(UIImageView *)juChiImageView{
    if (!_juChiImageView) {
        _juChiImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"choseBankCardJuChi"]];
        _juChiImageView.frame = CGRectMake(0, -Width_Scall * 24.5, self.frame.size.width, Width_Scall * 49);
        _juChiImageView.contentMode = UIViewContentModeScaleAspectFill;
        _juChiImageView.layer.masksToBounds = YES;
        _juChiImageView.backgroundColor = [UIColor clearColor];
    }
    return _juChiImageView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = @"收款银行卡";
        _titleLabel.textColor = ColorWithRGB(139, 139, 139, 1);
        _titleLabel.font = [UIFont boldSystemFontOfSize:CELL_FONTSIZE];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

-(UIView *)leftLineView{
    if (!_leftLineView) {
        _leftLineView = [[UIView alloc] init];
        _leftLineView.backgroundColor = grayBorderColor;
    }
    return _leftLineView;
}

-(UIView *)rightLineView{
    if (!_rightLineView) {
        _rightLineView = [[UIView alloc] init];
        _rightLineView.backgroundColor = grayBorderColor;
    }
    return _rightLineView;
}

-(ChoseBankCardBtn *)choseBankCardBtn{
    if (!_choseBankCardBtn) {
        _choseBankCardBtn = [[ChoseBankCardBtn alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, Width_Scall * 100)];
        _choseBankCardBtn.backgroundColor = [UIColor clearColor];
        [_choseBankCardBtn addTarget:self action:@selector(choseBankCardBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _choseBankCardBtn;
}

-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        SingleTon * singleTon = [SingleTon sharedSingleTon];
        _messageLabel.text = [NSString stringWithFormat:@"每月%@日凌晨优先从该卡自动扣款\n若扣款未成功，将通过微信支付自动扣款",singleTon.kouKuanRi];
        _messageLabel.textColor = eduBGViewTextColor;
        _messageLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE-1];
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

-(UIButton *)supportBankBtn{
    if (!_supportBankBtn) {
        _supportBankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_supportBankBtn setTitle:@"查看支持银行" forState:UIControlStateNormal];
//        CGSize labelSize = [_supportBankBtn.titleLabel.text getSizeWithFont:[UIFont systemFontOfSize:DEFAULT_FONTSIZE] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//        _supportBankBtn.frame = CGRectMake(huanKuanQiShuSubtitleLabelW, self.titltLabel3.frame.origin.y, labelSize.width, labelSize.height);
        [_supportBankBtn setTitleColor:ColorWithRGB(100, 107, 148, 1) forState:UIControlStateNormal];
        [_supportBankBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _supportBankBtn.titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE-1];
    }
    return _supportBankBtn;
}

@end
