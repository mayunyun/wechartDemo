//
//  XZJMineHeadTableViewCell.m
//  WeiLiDai
//
//  Created by j on 2018/2/20.
//  Copyright © 2018年 j. All rights reserved.
//
#define refreshImageW (Width_Scall * 72)
#define refreshImageH (Width_Scall * 72)
#import "XZJMineHeadTableViewCell.h"

@implementation XZJMineHeadTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.refreshImageView];
    [self.contentView addSubview:self.headIconView];
    [self.contentView addSubview:self.cellTitleLabel];
    [self.contentView addSubview:self.cellSubtitleLabel];
    [self.contentView addSubview:self.erweimaImageView];
    [self.contentView addSubview:self.rightArrowView];
    self.rightArrowView.hidden = YES;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    weakify(self);
    CGFloat headIconViewWH = Width_Scall * 128;
    [self.headIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(headIconViewWH, headIconViewWH));
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(spaceMargin*2);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.headIconView.mas_right).with.offset(spaceMargin);
        make.top.mas_equalTo(weakSelf.headIconView.mas_top).with.offset(Width_Scall * 10);
        make.bottom.mas_equalTo(weakSelf.headIconView.mas_centerY);
        make.right.mas_equalTo(weakSelf.erweimaImageView.mas_left);
    }];
    
    [self.cellSubtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.cellTitleLabel.mas_left);
        make.bottom.mas_equalTo(weakSelf.headIconView.mas_bottom).with.offset(-Width_Scall * 10);
        make.top.mas_equalTo(weakSelf.headIconView.mas_centerY);
        make.right.mas_equalTo(weakSelf.cellTitleLabel.mas_right);
    }];
    CGFloat erweimaImageViewWH = Width_Scall * 34;
    [self.erweimaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(erweimaImageViewWH, erweimaImageViewWH));
        make.left.mas_equalTo(weakSelf.cellTitleLabel.mas_right).with.offset(10);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
//        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-Width_Scall * 84);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-10);
    }];
    
    [self.rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width_Scall * 27, Width_Scall * 27));
//        make.left.mas_equalTo(weakSelf.erweimaImageView.mas_right).with.offset(Width_Scall * 21);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-spaceMargin);
    }];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.headIconView.backgroundColor = [UIColor lightGrayColor];
//    self.erweimaImageView.backgroundColor = [UIColor lightGrayColor];
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    self.headIconView.backgroundColor = [UIColor lightGrayColor];
//    self.erweimaImageView.backgroundColor = [UIColor lightGrayColor];
}

#pragma mark - 懒加载
-(UIImageView *)headIconView{
    if (!_headIconView) {
        _headIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width_Scall * 44, Width_Scall * 44)];
        _headIconView.layer.masksToBounds = YES;
        _headIconView.contentMode = UIViewContentModeScaleAspectFill;
        _headIconView.layer.cornerRadius = Width_Scall * 8;
        _headIconView.backgroundColor = [UIColor lightGrayColor];
    }
    return _headIconView;
}

-(UILabel *)cellTitleLabel{
    if (!_cellTitleLabel) {
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        _cellTitleLabel.textColor = [UIColor blackColor];
//        _cellTitleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 3];
        [_cellTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:CELL_FONTSIZE + 3]];
        _cellTitleLabel.textAlignment = NSTextAlignmentLeft;
        _cellTitleLabel.text = @"微信昵称";
    }
    return _cellTitleLabel;
}

-(UILabel *)cellSubtitleLabel{
    if (!_cellSubtitleLabel) {
        _cellSubtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        _cellSubtitleLabel.textColor = [UIColor blackColor];
        _cellSubtitleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE+1];
        _cellSubtitleLabel.textColor = grayMineTitleColor;
        _cellSubtitleLabel.textAlignment = NSTextAlignmentLeft;
        _cellSubtitleLabel.text = @"微信号：xxxxxx";
    }
    return _cellSubtitleLabel;
}

-(UIImageView *)erweimaImageView{
    if (!_erweimaImageView) {
        _erweimaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width_Scall * 44, Width_Scall * 44)];
        _erweimaImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _erweimaImageView.backgroundColor = [UIColor lightGrayColor];
        [_erweimaImageView setImage:[UIImage imageNamed:@"我页面的小二维码"]];
    }
    return _erweimaImageView;
}

-(UIImageView *)rightArrowView{
    if (!_rightArrowView) {
        CGFloat rightArrowViewW = Width_Scall * 36;
        CGFloat rightArrowViewH = Width_Scall * 36;
        _rightArrowView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - Width_Scall * 40 - rightArrowViewW, (self.frame.size.height - rightArrowViewH) / 2, rightArrowViewW, rightArrowViewH)];
        [_rightArrowView setImage:[UIImage imageNamed:@"jiantou"]];
        _rightArrowView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _rightArrowView;
}

-(UIImageView *)refreshImageView{
    if (!_refreshImageView) {
//        _refreshImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logitech_Webcam_Software"]];
//        _refreshImageView.frame = CGRectMake((self.frame.size.width - refreshImageW) / 2, -100, refreshImageW , refreshImageH);
//        _refreshImageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage* image = [FactryFucClass imageWithColor:[UIColor whiteColor]];
        _refreshImageView = [[UIImageView alloc]initWithImage:image];
        _refreshImageView.frame = CGRectMake(0, -100, SCREEN_WIDTH , 100);
    }
    return _refreshImageView;
}

@end
