//
//  XZJChoseSupportBankView.h
//  WeiLiDai
//
//  Created by j on 2018/3/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoseSupportBankFrontView.h"

@interface XZJChoseSupportBankView : UIView

@property (nonatomic, strong) ChoseSupportBankFrontView * showFrontView;

-(void)showViewAnimated;
-(void)hideViewAnimated;


@end
