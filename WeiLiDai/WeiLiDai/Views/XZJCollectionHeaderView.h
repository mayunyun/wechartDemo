//
//  XZJCollectionHeaderView.h
//  WeiLiDai
//
//  Created by j on 2017/12/18.
//  Copyright © 2017年 j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionHeaderBtn.h"

@interface XZJCollectionHeaderView : UICollectionReusableView

@property (nonatomic, strong) CollectionHeaderBtn * paymentBtn;

@property (nonatomic, strong) CollectionHeaderBtn * changeBtn;

@property (nonatomic, strong) CollectionHeaderBtn * cardsBtn;

@property (nonatomic, strong) UIImageView * refreshImageView;

@end
