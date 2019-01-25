//
//  CollectionHeaderBtn.m
//  WeiLiDai
//
//  Created by j on 2017/12/20.
//  Copyright © 2017年 j. All rights reserved.
//

#import "CollectionHeaderBtn.h"

#define headImageViewWH (Width_Scall * 70)
#define spaceH (Width_Scall * 30)

@implementation CollectionHeaderBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        [self setBackgroundImage:[CollectionHeaderBtn imageWithColor:ColorWithRGB(87, 95, 101, 1)] forState:UIControlStateHighlighted];
    }
    return self;
}

-(void)createUI{
//    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.headImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.moneyLabel];
    weakify(self);
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(headImageViewWH, headImageViewWH));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.bottom.mas_equalTo(weakSelf.nameLabel.mas_top).with.offset(-spaceH);
    }];
    CGFloat moneySpace = 5;
    CGSize labelSize = [CollectionHeaderBtn sizeWidthString:@"哈哈" andFont:self.nameLabel.font];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(labelSize.height));
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(weakSelf.mas_centerY);
//        make.top.mas_equalTo(weakSelf.headImageView.mas_bottom).with.offset(spaceH);
        make.bottom.mas_equalTo(weakSelf.moneyLabel.mas_top).with.offset(-moneySpace);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(labelSize.height));
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).with.offset(moneySpace);
    }];
    
}

//颜色转换图片
+ (UIImage * _Nullable)imageWithColor:(UIColor * _Nullable)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

+(CGSize)sizeWidthString:(NSString * _Nullable)string
                 andFont:(UIFont * _Nullable)font{
    return [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
}


#pragma mark - 懒加载

-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _headImageView.frame = CGRectMake(0, 0, headImageViewWH, headImageViewWH);
        _headImageView.contentMode = UIViewContentModeScaleAspectFit;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        _nameLabel.text = @"标题";
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 1];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.numberOfLines = 1;
    }
    return _nameLabel;
}

-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        _moneyLabel.text = [NSString stringWithFormat:@"%@00.00",RMBSign];
        _moneyLabel.textColor = ColorWithRGB(158, 217, 184, 1);//ColorWithRGB(180, 183, 188, 1);
//        _moneyLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE - 1];
        _moneyLabel.font = [UIFont fontWithName:@"WeChat Sans Std" size:DEFAULT_FONTSIZE - 1];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.numberOfLines = 1;
    }
    return _moneyLabel;
}

@end
