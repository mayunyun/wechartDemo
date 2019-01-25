//
//  ChoseSupportBankFrontView.m
//  WeiLiDai
//
//  Created by j on 2018/3/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import "ChoseSupportBankFrontView.h"

static CGFloat titleLabelH = 1424/3;

@implementation ChoseSupportBankFrontView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 14/3;
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.doneBtn];
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        CGFloat leftX = 87/3;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, 78/3, self.frame.size.width - leftX * 2, titleLabelH)];
        NSString * banks = @"";
        int i = 0;
        for (NSDictionary * dic in bankCardsFull) {
            NSString * bankName = dic[@"bankName"];
            banks = [banks stringByAppendingString:bankName];
            if (i < bankCardsFull.count - 1) {
                banks = [banks stringByAppendingString:@"、"];
            }
            i++;
        }
        _titleLabel.text = banks;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 2];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:banks];
        // 调整行间距
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        // 设置文字居中
        paragraphStyle1.alignment = NSTextAlignmentCenter;
        [paragraphStyle1 setLineSpacing:2];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [banks length])];
        [_titleLabel setAttributedText:attributedString1];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleLabelH, self.frame.size.width, 1)];
        _lineView.backgroundColor = ColorWithRGB(209, 209, 209, 1);
    }
    return _lineView;
}

-(UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneBtn.frame = CGRectMake(0, titleLabelH+1, self.frame.size.width, 160/3);
        [_doneBtn setTitle:@"知道了" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:ColorWithRGB(84, 184, 53, 1) forState:UIControlStateNormal];
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 1];
        //        [_doneBtn addTarget:self action:@selector(doneBtnCLicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

@end
