//
//  AlertHeadImageTableViewCell.m
//  WeiLiDai
//
//  Created by j on 2018/2/24.
//  Copyright © 2018年 j. All rights reserved.
//

#import "AlertHeadImageTableViewCell.h"

@implementation AlertHeadImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    [self.contentView addSubview:self.headImageView];
    self.textLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
    self.textLabel.textColor = [UIColor blackColor];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
-(UIImageView *)headImageView{
    if (!_headImageView) {
        CGFloat imageWH = self.frame.size.height - Width_Scall * 18 * 2;
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - imageWH - Width_Scall * 80, (self.frame.size.height - imageWH) / 2, imageWH, imageWH)];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

@end
