//
//  XZJDetailTypeCell.m
//  gongxigongxi
//
//  Created by iMac on 2017/5/9.
//  Copyright © 2017年 FangLian. All rights reserved.
//

#import "XZJDetailTypeCell.h"
#import "Masonry.h"

@implementation XZJDetailTypeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.headIconView];
    [self.contentView addSubview:self.cellTitleLabel];
    [self.contentView addSubview:self.cellSubtitleLabel];
    [self.contentView addSubview:self.rightArrowView];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.badgeView];
    self.badgeView.hidden =  YES;
    self.headImageView.hidden = YES;
    self.lineView.hidden = YES;
    self.rightArrowView.hidden = YES;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    weakify(self);
    CGFloat labelHeight = 30;
    [self.headIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width_Scall * 46, Width_Scall * 47));
        make.left.mas_equalTo(weakSelf.contentView.mas_left).with.offset(spaceMargin);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.right.mas_equalTo(weakSelf.cellTitleLabel.mas_left).with.offset(-spaceMargin);
    }];
    
    [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(labelHeight));
        make.left.mas_equalTo(weakSelf.headIconView.mas_right).with.offset(spaceMargin);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.right.equalTo(weakSelf.cellSubtitleLabel.mas_left);
    }];
    
    [self.cellSubtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(labelHeight));
        make.width.mas_equalTo(@(labelHeight));
        make.left.equalTo(weakSelf.cellTitleLabel.mas_right);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.right.mas_equalTo(weakSelf.rightArrowView.mas_left).with.offset(-spaceMargin);
    }];
    
    [self.rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width_Scall * 15, Width_Scall * 26));
        make.left.mas_equalTo(weakSelf.cellSubtitleLabel.mas_right).with.offset(spaceMargin);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-spaceMargin);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(1));
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).with.offset(1);
        make.left.mas_equalTo(weakSelf.cellTitleLabel.mas_left);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(30);
    }];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width_Scall * 66, Width_Scall * 65));
        make.left.mas_equalTo(weakSelf.cellSubtitleLabel.mas_left).with.offset(spaceMargin);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).with.offset(-spaceMargin);
    }];
    [self.badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width_Scall * 20, Width_Scall * 20));
        make.left.mas_equalTo(weakSelf.headImageView.mas_right).with.offset(-3);
        make.top.equalTo(weakSelf.headImageView.mas_top).with.offset(-3);
    }];
}

-(void)setCellData:(NSDictionary *)dic{
    [self.headIconView setImage:[UIImage imageNamed:[dic objectForKey:@"headImage"]]];
    self.cellTitleLabel.text = [dic objectForKey:@"cellTitle"];
    self.cellSubtitleLabel.text = [dic objectForKey:@"cellSubtitle"];
    weakify(self);
    CGFloat labelHeight = 30;
    [self.cellSubtitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(labelHeight));
        make.width.mas_equalTo(@(labelHeight));
        make.left.equalTo(weakSelf.cellTitleLabel.mas_right);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.mas_equalTo(weakSelf.rightArrowView.mas_left).with.offset(-spaceMargin);
    }];
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
-(UIImageView *)headIconView{
    if (!_headIconView) {
        _headIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width_Scall * 44, Width_Scall * 44)];
        _headIconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _headIconView;
}

-(UILabel *)cellTitleLabel{
    if (!_cellTitleLabel) {
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        _cellTitleLabel.textColor = [UIColor blackColor];
        _cellTitleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
        _cellTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _cellTitleLabel;
}

-(UILabel *)cellSubtitleLabel{
    if (!_cellSubtitleLabel) {
        _cellSubtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        _cellSubtitleLabel.textColor = SubtitleColor;
        _cellSubtitleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _cellSubtitleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _cellSubtitleLabel;
}

-(UIImageView *)rightArrowView{
    if (!_rightArrowView) {
        CGFloat rightArrowViewW = Width_Scall * 17;
        CGFloat rightArrowViewH = Width_Scall * 25;
        _rightArrowView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - Width_Scall * 40 - rightArrowViewW, (self.frame.size.height - rightArrowViewH) / 2, rightArrowViewW, rightArrowViewH)];
        [_rightArrowView setImage:[UIImage imageNamed:@"arrow_ico"]];
        _rightArrowView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _rightArrowView;
}
- (UIView*)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(40, self.frame.size.height - 1, self.frame.size.width - 40, 1)];
        _lineView.backgroundColor = grayBorderColor;
    }
    return _lineView;
}

//-(UIImageView *)rightArrowView{
//    if (!_rightArrowView) {
//        _rightArrowView = [XZJFactoryFunc createImageViewWithFrame:CGRectMake(0, 0, Width_Scall * 10, Width_Scall * 23)
//                                                             imageName:@"arrow"
//                                                       contentMode:UIViewContentModeScaleAspectFit];
//    }
//    return _rightArrowView;
//}

#pragma mark - 懒加载
-(UIImageView *)headImageView{
    if (!_headImageView) {
        CGFloat imageWH = self.frame.size.height - Width_Scall * 18 * 2;
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - imageWH - Width_Scall * 80, (self.frame.size.height - imageWH) / 2, imageWH, imageWH)];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

- (UIView*)badgeView{
    if (!_badgeView) {
        //新建小红点
        _badgeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        _badgeView.layer.cornerRadius = 5;
        _badgeView.backgroundColor = ColorWithRGB(250, 81, 80, 1);//[UIColor redColor];
//        CGRect tabFrame = self.headImageView.frame;
//        //确定小红点的位置
//        CGFloat badgePianyi = 0.57;
//        float percentX = badgePianyi;
//        CGFloat x = ceilf(percentX * tabFrame.size.width);
//        CGFloat y = ceilf(0.1 * tabFrame.size.height);
//        _badgeView.frame = CGRectMake(x, y, 10, 10);
    }
    return _badgeView;
}

@end
