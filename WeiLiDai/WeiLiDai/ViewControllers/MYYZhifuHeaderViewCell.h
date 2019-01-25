//
//  MYYZhifuHeaderView.h
//  WeiLiDai
//
//  Created by LONG on 2019/1/4.
//  Copyright © 2019年 j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionHeaderBtn.h"
NS_ASSUME_NONNULL_BEGIN

@interface MYYZhifuHeaderViewCell : UITableViewCell
@property (nonatomic, strong) CollectionHeaderBtn * paymentBtn;

@property (nonatomic, strong) CollectionHeaderBtn * changeBtn;

@property (nonatomic, strong) CollectionHeaderBtn * cardsBtn;

@property (nonatomic, strong) UIImageView * refreshImageView;

@property (nonatomic, strong) UIView* bgView;

@property (nonatomic, strong)NSMutableArray* masonryViewArray;

@end

NS_ASSUME_NONNULL_END
