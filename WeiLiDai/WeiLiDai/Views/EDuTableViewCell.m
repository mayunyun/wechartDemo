//
//  EDuTableViewCell.m
//  WeiLiDai
//
//  Created by j on 2018/2/11.
//  Copyright © 2018年 j. All rights reserved.
//

#import "EDuTableViewCell.h"
#import "UIColor+HTRGB.h"

static CGFloat textLabelSize = (DEFAULT_FONTSIZE - 1);

@implementation EDuTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.rmbImageView];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.bankLabel];
    [self.contentView addSubview:self.rightArrowView];
    weakify(self);
    CGFloat leftX = Width_Scall * 56;
    CGFloat moneyLabelNumFontSize = CELL_FONTSIZE + 13.5;
//    CGFloat rmbSignLabelFontSize = moneyLabelNumFontSize / 4 * 3;
//    self.rmbLabel.font = [UIFont fontWithName:@"WeChat Sans Std" size:rmbSignLabelFontSize];
    [self.rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        CGSize labelSZ = [weakSelf.rmbLabel.text getSizeWithFont:[UIFont fontWithName:@"WeChat Sans Std" size:rmbSignLabelFontSize] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGSize labelSZ = CGSizeMake(34/3, 46/3);
        make.size.mas_equalTo(CGSizeMake(labelSZ.width, labelSZ.height));
        make.top.mas_equalTo(weakSelf.moneyLabel.mas_top).with.offset(21/3);
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(leftX);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize labelSZ = [weakSelf.moneyLabel.text getSizeWithFont:[UIFont fontWithName:@"WeChat Sans Std" size:moneyLabelNumFontSize] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//        make.size.mas_equalTo(CGSizeMake(labelSZ.width, labelSZ.height));
//        NSLog(@"labelSZ.height:%lf",labelSZ.height);
        make.height.mas_equalTo(@(labelSZ.height));
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.left.mas_equalTo(weakSelf.rmbImageView.mas_right).with.offset(17/3);
    }];
    
    CGFloat rightArrowViewW = Width_Scall * 36;
    CGFloat rightArrowViewH = Width_Scall * 36;
    [self.rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(rightArrowViewW, rightArrowViewH));
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-spaceMargin);
        make.left.mas_equalTo(weakSelf.moneyLabel.mas_right);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat labelH = [weakSelf.dateLabel.text getHeightWithFont:weakSelf.dateLabel.font constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
        make.height.mas_equalTo(@(labelH));
        make.left.mas_equalTo(weakSelf.rmbImageView.mas_left);
        make.right.mas_equalTo(weakSelf.contentView.mas_right);
        make.bottom.mas_equalTo(weakSelf.rmbImageView.mas_top).with.offset(-38/3);
//        make.top.mas_equalTo(weakSelf.contentView.mas_top).with.offset(14/3);
    }];
    
    [self.bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat labelH = [weakSelf.bankLabel.text getHeightWithFont:weakSelf.bankLabel.font constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
        make.height.mas_equalTo(@(labelH));
        make.left.mas_equalTo(weakSelf.rmbImageView.mas_left);
        make.right.mas_equalTo(weakSelf.contentView.mas_right);
//        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).with.offset(-14/3);
        make.top.mas_equalTo(weakSelf.rmbImageView.mas_bottom).with.offset(46/3);
    }];
    
    
}

-(void)setCellDataWithDict:(NSDictionary *)dic{
    self.dateLabel.text = [NSString stringWithFormat:@"%@应还",dic[@"returnMoneyDate"]];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@",dic[@"returnMoneyCount"]];
    self.bankLabel.text = [NSString stringWithFormat:@"从%@储蓄卡(%@)自动扣款",dic[@"bankCardName"],dic[@"bankCardNum"]];
}

-(void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 懒加载
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _dateLabel.text = @"00月00日应还";
        _dateLabel.textColor = ColorWithRGB(112, 112, 112, 1);
        _dateLabel.font = [UIFont systemFontOfSize:textLabelSize];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.numberOfLines = 1;
    }
    return _dateLabel;
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


//-(UILabel *)rmbLabel{
//    if (!_rmbLabel) {
//        _rmbLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//        _rmbLabel.text = [NSString stringWithFormat:@"%@",RMBSign];
//        _rmbLabel.textColor = [UIColor blackColor];
//        _rmbLabel.font = [UIFont fontWithName:@"WeChat Sans Std" size:CELL_FONTSIZE];
//        _rmbLabel.textAlignment = NSTextAlignmentLeft;
//        _rmbLabel.numberOfLines = 1;
//    }
//    return _rmbLabel;
//}


-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
//        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        _moneyLabel.text = @"8888.00";//[NSString stringWithFormat:@"   %@",cingleTon.bBorrowCount];
        _moneyLabel.font = [UIFont fontWithName:@"WeChat Sans Std" size:CELL_FONTSIZE + 13.5];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
//        _moneyLabel.textColor = ColorWithRGB(96, 96, 96, 1);
        _moneyLabel.textColor = [UIColor colorWithHTRGB:0x464440];
        _moneyLabel.numberOfLines = 0;
        
    }
    return _moneyLabel;
}

-(UILabel *)bankLabel{
    if (!_bankLabel) {
        _bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _bankLabel.text = @"从XX银行储蓄卡(8888)自动扣款";
        _bankLabel.textColor = ColorWithRGB(164, 164, 164, 1);
        _bankLabel.font = [UIFont systemFontOfSize:textLabelSize];
        _bankLabel.textAlignment = NSTextAlignmentLeft;
        _bankLabel.numberOfLines = 1;
    }
    return _bankLabel;
}

-(UIImageView *)rightArrowView{
    if (!_rightArrowView) {
        CGFloat rightArrowViewW = Width_Scall * 36;
        CGFloat rightArrowViewH = Width_Scall * 36;
        _rightArrowView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - spaceMargin - rightArrowViewW, (self.frame.size.height - rightArrowViewH) / 2, rightArrowViewW, rightArrowViewH)];
        [_rightArrowView setImage:[UIImage imageNamed:@"rightArraowRight"]];
        _rightArrowView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _rightArrowView;
}


@end
