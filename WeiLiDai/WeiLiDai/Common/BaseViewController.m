//
//  BaseViewController.m
//  WeiLiDai
//
//  Created by j on 2017/12/18.
//  Copyright © 2017年 j. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic,strong)UIButton* leftBarBtn;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [self.view addSubview:self.bgView];
    [super viewDidLoad];
    self.view.backgroundColor = ColorWithRGB(242, 242, 242, 1);//baseViewVCBG;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                                  }];//NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self hideBGView];
    [self hideBack];
}

-(void)showBGView{
    self.bgView.hidden = NO;
}

-(void)hideBGView{
    self.bgView.hidden = YES;
}


-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight + StatusBarHeight)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    }
    return _bgView;
}

- (void)showBack{
    UIBarButtonItem* left = [[UIBarButtonItem alloc]initWithCustomView:self.leftBarBtn];
    self.navigationItem.leftBarButtonItem = left;
}
- (void)hideBack{
    self.navigationItem.leftBarButtonItem = nil;
}

- (UIButton*)leftBarBtn{
    if (!_leftBarBtn) {
        _leftBarBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _leftBarBtn.frame = CGRectMake(0, 0, 30, 40);
        UIImageView* leftBarimgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
        [leftBarimgView setImage:[UIImage imageNamed:@"后退"]];
        [_leftBarBtn addSubview:leftBarimgView];
        [_leftBarBtn addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBarBtn;
}
- (void)leftClick:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
