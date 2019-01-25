//
//  BorrowMoneyView.m
//  WeiLiDai
//
//  Created by j on 2017/12/21.
//  Copyright © 2017年 j. All rights reserved.
//

#import "BorrowMoneyView.h"
#import "UIColor+HTRGB.h"

static CGFloat textFieldH = 350/3;

@implementation BorrowMoneyView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.nameLabel];
    [self addSubview:self.rmbImageView];
    [self addSubview:self.moneyTextField];
    [self addSubview:self.lineView1];
    [self addSubview:self.infoLabel];
    [self addSubview:self.starImgView];
    weakify(self);
    CGFloat leftX = Width_Scall * 56;
    CGFloat signLableHSpace = 104/3;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 42/3));
        make.left.mas_equalTo(weakSelf.mas_left).with.offset(leftX);
        make.top.mas_equalTo(weakSelf.mas_top).with.offset(142/3);
        make.bottom.mas_equalTo(weakSelf.rmbImageView.mas_top).with.offset(-signLableHSpace);
    }];
//    CGSize labelSz = [BorrowMoneyView sizeWidthString:RMBSign andFont:self.signLabel.font];
    [self.rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(66/3, 91/3));
        make.left.mas_equalTo(weakSelf.nameLabel.mas_left);
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).with.offset(signLableHSpace);
        make.bottom.mas_equalTo(weakSelf.lineView1.mas_top).with.offset(-signLableHSpace);
//        make.right.mas_equalTo(weakSelf.moneyTextField.mas_left).with.offset(-20/3);
    }];
    [self.moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(textFieldH));
        make.left.mas_equalTo(weakSelf.rmbImageView.mas_right).with.offset(20/3);
        make.centerY.mas_equalTo(weakSelf.rmbImageView.mas_centerY);
        make.right.mas_equalTo(weakSelf.mas_right).with.offset(-leftX);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - leftX * 2, 1));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(weakSelf.rmbImageView.mas_bottom).with.offset(signLableHSpace);
//        make.bottom.mas_equalTo(weakSelf.infoLabel.mas_top).with.offset(-Width_Scall * 27);
    }];
    [self.starImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 14));
        make.left.mas_equalTo(weakSelf.mas_left).with.offset(leftX);
//        make.top.mas_equalTo(weakSelf.mas_top).with.offset(142/3);
//        make.bottom.mas_equalTo(weakSelf.rmbImageView.mas_top).with.offset(-signLableHSpace);
        make.top.mas_equalTo(weakSelf.lineView1.mas_bottom).with.offset(45/3);
        
    }];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - leftX * 2 - 30, 45/3));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(weakSelf.lineView1.mas_bottom).with.offset(45/3);
        //        make.bottom.mas_equalTo(weakSelf.signLabel.mas_top).with.offset(-Width_Scall * 60);
    }];
    
}

+(CGSize)sizeWidthString:(NSString * _Nullable)string
                 andFont:(UIFont * _Nullable)font{
    return [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
}

#pragma mark - 懒加载
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.text = @"借钱金额";
        _nameLabel.textColor = ColorWithRGB(139, 139, 139, 1);
        _nameLabel.font = [UIFont boldSystemFontOfSize:CELL_FONTSIZE];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.numberOfLines = 1;
    }
    return _nameLabel;
}

-(UIImageView *)rmbImageView{
    if (!_rmbImageView) {
        _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RMBGray"]];
        _rmbImageView.frame = CGRectMake(0, 0, 0, Width_Scall * 164);
        _rmbImageView.contentMode = UIViewContentModeScaleAspectFill;
        //        _rmbImageView.layer.masksToBounds = YES;
    }
    return _rmbImageView;
}

-(UITextField *)moneyTextField{
    if (!_moneyTextField) {
        _moneyTextField = [[UITextField alloc] init];
        _moneyTextField.frame = CGRectMake(0, 0, 100, textFieldH);
        _moneyTextField.font = [UIFont fontWithName:@"WeChat Sans SS" size:178/3];
        _moneyTextField.textColor = [UIColor colorWithHTRGB:0x464440];
        _moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
//        _moneyTextField.adjustsFontSizeToFitWidth=YES;
//        _moneyTextField.minimumScaleFactor=0.5;
        _moneyTextField.tintColor = ColorWithRGB(70, 111, 239, 1);
    }
    return _moneyTextField;
}

-(UIView *)lineView1{
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView1.backgroundColor = ColorWithRGB(233, 233, 233, 1);
    }
    return _lineView1;
}

-(UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
//        NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
//        NSString* old = [userDefault objectForKey:DownLi];
//        NSString* new = [userDefault objectForKey:DownLiNew];
        NSString* lirv = [NSString stringWithFormat:@"%0.3f" ,cingleTon.riLiLv];
        NSString* downli = [NSString stringWithFormat:@"%.3f",cingleTon.downLi];
        _infoLabel.textColor = eduBGViewTextColor;//ColorWithRGB(188, 188, 188, 1);
        if ([cingleTon.isShowDownLi isEqualToString:@"是"]) {
            if (!IsEmptyValue(@(cingleTon.riLiLv))&&!IsEmptyValue(@(cingleTon.downLi))&&cingleTon.downLi>cingleTon.riLiLv) {
                NSString* oldLi = [NSString stringWithFormat:@"%@%%",@(downli.floatValue)];
                _infoLabel.text = [NSString stringWithFormat:@" 按日计息，日利率%@%% %@",@(lirv.floatValue),oldLi];//@" ※ 按日计息，日利率0.05%";// ※
                [self changeTextColor:_infoLabel Txt:_infoLabel.text changeTxt:oldLi];
            }else{
                _infoLabel.text = [NSString stringWithFormat:@"按日计息，日利率%@%%",@(lirv.floatValue)];//@" ※ 按日计息，日利率0.05%";// ※
            }
        }else{
            _infoLabel.text = [NSString stringWithFormat:@"按日计息，日利率%@%%",@(lirv.floatValue)];//@" ※ 按日计息，日利率0.05%";// ※
        }

        _infoLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _infoLabel.textAlignment = NSTextAlignmentLeft;
        _infoLabel.numberOfLines = 1;
    }
    return _infoLabel;
}
- (UIImageView*)starImgView{
    if (!_starImgView) {
        _starImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        _starImgView.image = [UIImage imageNamed:@"利息符号"];
    }
    return _starImgView;
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
