//
//  KeyBoardView.h
//  WeiLiDai
//
//  Created by iMac on 2018/3/2.
//  Copyright © 2018年 j. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^KeyBoardBtnClickedBlock)(NSString * value, NSUInteger btnIndex);

@interface KeyBoardView : UIView

@property (nonatomic, strong) KeyBoardBtnClickedBlock block;

-(instancetype)initWithFrame:(CGRect)frame specSign:(NSString *)specSign;

@end
