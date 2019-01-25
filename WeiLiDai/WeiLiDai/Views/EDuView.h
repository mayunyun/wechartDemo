//
//  EDuView.h
//  WeiLiDai
//
//  Created by j on 2017/12/20.
//  Copyright © 2017年 j. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDuView : UIView

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIImageView * edBGImageView;
@property (nonatomic, strong) UILabel * edLabel;
//@property (nonatomic, strong) UILabel * rmbLabel;
@property (nonatomic, strong) UIImageView * rmbImageView;
@property (nonatomic, strong) UILabel * zEDuLabel;
@property (nonatomic, strong) UIButton * borrowBtn;
@property (nonatomic, strong) UILabel * hornLabel;

@property (nonatomic, strong) UIView * hornView;
@property (nonatomic, strong) UIImageView* leftView;
@property (nonatomic, strong) UIImageView* rightView;

-(void)resetEDuLabelData:(NSString *)ned;

-(void)resetSize:(CGSize)size;

@end
