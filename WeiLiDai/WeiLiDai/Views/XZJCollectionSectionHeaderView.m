//
//  XZJCollectionSectionHeaderView.m
//  WeiLiDai
//
//  Created by j on 2017/12/18.
//  Copyright © 2017年 j. All rights reserved.
//

#import "XZJCollectionSectionHeaderView.h"

#ifdef __IPHONE_11_0
@implementation CustomLayer
- (CGFloat) zPosition {
    return 0;
}
@end
#endif

@implementation XZJCollectionSectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = TableViewBGColor;
    [self addSubview:self.whiteBGView];
}

#pragma mark - 懒加载

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width_Scall * 30, 0, self.frame.size.width - Width_Scall * 30, qianbaoCollectionSectionHeadNameLabelH)];
        _nameLabel.text = @"组头标题";
        _nameLabel.textColor = ColorWithRGB(113, 111, 118, 1);
        _nameLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.numberOfLines = 1;
        
    }
    return _nameLabel;
}

-(UIView *)whiteBGView{
    if (!_whiteBGView) {
        _whiteBGView = [[UIView alloc] initWithFrame:CGRectMake(0, Width_Scall * 20, self.frame.size.width, qianbaoCollectionSectionHeadNameLabelH)];
        _whiteBGView.backgroundColor = [UIColor whiteColor];
        [_whiteBGView addSubview:self.nameLabel];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, qianbaoCollectionSectionHeadNameLabelH - 1, self.frame.size.width, 1)];
        lineView.backgroundColor = TableViewBGColor;
        [_whiteBGView addSubview:lineView];
    }
    return _whiteBGView;
}

#ifdef __IPHONE_11_0
+ (Class)layerClass {
    return [CustomLayer class];
}
#endif

@end
