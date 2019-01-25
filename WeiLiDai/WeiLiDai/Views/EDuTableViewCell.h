//
//  EDuTableViewCell.h
//  WeiLiDai
//
//  Created by j on 2018/2/11.
//  Copyright © 2018年 j. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDuTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * dateLabel;
//@property (nonatomic, strong) UILabel * rmbLabel;
@property (nonatomic, strong) UIImageView * rmbImageView;
@property (nonatomic, strong) UILabel * moneyLabel;
@property (nonatomic, strong) UILabel * bankLabel;
@property (nonatomic, strong) UIImageView * rightArrowView;

-(void)setCellDataWithDict:(NSDictionary *)dic;

@end
