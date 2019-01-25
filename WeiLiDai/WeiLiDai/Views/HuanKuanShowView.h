//
//  HuanKuanShowView.h
//  WeiLiDai
//
//  Created by j on 2018/3/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuanKuanShowFrontView.h"

@interface HuanKuanShowView : UIView

@property (nonatomic, strong) HuanKuanShowFrontView * showFrontView;

-(void)showViewAnimated;
-(void)hideViewAnimated;

@end
