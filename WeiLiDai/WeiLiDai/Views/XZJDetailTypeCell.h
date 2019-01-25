//
//  XZJDetailTypeCell.h
//  gongxigongxi
//
//  Created by iMac on 2017/5/9.
//  Copyright © 2017年 FangLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZJDetailTypeCell : UITableViewCell

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

/**
 右边的箭头
 */
@property (nonatomic, strong) UIImageView * rightArrowView;

/**
 分割线
 */
@property (nonatomic ,strong) UIView * lineView;

/**
 */
@property (nonatomic ,strong) UIImageView * headImageView;

@property (nonatomic ,strong) UIView* badgeView;

-(void)setCellData:(NSDictionary *)dic;


@end
