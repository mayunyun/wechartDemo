//
//  XZJChoseSupportBankView.m
//  WeiLiDai
//
//  Created by j on 2018/3/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import "XZJChoseSupportBankView.h"

static CGFloat showFrontViewW = 990/3;
static CGFloat showFrontViewH = 1584/3;

@implementation XZJChoseSupportBankView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.hidden = YES;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:self.showFrontView];
}

-(void)showViewAnimated{
    weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.showFrontView.hidden = NO;
        weakSelf.hidden = NO;
        weakSelf.showFrontView.frame = CGRectMake((self.frame.size.width - showFrontViewW)/2, (self.frame.size.height - showFrontViewH)/2, showFrontViewW, showFrontViewH);
    }];
    
}
-(void)hideViewAnimated{
    weakify(self);
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.showFrontView.frame = CGRectMake((self.frame.size.width - showFrontViewW)/2, self.frame.size.height, showFrontViewW, showFrontViewH);
    } completion:^(BOOL finished) {
        weakSelf.showFrontView.hidden = YES;
        weakSelf.hidden = YES;
        weakSelf.showFrontView.frame = CGRectMake((self.frame.size.width - showFrontViewW)/2, - showFrontViewH*2, showFrontViewW, showFrontViewH);
    }];
}

-(ChoseSupportBankFrontView *)showFrontView{
    if (!_showFrontView) {
        _showFrontView = [[ChoseSupportBankFrontView alloc] initWithFrame:CGRectMake((self.frame.size.width - showFrontViewW)/2, - showFrontViewH*2, showFrontViewW, showFrontViewH)];
        [_showFrontView.doneBtn addTarget:self action:@selector(hideViewAnimated) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showFrontView;
}

@end
