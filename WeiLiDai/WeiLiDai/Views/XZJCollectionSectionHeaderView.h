//
//  XZJCollectionSectionHeaderView.h
//  WeiLiDai
//
//  Created by j on 2017/12/18.
//  Copyright © 2017年 j. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef __IPHONE_11_0
@interface CustomLayer : CALayer
@end
#endif

@interface XZJCollectionSectionHeaderView : UICollectionReusableView 

@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UIView * whiteBGView;

@end
