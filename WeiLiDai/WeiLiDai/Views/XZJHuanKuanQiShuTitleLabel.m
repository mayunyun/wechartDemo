//
//  XZJHuanKuanQiShuTitleLabel.m
//  WeiLiDai
//
//  Created by j on 2018/1/29.
//  Copyright © 2018年 j. All rights reserved.
//

#import "XZJHuanKuanQiShuTitleLabel.h"

@implementation XZJHuanKuanQiShuTitleLabel

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    self.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
    self.textColor = grayHuanKuanQiShuTitleColor;
}
@end
