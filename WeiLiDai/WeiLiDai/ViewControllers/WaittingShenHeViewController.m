//
//  WaittingShenHeViewController.m
//  WeiLiDai
//
//  Created by j on 2018/2/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import "WaittingShenHeViewController.h"

#define headImageViewWH (Width_Scall * 188)

@interface WaittingShenHeViewController ()

@property (nonatomic, strong) UIImageView * headImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * messageLabel;
@property (nonatomic, strong) UIButton * doneBtn;

@end

@implementation WaittingShenHeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"等待审核";
    [FactryFucClass setNavigationTintColorWithBlack:YES];
    [self.navigationController.navigationBar setBackgroundImage:[FactryFucClass imageWithColor:grayNavigationBGColor] forBarMetrics:UIBarMetricsDefault];
    UIStatusBarStyle barStyle = UIStatusBarStyleDefault;
    [UIApplication sharedApplication].statusBarStyle = barStyle;
    
    self.view.backgroundColor = grayNavigationBGColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"设置"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(setBtnClicked:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"关闭"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(closeBtnClicked)];
    UILabel * titleLabel = [FactryFucClass createLabelWithFrame:CGRectMake(0, 0, 100, 44)
                                                           text:self.title
                                                      textColor:[UIColor blackColor]
                                                       fontSize:[UIFont systemFontSize]
                                                  textAlignment:NSTextAlignmentCenter
                                                  numberOfLines:1];
    titleLabel.font = [UIFont boldSystemFontOfSize:CELL_FONTSIZE];
    self.navigationItem.titleView = titleLabel;
}

-(void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *leftBtn = [[UIButton alloc] init];
//    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIWindowLevelNormal];
//    leftBtn.titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 2];
//    leftBtn.frame = CGRectMake(0, 0, 60, 44);
////    leftBtn.showsTouchWhenHighlighted = YES;
//    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    // 重点位置结束
//    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    UIBarButtonItem *leftItemBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//
//    UIBarButtonItem * closeBtn = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
//                                                                  style:UIBarButtonItemStyleDone
//                                                                 target:self
//                                                                 action:@selector(nextBtnCLicked)];
//
//    self.navigationItem.leftBarButtonItems = @[leftItemBtn,closeBtn];
    
    [self.view addSubview:self.headImageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.doneBtn];
    weakify(self);
    CGFloat headImageViewY = NavigationBarHeight + StatusBarHeight + Width_Scall * 160;
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(headImageViewWH, headImageViewWH));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.view.mas_top).with.offset(headImageViewY);
    }];
    CGFloat titleLabelSpaceY = Width_Scall * 60;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat labelH = [weakSelf.titleLabel.text getHeightWithFont:weakSelf.titleLabel.font constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, labelH));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.headImageView.mas_bottom).with.offset(titleLabelSpaceY);
    }];
    CGFloat messageLabelSpaceY = Width_Scall * 46;
    CGFloat messageLabelW = SCREEN_WIDTH - spaceMargin * 6;
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat labelH = [weakSelf.messageLabel.text getHeightWithFont:weakSelf.messageLabel.font constrainedToSize:CGSizeMake(messageLabelW, MAXFLOAT)];
        make.size.mas_equalTo(CGSizeMake(messageLabelW, labelH));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(messageLabelSpaceY);
    }];
    
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - spaceMargin * 2, Width_Scall * 94));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.messageLabel.mas_bottom).with.offset(Width_Scall * 90);
    }];
    
}

-(void)setBtnClicked:(UIButton *)btn{
    
}

-(void)closeBtnClicked{
    NSArray * vcs = [self.navigationController viewControllers];
    [self.navigationController popToViewController:vcs[vcs.count - 5] animated:YES];
}

-(void)backBtnClicked:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)nextBtnCLicked{
    NSArray * vcs = [self.navigationController viewControllers];
    [self.navigationController popToViewController:vcs[vcs.count - 4] animated:YES];
}

-(void)doneBtnCLicked{
    [self nextBtnCLicked];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 懒加载

-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weittingShenHe"]];
        _headImageView.frame = CGRectMake(0, 0, headImageViewWH, headImageViewWH);
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"借款申请已提交";
        _titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 10];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.text = @"你的借款申请正在等待银行审核，请留意公众号或短信通知";
        _messageLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor = [UIColor grayColor];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

-(UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneBtn.layer.masksToBounds = YES;
        _doneBtn.layer.cornerRadius = Width_Scall * 8;
        _doneBtn.layer.borderColor = ColorWithRGB(150, 197, 151, 1).CGColor;
        _doneBtn.layer.borderWidth = 1;
        [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 3];
        _doneBtn.backgroundColor = ColorWithRGB(26, 173, 25, 1);
//        [_doneBtn setBackgroundImage:[CheckPhoneNumViewController imageWithColor:ColorWithRGB(163, 223, 163, 1)] forState:UIControlStateDisabled];
//        [_doneBtn setBackgroundImage:[CheckPhoneNumViewController imageWithColor:ColorWithRGB(26, 173, 25, 1)] forState:UIControlStateNormal];
//        _doneBtn.enabled = NO;
        [_doneBtn addTarget:self action:@selector(doneBtnCLicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}


@end
