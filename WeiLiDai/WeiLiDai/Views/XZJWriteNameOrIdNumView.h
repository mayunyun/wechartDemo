//
//  XZJWriteNameOrIdNumView.h
//  WeiLiDai
//
//  Created by j on 2018/2/8.
//  Copyright © 2018年 j. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZJWriteNameOrIdNumView : UIView

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * valueLabel;

@property (nonatomic, strong) UITextField * valueTextField;

/**
 重新设置valueLabel的值 并重新计算valueLabel的快读

 @param valueLabelText valueLabelText description
 */
-(void)setValueLabelText:(NSString *)valueLabelText;

@end
