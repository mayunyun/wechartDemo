//
//  EDuView.m
//  WeiLiDai
//
//  Created by j on 2017/12/20.
//  Copyright © 2017年 j. All rights reserved.
//

#import "EDuView.h"


static CGFloat borrowBtnWH = (303/3);

static CGFloat textLabelH = (44/3);

static CGFloat edBGImageViewW = (1051/3);
static CGFloat edBGImageViewH = (272/3);

static CGFloat RMBImageViewW = (74/3);
static CGFloat RMBImageViewH = (100/3);

@implementation EDuView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)resetSize:(CGSize)size{
    self.frame = CGRectMake(0, 0, size.width, size.height);
    weakify(self);
    [self.edBGImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(edBGImageViewW, edBGImageViewH));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        if (size.height == eduBGViewH) {
            make.top.mas_equalTo(weakSelf.mas_top).with.offset(316 / 3);
        }
        else{
            make.top.mas_equalTo(weakSelf.mas_top).with.offset(242 / 3);
        }
        
    }];
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.edBGImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.edLabel];
    [self.edLabel addSubview:self.rmbImageView];
    [self addSubview:self.zEDuLabel];
    [self addSubview:self.borrowBtn];
    [self addSubview:self.hornView];
//    NSLog(@"fonts:%@",[UIFont familyNames]);
    weakify(self);
    [self.edBGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(edBGImageViewW, edBGImageViewH));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(weakSelf.mas_top).with.offset(316 / 3);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(textLabelH));
        make.left.mas_equalTo(weakSelf.edBGImageView.mas_left);
        make.right.mas_equalTo(weakSelf.edBGImageView.mas_right);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.bottom.mas_equalTo(weakSelf.edBGImageView.mas_top).with.offset(-9);
    }];
    [self.hornView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(textLabelH));
        make.left.mas_equalTo(weakSelf.edBGImageView.mas_left);
        make.right.mas_equalTo(weakSelf.edBGImageView.mas_right);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.bottom.mas_equalTo(weakSelf.nameLabel.mas_top).with.offset(-39);
    }];
    [self.hornLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(textLabelH));
        make.centerY.mas_equalTo(weakSelf.hornView);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
        make.centerY.mas_equalTo(weakSelf.hornView);
        make.right.mas_equalTo(weakSelf.hornLabel.mas_left).with.offset(-5);
    }];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(15);
        make.centerY.mas_equalTo(weakSelf.hornView);
        make.right.mas_equalTo(weakSelf.hornLabel.mas_right).with.offset(25);
    }];
    
    [self.zEDuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(textLabelH));
        make.width.mas_equalTo(@(SCREEN_WIDTH));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    make.top.mas_equalTo(weakSelf.edBGImageView.mas_bottom).with.offset(63/3);
    }];
    
    [self.borrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(borrowBtnWH, borrowBtnWH));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(weakSelf.zEDuLabel.mas_bottom).with.offset(94/3);
    }];
    CGSize rmbLabelSZ = CGSizeMake(RMBImageViewW, RMBImageViewH);
    [self.edLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize labelSZ = [weakSelf.edLabel.text getSizeWithFont:weakSelf.edLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        make.size.mas_equalTo(labelSZ);
        make.centerX.mas_equalTo(weakSelf.edBGImageView.mas_centerX).with.offset(rmbLabelSZ.width);
        make.centerY.mas_equalTo(weakSelf.edBGImageView.mas_centerY);
    }];
    
    [self.rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(rmbLabelSZ);
        make.right.mas_equalTo(weakSelf.edLabel.mas_left).with.offset(-30/3);
        make.top.mas_equalTo(weakSelf.edBGImageView.mas_top).with.offset(66/3);
    }];
    
}

-(void)resetEDuLabelData:(NSString *)ned{
    self.edLabel.text = ned;
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    if ([cingleTon.isShowHorn isEqualToString:@"是"]) {
        self.hornView.hidden = NO;
    }else{
        self.hornView.hidden = YES;
    }
//    NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
//    NSString* old = [userdefault objectForKey:DownLi];
//    NSString* new = [userdefault objectForKey:DownLiNew];
    NSString* lirv = [NSString stringWithFormat:@"%0.3f" ,cingleTon.riLiLv];
    NSString* downli = [NSString stringWithFormat:@"%.3f",cingleTon.downLi];
    if ([cingleTon.isShowDownLi isEqualToString:@"是"]) {
        if (!IsEmptyValue(@(cingleTon.downLi))&&!IsEmptyValue(@(cingleTon.riLiLv))&&cingleTon.downLi > cingleTon.riLiLv) {
            NSString* oldLi = [NSString stringWithFormat:@"%@%%",@(downli.floatValue)];
            self.zEDuLabel.text = [NSString stringWithFormat:@"总额度%@%lu，日利率%@%% %@",RMBSign,(unsigned long)cingleTon.borrowCount,@(lirv.floatValue),oldLi];
            [self changeTextColor:self.zEDuLabel Txt:self.zEDuLabel.text changeTxt:oldLi];
        }else{
            self.zEDuLabel.text = [NSString stringWithFormat:@"总额度%@%lu，日利率%@%%",RMBSign,(unsigned long)cingleTon.borrowCount,@(lirv.floatValue)];
        }
    }else {
        self.zEDuLabel.text = [NSString stringWithFormat:@"总额度%@%lu，日利率%@%%",RMBSign,(unsigned long)cingleTon.borrowCount,@(lirv.floatValue)];
    }
    weakify(self);
//    CGSize rmbLabelSZ = [self.rmbLabel.text getSizeWithFont:self.rmbLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize rmbLabelSZ = CGSizeMake(RMBImageViewW, RMBImageViewH);
    [self.edLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGSize labelSZ = [weakSelf.edLabel.text getSizeWithFont:weakSelf.edLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        if (labelSZ.width >= (edBGImageViewW - rmbLabelSZ.width - 45/3)) {
            make.width.mas_equalTo(@(edBGImageViewW - rmbLabelSZ.width - 45/3));
            CGFloat lH = [@"1231" getHeightWithFont:weakSelf.edLabel.font constrainedToSize:CGSizeMake(edBGImageViewW - rmbLabelSZ.width, MAXFLOAT)];
            make.height.mas_equalTo(@(lH));
        }
        else{
            make.width.mas_equalTo(@(labelSZ.width));
            make.height.mas_equalTo(@(labelSZ.height));
        }
         make.centerX.mas_equalTo(weakSelf.edBGImageView.mas_centerX).with.offset(rmbLabelSZ.width / 2);
        make.centerY.mas_equalTo(weakSelf.edBGImageView.mas_centerY).with.offset(-10/3);
    }];
}

#pragma mark - 懒加载
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        _nameLabel.text = @"可借额度";
        _nameLabel.textColor = eduBGViewTextColor;
        _nameLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE - 1];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.numberOfLines = 1;
    }
    return _nameLabel;
}

-(UIImageView *)edBGImageView{
    if (!_edBGImageView) {
        _edBGImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EDuBG"]];
        _edBGImageView.frame = CGRectMake(0, 0, edBGImageViewW, Width_Scall * 164);
        _edBGImageView.contentMode = UIViewContentModeScaleAspectFill;
        _edBGImageView.layer.masksToBounds = YES;
    }
    return _edBGImageView;
}

-(UIButton *)borrowBtn{
    if (!_borrowBtn) {
        _borrowBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, borrowBtnWH, borrowBtnWH)];
//        _borrowBtn.backgroundColor =ColorWithRGB(225, 187, 75, 1);
//        [_borrowBtn setTitle:@"借钱" forState:UIControlStateNormal];
//        _borrowBtn.titleLabel.font = [UIFont boldSystemFontOfSize:CELL_FONTSIZE + 2];
//        [_borrowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_borrowBtn setImage:[UIImage imageNamed:@"borrowBtnImage"] forState:UIControlStateNormal];
        [_borrowBtn setImage:[UIImage imageNamed:@"borrowBtnImageUnable"] forState:UIControlStateDisabled];
        _borrowBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        _borrowBtn.layer.masksToBounds = YES;
        _borrowBtn.layer.cornerRadius = borrowBtnWH / 2;
        
    }
    return _borrowBtn;
}

-(UILabel *)edLabel{
    if (!_edLabel) {
        _edLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        _edLabel.text = @"0";
        _edLabel.textColor = [UIColor blackColor];
//        _edLabel.font = [UIFont fontWithName:@"WeChat Sans SS" size:CELL_FONTSIZE * 4];
        _edLabel.font = [UIFont fontWithName:@"WeChat Sans Std" size:CELL_FONTSIZE * 4];
        _edLabel.textAlignment = NSTextAlignmentCenter;
        _edLabel.numberOfLines = 1;
        _edLabel.adjustsFontSizeToFitWidth=YES;
        _edLabel.minimumScaleFactor=0.1;
    }
    return _edLabel;
}

-(UIImageView *)rmbImageView{
    if (!_rmbImageView) {
        _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RMBBlack"]];
        _rmbImageView.frame = CGRectMake(0, 0, edBGImageViewW, Width_Scall * 164);
        _rmbImageView.contentMode = UIViewContentModeScaleAspectFill;
//        _rmbImageView.layer.masksToBounds = YES;
    }
    return _rmbImageView;
}

//-(UILabel *)rmbLabel{
//    if (!_rmbLabel) {
//        _rmbLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
//        _rmbLabel.text = [NSString stringWithFormat:@"%@",RMBSign];
//        _rmbLabel.textColor = [UIColor blackColor];
////        _rmbLabel.font = [UIFont fontWithName:@"WeChat Sans Std" size:CELL_FONTSIZE * 3];
//        _rmbLabel.font = [UIFont fontWithName:@"WeChat Sans SS" size:CELL_FONTSIZE * 3];
//        _rmbLabel.textAlignment = NSTextAlignmentCenter;
//        _rmbLabel.numberOfLines = 1;
//    }
//    return _rmbLabel;
//}

-(UILabel *)zEDuLabel{
    if (!_zEDuLabel) {
        _zEDuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        NSString* lirv = [NSString stringWithFormat:@"%0.3f" ,cingleTon.riLiLv];
        _zEDuLabel.text = [NSString stringWithFormat:@"总额度%@%lu，日利率%@%%",RMBSign,(unsigned long)cingleTon.borrowCount,@(lirv.floatValue)];
        _zEDuLabel.textColor = eduBGViewTextColor;
        _zEDuLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _zEDuLabel.textAlignment = NSTextAlignmentCenter;
        _zEDuLabel.numberOfLines = 1;
        _zEDuLabel.adjustsFontSizeToFitWidth=YES;
        _zEDuLabel.minimumScaleFactor=0.5;
    }
    return _zEDuLabel;
}

-(UILabel *)hornLabel{
    if (!_hornLabel) {
        _hornLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        _hornLabel.text = cingleTon.hornContent;
        _hornLabel.textColor = yellowHornImageColor;
        _hornLabel.numberOfLines = 1;
        _hornLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE - 1];
        CGSize maximumLabelSize = CGSizeMake(200, 30);
        //关键语句
        CGSize expectSize = [_hornLabel sizeThatFits:maximumLabelSize];
        //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
        _hornLabel.frame = CGRectMake(20, 70, expectSize.width, expectSize.height);
    }
    return _hornLabel;
}
- (UIView*)hornView{
    if (!_hornView) {
        _hornView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        _hornView.backgroundColor = [UIColor clearColor];
        [_hornView addSubview:self.leftView];
        [_hornView addSubview:self.hornLabel];
        [_hornView addSubview:self.rightView];
    }
    return _hornView;
}
- (UIImageView*)leftView{
    if (!_leftView) {
        _leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        _leftView.image = [UIImage imageNamed:@"horn"];
    }
    return _leftView;
}
- (UIImageView*)rightView{
    if (!_rightView) {
        _rightView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        _rightView.image = [UIImage imageNamed:@"yellowRightArraowDown"];
    }
    return _rightView;
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
