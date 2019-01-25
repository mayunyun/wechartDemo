//
//  XZJMineHeadTableViewCell.h
//  WeiLiDai
//
//  Created by j on 2018/2/20.
//  Copyright © 2018年 j. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZJMineHeadTableViewCell : UITableViewCell

/**
 最左边的图标
 */
@property (nonatomic, strong) UIImageView * headIconView;

/**
 cell的标题
 */
@property (nonatomic, strong) UILabel * cellTitleLabel;

/**
 副标题
 */
@property (nonatomic, strong) UILabel * cellSubtitleLabel;

@property (nonatomic, strong) UIImageView * erweimaImageView;

/**
 右边的箭头
 */
@property (nonatomic, strong) UIImageView * rightArrowView;

@property (nonatomic, strong) UIImageView * refreshImageView;

@end
