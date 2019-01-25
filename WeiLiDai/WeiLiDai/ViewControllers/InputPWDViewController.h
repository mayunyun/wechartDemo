//
//  InputPWDViewController.h
//  WeiLiDai
//
//  Created by j on 2018/2/4.
//  Copyright © 2018年 j. All rights reserved.
//

typedef void(^LeftBtnClickedBlock)(void);
#import "BaseViewController.h"
#import "JieQianViewController.h"

@interface InputPWDViewController : BaseViewController

@property (nonatomic, strong) JieQianViewController * jieQianVC;

@property (nonatomic, copy) LeftBtnClickedBlock leftClickedBlock;

@end
