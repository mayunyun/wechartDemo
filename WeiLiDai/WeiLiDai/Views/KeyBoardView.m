//
//  KeyBoardView.m
//  WeiLiDai
//
//  Created by iMac on 2018/3/2.
//  Copyright © 2018年 j. All rights reserved.
//

#import "KeyBoardView.h"

#define bgColor ColorWithRGB(206, 206, 207, 1)

@interface KeyBoardView()

@property (nonatomic, copy) NSString * specSign;
@property (nonatomic, strong) NSMutableArray * btnsArray;

@end

@implementation KeyBoardView

-(instancetype)initWithFrame:(CGRect)frame specSign:(NSString *)specSign{
    if (self = [super initWithFrame:frame]) {
        self.specSign = specSign;
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = bgColor;
    CGFloat btnW = 414/3;
    CGFloat btnH = 162/3;
    UIColor * btnBgColorNormal = [UIColor whiteColor];
    UIColor * btnBgColorHighlighted = ColorWithRGB(215, 215, 215, 1);
    int k = 1;
    [self.btnsArray removeAllObjects];
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton * btn = [FactryFucClass createButtonWithFrame:CGRectMake(btnW * j, btnH * i, btnW, btnH)
                                                   backgroundColor:nil
                                                          setTitle:[NSString stringWithFormat:@"%d",k]
                                                     setTitleColor:[UIColor blackColor]
                                                 andTitleLabelFont:[UIFont systemFontOfSize:CELL_FONTSIZE]
                                                         addTarget:self
                                                            action:@selector(btnClicked:)
                                                  forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:[FactryFucClass imageWithColor:btnBgColorNormal] forState:UIControlStateNormal];
            if (k == 10 || k == 12) {
                [btn setImage:[FactryFucClass imageWithColor:btnBgColorHighlighted] forState:UIControlStateNormal];
                if (k == 10) {
                    [btn setTitle:self.specSign forState:UIControlStateNormal];
                    if (self.specSign.length == 0) {
                        btn.enabled = NO;
                    }
                }
                else{
                    [btn setTitle:@"删除" forState:UIControlStateNormal];
                }
            }
            if (k == 11) {
                [btn setTitle:@"0" forState:UIControlStateNormal];
            }
            [btn setImage:[FactryFucClass imageWithColor:btnBgColorHighlighted] forState:UIControlStateHighlighted];
            btn.layer.masksToBounds = YES;
            btn.layer.borderWidth = 1/3;
            btn.layer.borderColor = bgColor.CGColor;
            btn.tag = 100 + k;
            [self addSubview:btn];
            [self.btnsArray addObject:btn];
            k++;
        }
        
    }
    
}

-(void)btnClicked:(UIButton *)btn{
    self.block(btn.titleLabel.text, btn.tag - 100);
}
-(NSMutableArray *)btnsArray{
    if (!_btnsArray) {
        _btnsArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _btnsArray;
}

@end
