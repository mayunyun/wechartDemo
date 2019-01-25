//
//  InputUserInfoView.m
//  WeiLiDai
//
//  Created by j on 2018/2/6.
//  Copyright © 2018年 j. All rights reserved.
//

#import "InputUserInfoView.h"


#define nameViewW (Width_Scall * 573)
#define nameViewH (130/3)
#define whiteBGViewH (633/3)
#define moreBtnH (162/3)

@interface InputUserInfoView()

@property (nonatomic, strong) UIImageView * juChiImageView;
@property (nonatomic, strong) UIView * leftLineView;
@property (nonatomic, strong) UIView * rightLineView;


@property (nonatomic, strong) NSMutableArray * labels;


//@property (nonatomic, strong) UIImageView * arrowImageView;

@end

@implementation InputUserInfoView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    
    self.backgroundColor = grayHuanKuanQiShuBGColor;
    self.layer.masksToBounds = NO;
    [self addSubview:self.juChiImageView];
    [self addSubview:self.whiteBGView];
    [self.whiteBGView addSubview:self.titleLabel];
    [self.whiteBGView addSubview:self.leftLineView];
    [self.whiteBGView addSubview:self.rightLineView];
    [self.whiteBGView addSubview:self.nameView];
    [self.whiteBGView addSubview:self.IdNumView];
//    [self addSubview:self.titleLabel];
//    [self addSubview:self.leftLineView];
//    [self addSubview:self.rightLineView];
//    [self addSubview:self.nameView];
//    [self addSubview:self.IdNumView];
    [self addSubview:self.moreBtn];
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    [self.nameView setValueLabelText:cingleTon.bLastName];
    
    [self.IdNumView setValueLabelText:[NSString stringWithFormat:@"%@**********",cingleTon.bIdCard1]];
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
        make.height.mas_equalTo(@(45/3));
        make.left.mas_equalTo(weakSelf.mas_left).with.offset(leftX);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.top.mas_equalTo(weakSelf.mas_top).with.offset(121/3);
    }];
    
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width - leftX * 2, nameViewH));
        make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(50/3);
    }];
    
    [self.IdNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width - leftX * 2, nameViewH));
        make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.nameView.mas_bottom).with.offset(spaceMargin);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width, moreBtnH));
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    
}

-(void)createLabelsIfBeforeClickMoreBtn:(BOOL)isBefore{
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    NSArray * labelValues = nil;
    if (isBefore) {
        NSString* lilv = @"";
//        NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
//        NSString* old = [userdefault objectForKey:DownLi];
//        NSString* new = [userdefault objectForKey:DownLiNew];
        NSString* lirv = [NSString stringWithFormat:@"%0.3f" ,cingleTon.riLiLv];
        NSString* downli = [NSString stringWithFormat:@"%.3f",cingleTon.downLi];
        if ([cingleTon.isShowDownLi isEqualToString:@"是"]) {
            if (!IsEmptyValue(@(cingleTon.riLiLv))&&!IsEmptyValue(@(cingleTon.downLi))&&cingleTon.downLi>cingleTon.riLiLv) {
                lilv = [NSString stringWithFormat:@"%@%%,%@%%",@(lirv.floatValue),@(downli.floatValue)];
            }else{
                lilv = [NSString stringWithFormat:@"%@%%",@(lirv.floatValue)];
            }
        }else{
            lilv = [NSString stringWithFormat:@"%@%%",@(lirv.floatValue)];
        }
         labelValues = @[@{@"labelTitle":@"借款金额",@"labelValue":[NSString stringWithFormat:@"¥%@",cingleTon.bBorrowCountTemp]},
                                  @{@"labelTitle":@"收款账户",@"labelValue":[NSString stringWithFormat:@"%@(%@)",cingleTon.bBankNameTemp,cingleTon.bBankCardNumTemp]},
                                  @{@"labelTitle":@"日利率",@"labelValue":lilv},
                                  @{@"labelTitle":@"起止时间",@"labelValue":[NSString stringWithFormat:@"%@-%@",cingleTon.bFrondTime,cingleTon.bEndTime]},
                                  @{@"labelTitle":@"首次还款日",@"labelValue":cingleTon.bFirstBackMoneyDate}];
    }
    else{
        NSString* lilv = @"";
//        NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
//        NSString* old = [userdefault objectForKey:DownLi];
//        NSString* new = [userdefault objectForKey:DownLiNew];
        NSString* lirv = [NSString stringWithFormat:@"%0.3f" ,cingleTon.riLiLv];
        NSString* downli = [NSString stringWithFormat:@"%.3f",cingleTon.downLi];
        if ([cingleTon.isShowDownLi isEqualToString:@"是"]) {
            if (!IsEmptyValue(@(cingleTon.riLiLv))&&!IsEmptyValue(@(cingleTon.downLi))&&cingleTon.downLi>cingleTon.riLiLv) {
                lilv = [NSString stringWithFormat:@"%@%%,%@%%",@(lirv.floatValue),@(downli.floatValue)];
            }else{
                lilv = [NSString stringWithFormat:@"%@%%",@(lirv.floatValue)];
            }
        }else{
            lilv = [NSString stringWithFormat:@"%@%%",@(lirv.floatValue)];
        }

        labelValues = @[@{@"labelTitle":@"借款金额",@"labelValue":[NSString stringWithFormat:@"¥%@",cingleTon.bBorrowCountTemp]},
                        @{@"labelTitle":@"收款账户",@"labelValue":[NSString stringWithFormat:@"%@(%@)",cingleTon.bBankNameTemp,cingleTon.bBankCardNumTemp]},
                        @{@"labelTitle":@"日利率",@"labelValue":lilv},
                        @{@"labelTitle":@"起止时间",@"labelValue":[NSString stringWithFormat:@"%@-%@",cingleTon.bFrondTime,cingleTon.bEndTime]},
                        @{@"labelTitle":@"首次还款日",@"labelValue":cingleTon.bFirstBackMoneyDate},
                        @{@"labelTitle":@"还款日",@"labelValue":[NSString stringWithFormat:@"每月%@日",cingleTon.kouKuanRi]},
                        @{@"labelTitle":@"借款期限",@"labelValue":[NSString stringWithFormat:@"%@个月(期)",cingleTon.bQiXian]},
                        @{@"labelTitle":@"借款用途",@"labelValue":@"个人日常消费"},
                        @{@"labelTitle":@"还款银行卡",@"labelValue":[NSString stringWithFormat:@"%@(%@)",cingleTon.bBankNameTemp,cingleTon.bBankCardNumTemp]},
                        @{@"labelTitle":@"贷款发放人",@"labelValue":@"微众银行"}];
    }
    [self createLabelsWithArray:labelValues];
    
    
}



-(void)createLabelsWithArray:(NSArray *)labelValues{
    int i = 0;
    UIView * lastView = self.whiteBGView;
    CGFloat titleLabelW = Width_Scall * 245;
    CGFloat leftX = Width_Scall * 56;
    CGFloat labelH = [@"首次还款日" getHeightWithFont:[UIFont systemFontOfSize:DEFAULT_FONTSIZE] constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
    for (UILabel * label in self.labels) {
        [label removeFromSuperview];
    }
    [self.labels removeAllObjects];
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    weakify(self);
    for (NSDictionary * dic in labelValues) {
        NSString * title = dic[@"labelTitle"];
        NSString * value = dic[@"labelValue"];
        UILabel * label1 = [[UILabel alloc] init];
        label1.text = title;
        label1.textColor = grayHuanKuanQiShuTitleColor;
        label1.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        
        UILabel * label2 = [[UILabel alloc] init];
        label2.textColor = [UIColor blackColor];
        label2.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        if (i == 1 || i == 8) {
            //grayHuanKuanQiShuTitleColor
            label2.attributedText = [InputUserInfoView setAttributeStringWithCoreScring:[NSString stringWithFormat:@"(%@)",cingleTon.bBankCardNumTemp]
                                                                        coreStringColor:[UIColor blackColor]
                                                                         coreStringFont:label2.font
                                                                      formatStringBefor:cingleTon.bBankNameTemp
                                                                      formatStringAfter:nil];
        }else if (i == 2){
            if ([value rangeOfString:@","].location!= NSNotFound) {
                NSArray* array = [value componentsSeparatedByString:@","];
                NSString* result = [NSString stringWithFormat:@"%@ %@",array[0],array[1]];
                label2.text = result;
                [self changeTextColor:label2 Txt:result changeTxt:array[1]];
            }else{
               label2.text = value;
            }
        }
        else{
            label2.text = value;
        }
        
        
        [self.labels addObject:label1];
        [self.labels addObject:label2];
        [self addSubview:label1];
        [self addSubview:label2];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(titleLabelW, labelH));
            make.left.mas_equalTo(weakSelf.mas_left).with.offset(leftX);
            if (i == 0) {
//                make.top.mas_equalTo(lastView.mas_bottom).with.offset(spaceMargin * 2);
                make.top.mas_equalTo(lastView.mas_bottom).with.offset(65/3);
            }
            else{
//                make.top.mas_equalTo(lastView.mas_bottom).with.offset(spaceMargin);
                make.top.mas_equalTo(lastView.mas_bottom).with.offset(45/3);
            }
        }];
        
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@(41/3));
            make.left.mas_equalTo(label1.mas_right);
            make.right.mas_equalTo(weakSelf.mas_right);
            make.centerY.mas_equalTo(label1.mas_centerY);
        }];
        
        lastView = label1;
        i++;
    }
    if (labelValues.count == 10) {
        UILabel * messageLabel = [[UILabel alloc] init];
        messageLabel.textColor = grayHuanKuanQiShuTitleColor;
        messageLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        messageLabel.text = @"请仔细阅读本借据信息，点击确认借钱表示你同意遵守《合同及相关协议》";
        messageLabel.numberOfLines = 0;
        messageLabel.attributedText = [InputUserInfoView setAttributeStringWithCoreScring:@"《合同及相关协议》"
                                                                          coreStringColor:ColorWithRGB(100, 107, 148, 1)
                                                                           coreStringFont:[UIFont systemFontOfSize:DEFAULT_FONTSIZE]
                                                                        formatStringBefor:@"请仔细阅读本借据信息，点击确认借钱表示你同意遵守"
                                                                        formatStringAfter:nil];
        [self addSubview:messageLabel];
        CGFloat messageLabelH = [messageLabel.text getHeightWithFont:[UIFont systemFontOfSize:DEFAULT_FONTSIZE] constrainedToSize:CGSizeMake(self.frame.size.width - leftX - spaceMargin, MAXFLOAT)];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(weakSelf.frame.size.width - leftX - spaceMargin, messageLabelH));
            make.left.mas_equalTo(weakSelf.mas_left).with.offset(leftX);
            make.top.mas_equalTo(lastView.mas_bottom).with.offset(100/3);
        }];

    }
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

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = @"补全身份信息";
        _titleLabel.textColor = ColorWithRGB(139, 139, 139, 1);
        _titleLabel.font = [UIFont boldSystemFontOfSize:CELL_FONTSIZE];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 1;
        
    }
    return _titleLabel;
}

-(XZJWriteNameOrIdNumView *)nameView{
    if (!_nameView) {
        CGFloat leftX = Width_Scall * 56;
        _nameView = [[XZJWriteNameOrIdNumView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - leftX * 2, nameViewH)];
        _nameView.titleLabel.text = @"姓名";
        _nameView.valueTextField.placeholder = @"补全名字";
    }
    return _nameView;
}

-(XZJWriteIdNumView *)IdNumView{
    if (!_IdNumView) {
        CGFloat leftX = Width_Scall * 56;
        _IdNumView = [[XZJWriteIdNumView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - leftX * 2, nameViewH)];
        [_IdNumView.valueTextField setKeyboardType:HTKeyboardTypeNumber];
        [_IdNumView.valueTextField setNumberKeyboardType:HTNumberKeyboardCertNo];
    }
    return _IdNumView;
}

-(UIView *)whiteBGView{
    if (!_whiteBGView) {
        _whiteBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, whiteBGViewH)];
        _whiteBGView.backgroundColor = [UIColor whiteColor];
//        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, whiteBGViewH - 1, self.frame.size.width, 1)];
//        lineView.backgroundColor = grayBorderColor;
//        _whiteBGView.layer.maskedCorners = YES;
        [_whiteBGView addSubview:self.whiteBGViewBottomLineView];
    }
    return _whiteBGView;
}

-(UIView *)whiteBGViewBottomLineView{
    if (!_whiteBGViewBottomLineView) {
        _whiteBGViewBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, whiteBGViewH - 1, self.frame.size.width, 1)];
        _whiteBGViewBottomLineView.backgroundColor = grayBorderColor;
    }
    return _whiteBGViewBottomLineView;
}

-(UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.backgroundColor = [UIColor clearColor];
        _moreBtn.frame = CGRectMake(0, 0, self.frame.size.width, moreBtnH);
        
        _moreBtn.hidden = NO;
        CGFloat arrowImageViewW = Width_Scall * 30;
        CGFloat arrowImageViewH = Width_Scall * 17;
        UIImageView * arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - arrowImageViewW)/2, (moreBtnH - arrowImageViewH) / 2, arrowImageViewW, arrowImageViewH)];
        [arrowImageView setImage:[UIImage imageNamed:@"yellowArraowDown"]];
        arrowImageView.contentMode =UIViewContentModeScaleAspectFill;
        [_moreBtn addSubview:arrowImageView];
    }
    return _moreBtn;
}

-(NSMutableArray *)labels{
    if (!_labels) {
        _labels = [NSMutableArray arrayWithCapacity:0];
    }
    return _labels;
}


/**
 调整字符串中特定字段的颜色和字体大小
 
 @param coreString 目标字符串
 @param coreStringColor 目标颜色
 @param coreStringFont 目标字体
 @param formatStringB 目标字符串前面的字符串
 @param formatStringA 目标字符串后面的字符串
 @return 调成后的字符串
 */
+(NSMutableAttributedString *)setAttributeStringWithCoreScring:(NSString *)coreString
                                               coreStringColor:(UIColor *)coreStringColor
                                                coreStringFont:(UIFont *)coreStringFont
                                             formatStringBefor:(NSString *)formatStringB
                                             formatStringAfter:(NSString *)formatStringA{
    
    NSString * titleString = @"";
    if (formatStringB) {
        titleString = [@"" stringByAppendingFormat:@"%@%@",formatStringB,coreString];
    }
    else{
        titleString = coreString;
    }
    if (formatStringA) {
        titleString = [titleString stringByAppendingString:formatStringA];
    }
    NSMutableAttributedString * hintString = [[NSMutableAttributedString alloc] initWithString:titleString];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1 = [[hintString string] rangeOfString:coreString];
    if (coreStringColor) {
        [hintString addAttribute:NSForegroundColorAttributeName value:coreStringColor range:range1];
    }
    
    if (coreStringFont) {
        [hintString addAttribute:NSFontAttributeName value:coreStringFont range:range1];
    }
    
    
    return hintString;
}

//改变某字符串的颜色
- (void)changeTextColor:(UILabel *)label Txt:(NSString *)text changeTxt:(NSString *)change
{
    //    NSString *str =  @"35";
    NSString *str= change;
    if ([text rangeOfString:str].location != NSNotFound)
    {
        //关键字在字符串中的位置
        NSUInteger location = [text rangeOfString:str].location;
        //长度
        NSUInteger length = [text rangeOfString:str].length;
        //改变颜色之前的转换
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:text];
        //改变颜色
        [str1 addAttribute:NSForegroundColorAttributeName value:LineGrayColor range:NSMakeRange(location, length)];
        [str1 addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(location, length)];
        //赋值
        label.attributedText = str1;
    }
}

@end
