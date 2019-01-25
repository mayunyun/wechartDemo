//
//  ChoseBankCardBtn.h
//  WeiLiDai
//
//  Created by j on 2018/2/5.
//  Copyright © 2018年 j. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoseBankCardBtn : UIButton

@property (nonatomic, strong) UIImageView * headImageView;
@property (nonatomic, strong) UILabel * btnTitleLabel;
@property (nonatomic, strong) UIImageView * rightArrowView;

@property (nonatomic, copy) NSString * kahao;
@property (nonatomic, assign) NSInteger index;

@end
