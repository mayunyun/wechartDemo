//
//  CheckPhoneNumViewController.m
//  WeiLiDai
//
//  Created by j on 2018/2/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import "CheckPhoneNumViewController.h"
#import "WaittingShenHeViewController.h"
#import "XZJSmsCodeTextFieldView.h"
#import "BorrowSuccessViewController.h"
#import "XZJBaseViewController.h"

@interface CheckPhoneNumViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong) UILabel * titleLabel;
@property (nonatomic ,strong) XZJSmsCodeTextFieldView * checkSmsCodetTextfield;
@property (nonatomic ,strong) UIButton * getCheckSmsCodeBtn;//200*91
@property (nonatomic ,strong) UIButton * nextBtn;
@property (nonatomic ,strong) UIButton * cantGetSmsCodeBtn;


@end

@implementation CheckPhoneNumViewController

-(instancetype)init{
    if (self = [super init]) {

//        [self.navigationController popToViewController:vcs[vcs.count - 2] animated:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * vcs = [self.navigationController viewControllers];
    NSMutableArray * mvcs = [NSMutableArray arrayWithArray:vcs];
    [mvcs removeObjectAtIndex:vcs.count -2];
    self.navigationController.viewControllers = mvcs;
    [self createUI];
}

//-(BOOL) navigationShouldPopOnBackButton {
//    NSArray * vcs = [self.navigationController viewControllers];
//    [self.navigationController popToViewController:vcs[vcs.count - 2] animated:YES];
//
//    return YES; // Process 'Back' button click and Pop view controler
//}

-(void)createUI{
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    self.titleLabel.text = [NSString stringWithFormat:@"本次操作需要短信确认，验证码已发送至手机：\n%@***%@，请按提示操作。",cingleTon.bPhoneNum1,cingleTon.bPhoneNum3];
    [self.view addSubview:self.titleLabel];
    UIColor * lineColor = ColorWithRGB(217, 215, 221, 1);
    UIView * line1 = [[UIView alloc] init];
    line1.backgroundColor = lineColor;
    [self.view addSubview:line1];
    [self.view addSubview:self.checkSmsCodetTextfield];
    [self.view addSubview:self.getCheckSmsCodeBtn];
    UIView * line2 = [[UIView alloc] init];
    line2.backgroundColor = lineColor;
    [self.view addSubview:line2];
    [self.view addSubview:self.nextBtn];
    [self.view addSubview:self.cantGetSmsCodeBtn];
    
    weakify(self);
    CGFloat titleLabelY = 110/3 + NavigationBarHeight + StatusBarHeight;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat labelH = [weakSelf.titleLabel.text getHeightWithFont:weakSelf.titleLabel.font constrainedToSize:CGSizeMake(SCREEN_WIDTH - spaceMargin * 2, MAXFLOAT)];
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - spaceMargin * 2, labelH));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(@(titleLabelY));
    }];
    CGFloat lineSpaceY = Width_Scall * 15;
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(lineSpaceY);
    }];
    
    [self.checkSmsCodetTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width_Scall * 367, Width_Scall * 91));
        make.left.mas_equalTo(weakSelf.view.mas_left).with.offset(spaceMargin);
        make.top.mas_equalTo(line1.mas_bottom).with.offset(lineSpaceY);
    }];
    
    [self.getCheckSmsCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width_Scall * 200, Width_Scall * 91));
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(-spaceMargin);
        make.centerY.mas_equalTo(weakSelf.checkSmsCodetTextfield.mas_centerY);
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.checkSmsCodetTextfield.mas_bottom).with.offset(lineSpaceY);
    }];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - spaceMargin * 2, Width_Scall * 94));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(line2.mas_bottom).with.offset(lineSpaceY);
    }];
    
    [self.cantGetSmsCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize btnSZ = [weakSelf.cantGetSmsCodeBtn.titleLabel.text getSizeWithFont:weakSelf.cantGetSmsCodeBtn.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        make.size.mas_equalTo(btnSZ);
        make.top.mas_equalTo(weakSelf.nextBtn.mas_bottom).with.offset(lineSpaceY);
        make.right.mas_equalTo(weakSelf.view.mas_right).with.offset(-spaceMargin);
    }];
    
    
    [self.checkSmsCodetTextfield.textField becomeFirstResponder];
    [self receiveCheckNumButton:self.getCheckSmsCodeBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nextBtnCLicked{
    SingleTon *cingleTon = [SingleTon sharedSingleTon];
    cingleTon.bBankCardNum = cingleTon.bBankCardNumTemp;
    cingleTon.bBankName = cingleTon.bBankNameTemp;
    cingleTon.bBorrowCount = cingleTon.bBorrowCountTemp;
    cingleTon.bIdCard2 = cingleTon.bIdCard2Temp;
    if (ifBorrowSuccess) {
        
        BorrowSuccessViewController * inputPWDVC = [[BorrowSuccessViewController alloc] init];
        [self.navigationController pushViewController:inputPWDVC animated:YES];
    }
    else{
        WaittingShenHeViewController * inputPWDVC = [[WaittingShenHeViewController alloc] init];
        [self.navigationController pushViewController:inputPWDVC animated:YES];
    }
    
}

//获取验证码倒计时
- (void)receiveCheckNumButton:(UIButton *)btn{
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn setTitle:@"重新获取" forState:UIControlStateNormal];
                btn.enabled = YES;
//                btn.userInteractionEnabled = YES;
//                btn.backgroundColor = tabbarSelectedColor;
//                btn.titleLabel.font = [UIFont boldSystemFontOfSize:DEFAULT_FONTSIZE];
                
            });
        }else{
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //让按钮变为不可点击的灰色
                btn.enabled = NO;
//                btn.backgroundColor = [UIColor grayColor];
//                btn.userInteractionEnabled = NO;
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [btn setTitle:[NSString stringWithFormat:@"获取验证码\n(%@)",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"验证手机号";
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
    [baseVC.btnsView hideView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.title = @"返回";
    UIImage *bgImage = [[UIImage imageNamed:@"发现导航"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];//navigationView
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

-(void)setBtnClicked:(UIButton *)btn{
    
}

-(void)closeBtnClicked{
    NSArray * vcs = [self.navigationController viewControllers];
    [self.navigationController popToViewController:vcs[vcs.count - 4] animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSLog(@"变化%@", string);
    
    if(textField.text.length >= 5) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
//        NSLog(@"输入的字符个数大于4，忽略输入");
        self.nextBtn.enabled = YES;
//        if (textField.text.length >4) {
//            return NO;
//        }
        self.nextBtn.layer.borderColor = ColorWithRGB(72, 151, 50, 1).CGColor;
        
        return YES;
    } else {
        self.nextBtn.layer.borderColor = ColorWithRGB(163, 223, 163, 1).CGColor;
        self.nextBtn.enabled = NO;
        return YES;
    }
}

//颜色转换图片
+ (UIImage * _Nullable)imageWithColor:(UIColor * _Nullable)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}


#pragma mark - 懒加载

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"身份验证";
        _titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE-1];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = ColorWithRGB(135, 136, 135, 1);
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(XZJSmsCodeTextFieldView *)checkSmsCodetTextfield{
    if (!_checkSmsCodetTextfield) {
//        _checkSmsCodetTextfield = [[XZJSmsCodeTextFieldView alloc] initWithFrame:CGRectMake(spaceMargin, spaceMargin, Width_Scall * 367, Width_Scall * 91)];
        _checkSmsCodetTextfield = [[XZJSmsCodeTextFieldView alloc] initWithFrame:CGRectMake(spaceMargin, spaceMargin, 820/3, 135/3)];
        _checkSmsCodetTextfield.textField.delegate = self;
    }
    return _checkSmsCodetTextfield;
}

-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.layer.cornerRadius = Width_Scall * 8;
//        _nextBtn.layer.borderColor = ColorWithRGB(72, 151, 50, 1).CGColor;
        _nextBtn.layer.borderColor = ColorWithRGB(163, 223, 163, 1).CGColor;
        _nextBtn.layer.borderWidth = 1;
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 2];
        [_nextBtn setBackgroundImage:[CheckPhoneNumViewController imageWithColor:ColorWithRGB(163, 223, 163, 1)] forState:UIControlStateDisabled];
        [_nextBtn setBackgroundImage:[CheckPhoneNumViewController imageWithColor:ColorWithRGB(26, 173, 25, 1)] forState:UIControlStateNormal];
        _nextBtn.enabled = NO;
        [_nextBtn addTarget:self action:@selector(nextBtnCLicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

-(UIButton *)cantGetSmsCodeBtn{
    if (!_cantGetSmsCodeBtn) {
        _cantGetSmsCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cantGetSmsCodeBtn setTitle:@"收不到验证码?" forState:UIControlStateNormal];
        [_cantGetSmsCodeBtn setTitleColor:ColorWithRGB(90, 93, 133, 1) forState:UIControlStateNormal];
        [_cantGetSmsCodeBtn setTitleColor:ColorWithRGB(68, 78, 96, 1) forState:UIControlStateHighlighted];
        _cantGetSmsCodeBtn.titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE-1];
        _cantGetSmsCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _cantGetSmsCodeBtn;
}

-(UIButton *)getCheckSmsCodeBtn{
    if (!_getCheckSmsCodeBtn) {
        _getCheckSmsCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getCheckSmsCodeBtn.layer.masksToBounds = YES;
        _getCheckSmsCodeBtn.layer.cornerRadius = Width_Scall * 4;
        [_getCheckSmsCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCheckSmsCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_getCheckSmsCodeBtn setTitleColor:ColorWithRGB(171, 169, 170, 1) forState:UIControlStateDisabled];
        _getCheckSmsCodeBtn.titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        [_getCheckSmsCodeBtn setBackgroundImage:[CheckPhoneNumViewController imageWithColor:ColorWithRGB(235, 233, 234, 1)] forState:UIControlStateDisabled];
        [_getCheckSmsCodeBtn setBackgroundImage:[CheckPhoneNumViewController imageWithColor:ColorWithRGB(26, 173, 25, 1)] forState:UIControlStateNormal];
        _getCheckSmsCodeBtn.enabled = YES;
        _getCheckSmsCodeBtn.titleLabel.numberOfLines = 2;
        _getCheckSmsCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_getCheckSmsCodeBtn addTarget:self action:@selector(receiveCheckNumButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCheckSmsCodeBtn;
}

@end
