//
//  AlertInfoViewController.h
//  WeiLiDai
//
//  Created by j on 2018/2/24.
//  Copyright © 2018年 j. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^UserInfoBlock)(NSString * headImageName, NSString * userNick, NSString * userNum);
@interface AlertInfoViewController : BaseViewController

@property (nonatomic, strong) UserInfoBlock block;

@end
