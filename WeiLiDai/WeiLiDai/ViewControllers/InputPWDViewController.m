//
//  InputPWDViewController.m
//  WeiLiDai
//
//  Created by j on 2018/2/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import "InputPWDViewController.h"
#import "SYPasswordView.h"
#import "CheckPhoneNumViewController.h"
//#import "KeyBoardView.h"
#import "BorrowSuccessViewController.h"
#import "XZJBaseViewController.h"

@interface InputPWDViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) SYPasswordView *pasView;

@end

@implementation InputPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    XZJBaseViewController * baseVC = [XZJBaseViewController sharedBaseViewController];
    [baseVC.btnsView hideView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)createUI{
    [self hideBGView];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:ColorWithRGB(62, 168, 61, 1) forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:CELL_FONTSIZE + 2];
    leftBtn.frame = CGRectMake(20, 30, 60, 44);
    leftBtn.showsTouchWhenHighlighted = YES;
    [leftBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    // 重点位置结束
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:leftBtn];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.pasView];
    weakify(self);
    self.pasView.block = ^(NSString *pwd) {
        [weakSelf.pasView.textField resignFirstResponder];
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            if ([cingleTon.isShowGetSMSCodeVC isEqualToString:@"否"]) {
                cingleTon.bBankCardNum = cingleTon.bBankCardNumTemp;
                cingleTon.bBankName = cingleTon.bBankNameTemp;
                cingleTon.bBorrowCount = cingleTon.bBorrowCountTemp;
                cingleTon.bIdCard2 = cingleTon.bIdCard2Temp;
                weakSelf.leftClickedBlock();
                BorrowSuccessViewController * inputPWDVC = [[BorrowSuccessViewController alloc] init];
                [weakSelf.jieQianVC.navigationController pushViewController:inputPWDVC animated:YES];
            }
            else{
                CheckPhoneNumViewController * checkPVC = [[CheckPhoneNumViewController alloc] init];
                [weakSelf.jieQianVC.navigationController pushViewController:checkPVC animated:YES];
            }
        }];
    };
    [self.pasView.textField becomeFirstResponder];
    
    CGFloat titleLabelY = Width_Scall * 262;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat labelH = [weakSelf.titleLabel.text getHeightWithFont:weakSelf.titleLabel.font constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(@(titleLabelY));
        make.height.mas_equalTo(@(labelH));
    }];
    CGFloat messageLabelY = Width_Scall * 54;
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat labelH = [weakSelf.messageLabel.text getHeightWithFont:weakSelf.messageLabel.font constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(messageLabelY);
        make.height.mas_equalTo(@(labelH));
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)backBtnClicked:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 懒加载

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"身份验证";
        _titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE * 2];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLabel;
}

-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.text = @"请验证支付密码确认本人操作";
        _messageLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _messageLabel;
}

-(SYPasswordView *)pasView{
    if (!_pasView) {
        CGFloat pasViewX = Width_Scall * 72;
        CGFloat pasViewH = Width_Scall * 102;
        _pasView = [[SYPasswordView alloc] initWithFrame:CGRectMake(pasViewX, Width_Scall * 560, SCREEN_WIDTH - pasViewX * 2, pasViewH)];
        
    }
    return _pasView;
}

@end
