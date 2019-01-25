//
//  TiQianHuanKuanViewController.m
//  WeiLiDai
//
//  Created by j on 2018/3/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import "TiQianHuanKuanViewController.h"
#import "HuanqianView.h"
#import "HuanKuanShowView.h"
#import "XZJBaseViewController.h"

#define label3H (20)

static CGFloat topSpace = 21;
static CGFloat leftSpace = 46/3;
static CGFloat viewH = 749/3;

@interface TiQianHuanKuanViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * mainScrollView;

@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;

@property (nonatomic, strong) UILabel * label3;

@property (nonatomic, strong) HuanqianView * tiQianHuanqianView;
@property (nonatomic, strong) HuanKuanShowView * showView;


@property (nonatomic, strong) UIButton * nextBtn;
@property (nonatomic, strong) UIView * lineView2;

@end

@implementation TiQianHuanKuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self createUI];
}

-(void)createUI{
    self.title = @"提前还清借款";
    self.view.backgroundColor = ColorWithRGB(236, 237, 238, 1);
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.tiQianHuanqianView];
    [self.mainScrollView addSubview:self.nextBtn];
    UIView * bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight + StatusBarHeight)];
    bgView2.backgroundColor = grayNavigationBGColor;//[UIColor blackColor];
    [self.view addSubview:bgView2];
    [self.view addSubview:self.label3];
    [self.view addSubview:self.showView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[FactryFucClass imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    [FactryFucClass setNavigationTintColorWithBlack:YES];
    [self.navigationController.navigationBar setBackgroundImage:[FactryFucClass imageWithColor:ColorWithRGB(241, 241, 241, 1)] forBarMetrics:UIBarMetricsDefault];
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
    
    XZJBaseViewController * baseVC = [XZJBaseViewController sharedBaseViewController];
    [baseVC.btnsView showView];
    [baseVC.btnsView setLeftBtnEnabled:YES];
    [baseVC.btnsView setRightBtnEnabled:NO];
    weakify(self);
    baseVC.btnsView.leftClickedBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    baseVC.btnsView.rightClickedBlock = ^{
        
    };
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIImage *bgImage = [[UIImage imageNamed:@"发现导航"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];//
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    XZJBaseViewController * baseVC = [XZJBaseViewController sharedBaseViewController];
    [baseVC.btnsView hideView];
}

-(void)hideWriteEvaluationView:(UITapGestureRecognizer *)tapGesture{
//    [self.borrowMoneyView.moneyTextField resignFirstResponder];
//    [self.writeUserInfoView.nameView.valueTextField resignFirstResponder];
//    [self.writeUserInfoView.IdNumView.valueTextField resignFirstResponder];
}

-(void)setBtnClicked:(UIButton *)btn{
    
}

-(void)closeBtnClicked{
    NSArray * vcs = [self.navigationController viewControllers];
    [self.navigationController popToViewController:vcs[vcs.count - 3] animated:YES];
}

-(void)nextBuBtnClicked:(UIButton *)btn{
    
}

-(void)showViewAction{
    [self.showView showViewAnimated];
}

#pragma mark - 懒加载

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - NavigationBarHeight)];
        [_mainScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - NavigationBarHeight + 0.3)];
        _mainScrollView.showsVerticalScrollIndicator = YES;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
        
    }
    return _mainScrollView;
}

-(UITapGestureRecognizer *)tapGesture{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWriteEvaluationView:)];
        _tapGesture.delegate = self;
    }
    return _tapGesture;
}

-(UILabel *)label3{
    if (!_label3) {
        _label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - messageLabelBottomSpaceY - label3H, SCREEN_WIDTH, label3H)];
        _label3.text = @"本服务由微众银行提供";
        _label3.textColor = ColorWithRGB(154, 155, 154, 1);
        _label3.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _label3.textAlignment = NSTextAlignmentCenter;
        _label3.numberOfLines = 1;
    }
    return _label3;
}

-(HuanqianView *)tiQianHuanqianView{
    if (!_tiQianHuanqianView) {
        _tiQianHuanqianView = [[HuanqianView alloc] initWithFrame:CGRectMake(leftSpace, topSpace, SCREEN_WIDTH - leftSpace * 2, viewH)];
        [_tiQianHuanqianView.jieqianBtn addTarget:self action:@selector(showViewAction) forControlEvents:UIControlEventTouchUpInside];
        [_tiQianHuanqianView.quanxuanBtn addTarget:self action:@selector(showViewAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tiQianHuanqianView;
}

-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftSpace, self.tiQianHuanqianView.frame.size.height + self.tiQianHuanqianView.frame.origin.y - 1, self.tiQianHuanqianView.frame.size.width, 209/3)];
        _nextBtn.backgroundColor = [UIColor whiteColor];
        [_nextBtn setTitle:@"还款" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 5];
        [_nextBtn setTitleColor:ColorWithRGB(210, 210, 210, 1) forState:UIControlStateDisabled];
        [_nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_nextBtn setTitleColor:ColorWithRGB(234, 213, 163, 1) forState:UIControlStateNormal];
        _nextBtn.layer.borderWidth = 1;
        _nextBtn.layer.borderColor = grayBorderColor.CGColor;
        _nextBtn.enabled = NO;
        [_nextBtn addTarget:self action:@selector(nextBuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_nextBtn addSubview:self.lineView2];
    }
    return _nextBtn;
}

-(UIView *)lineView2{
    if (!_lineView2) {
        //        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(self.borrowMoneyView.frame.origin.x, self.nextBtn.frame.origin.y, self.borrowMoneyView.frame.size.width, 1)];
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, -0.25, self.tiQianHuanqianView.frame.size.width, 1.5)];
        _lineView2.backgroundColor = ColorWithRGB(234, 213, 163, 1);
    }
    return _lineView2;
}

-(HuanKuanShowView *)showView{
    if (!_showView) {
        _showView = [[HuanKuanShowView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight + StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - StatusBarHeight)];
        [_showView hideViewAnimated];
    }
    return _showView;
}

@end
