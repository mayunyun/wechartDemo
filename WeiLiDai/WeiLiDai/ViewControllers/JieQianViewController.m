//
//  JieQianViewController.m
//  WeiLiDai
//
//  Created by j on 2017/12/20.
//  Copyright © 2017年 j. All rights reserved.
//

#import "JieQianViewController.h"
#import "BorrowMoneyView.h"
#import "XZJAfterNumEnterShowView.h"
#import "ActionSheetPicker.h"
#import "InputPWDViewController.h"
#import "InputUserInfoView.h"
#import "BankCardModel.h"
#import "XZJChoseSupportBankView.h"
#import "XZJActionShitPicker.h"
#import "XZJBaseViewController.h"

#define afterShowH (200)
//#define choseBankCardViewH (Width_Scall * 445)
#define choseBankCardViewH (715/3)
#define nextBtnH (211/3)
//#define writeUserInfoViewH (Width_Scall * 900)
//#define writeUserInfoViewH2 (Width_Scall * 1000)
//#define contentSiseSpaceH (Width_Scall * 164)
#define contentSiseSpaceH (1004/3)
#define label3H (20)
//#define label3Count (messageLabelBottomSpaceY + label3H)
#define label3Count (messageLabelBottomSpaceY + 41/3)

static CGFloat writeUserInfoViewH = 1334/3;
//static CGFloat writeUserInfoViewH2 = 1334/3;

@interface JieQianViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    CGFloat _BottomViewH;
}
@property (nonatomic, strong) UIScrollView * mainScrollView;

@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;

/**
 填写借钱金额
 */
@property (nonatomic, strong) BorrowMoneyView * borrowMoneyView;

@property (nonatomic, strong) UILabel * label3;

@property (nonatomic, strong) UIButton * nextBtn;
@property (nonatomic, strong) UIView * lineView2;

/**
 选择分期
 */
@property (nonatomic, strong) XZJAfterNumEnterShowView * afterNumEnterShowView;

/**
 输入用户信息视图
 */
@property (nonatomic, strong) InputUserInfoView * writeUserInfoView;


@property (nonatomic, assign) NSUInteger selectQiXianIndex;

@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, copy) NSString * kahao;

@property (nonatomic, strong) XZJChoseSupportBankView * choseSupportBankView;


@end

@implementation JieQianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

-(void)createUI{
    self.view.backgroundColor = ColorWithRGB(236, 237, 238, 1);
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    BankCardModel * model = cingleTon.bankCardModels[0];
    self.selectQiXianIndex = 1;
    self.index = model.bBankSignIndex;
    self.kahao = model.bBankCardNum;

    
    [self.view addSubview:self.mainScrollView];
    UIView * bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight + StatusBarHeight)];
    bgView2.backgroundColor = grayNavigationBGColor;//[UIColor blackColor];
    [self.view addSubview:bgView2];
    [self.mainScrollView addSubview:self.borrowMoneyView];
    [self.mainScrollView addSubview:self.label3];
    [self.mainScrollView addGestureRecognizer:self.tapGesture];
    [self.mainScrollView addSubview:self.afterNumEnterShowView];
    [self.mainScrollView addSubview:self.choseBankCardView];
    [self.mainScrollView addSubview:self.nextBtn];
    [self.mainScrollView addSubview:self.writeUserInfoView];
    [self.view addSubview:self.chengeBankCardView1];
    [self.view addSubview:self.choseSupportBankView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[FactryFucClass imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    self.title = @"微粒贷";
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
    _BottomViewH = [baseVC.btnsView hideViewHight];
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
    self.title = @"返回";
//    UIImage *bgImage = [[UIImage imageNamed:@"navigationView"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
//    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    XZJBaseViewController * baseVC = [XZJBaseViewController sharedBaseViewController];
    [baseVC.btnsView hideView];
}

-(void)nextBtnCLicked{
    InputPWDViewController * inputPWDVC = [[InputPWDViewController alloc] init];
    inputPWDVC.jieQianVC = self;
    inputPWDVC.leftClickedBlock = ^{
        SingleTon* cingleTon = [SingleTon sharedSingleTon];
        NSString * bReturnCountMounthly = [JieQianViewController getMounthPayWithBorrowCount:[self.borrowMoneyView.moneyTextField.text floatValue]
                                                                                   dailyRate:cingleTon.riLiLv/100//0.0005
                                                                             borrowMounthNum:10];//willShowText
        bReturnCountMounthly = [bReturnCountMounthly stringByReplacingOccurrencesOfString:@"¥" withString:@""];
        cingleTon.bReturnCountMounthly = bReturnCountMounthly;
    };
    [self presentViewController:inputPWDVC animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideWriteEvaluationView:(UITapGestureRecognizer *)tapGesture{
    [self.borrowMoneyView.moneyTextField resignFirstResponder];
    [self.writeUserInfoView.nameView.valueTextField resignFirstResponder];
    [self.writeUserInfoView.IdNumView.valueTextField resignFirstResponder];
}

/**
 获得当前月份

 @return 月
 */
+(NSString *)getCurrentMonth{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];
    return [formatter stringFromDate:now];
}

/**
 获得下个月份
 
 @return 月
 */
+(NSString *)getNextMonth{
    NSString * currentMonth = [JieQianViewController getCurrentMonth];
    NSUInteger currentMonthInt = [currentMonth integerValue];
    NSUInteger nextMonthInt = 1;
    if (currentMonthInt == 12) {
        nextMonthInt = 1;
    }
    else{
        nextMonthInt = currentMonthInt + 1;
    }
    return [NSString stringWithFormat:@"%ld",nextMonthInt];
}

/**
 获得当前日期
 
 @return 日
 */
+(NSString *)getCurrentDay{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd"];
    NSString* str = [formatter stringFromDate:now];
    return [NSString stringWithFormat:@"%li",[str integerValue]];
}

/**
 获得当前日期
 
 @return 日
 */
+(NSString *)getCurrentYear{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    return [formatter stringFromDate:now];
}

/**
 获得每月应还金额

 @param borrowCount 借钱数目
 @param dailyRate 日利率
 @param mounthNum 还款期数
 @return 每月应还金额
 */
+(NSString *)getMounthPayWithBorrowCount:(CGFloat)borrowCount dailyRate:(CGFloat)dailyRate borrowMounthNum:(NSUInteger)mounthNum{
    CGFloat zongLiXi = borrowCount * dailyRate * mounthNum * 30;
    NSString* str = [NSString stringWithFormat:@"%.3lf",(borrowCount + zongLiXi) / mounthNum];
    return [NSString stringWithFormat:@"¥%@",@(str.floatValue)];
}

/**
 调整字符串中特定字段的颜色和字体大小
 
 @param coreString 目标字符串
 @param coreStringColor 目标颜色
 @param coreStringFont 目标字体
 @param formatStringB 目标字符串前面的字符串
 @param formatStringA 目标字符串后面的字符串
 @return 调成后的字符串
 */
+(NSMutableAttributedString *)setAttributeStringWithCoreScring:(NSString *)coreString
                                               coreStringColor:(UIColor *)coreStringColor
                                                coreStringFont:(UIFont *)coreStringFont
                                             formatStringBefor:(NSString *)formatStringB
                                             formatStringAfter:(NSString *)formatStringA{
    
    NSString * titleString = @"";
    if (formatStringB) {
        titleString = [@"" stringByAppendingFormat:@"%@%@",formatStringB,coreString];
    }
    else{
        titleString = coreString;
    }
    if (formatStringA) {
        titleString = [titleString stringByAppendingString:formatStringA];
    }
    NSMutableAttributedString * hintString = [[NSMutableAttributedString alloc] initWithString:titleString];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1 = [[hintString string] rangeOfString:coreString];
    if (coreStringColor) {
        [hintString addAttribute:NSForegroundColorAttributeName value:coreStringColor range:range1];
    }
    
    if (coreStringFont) {
        [hintString addAttribute:NSFontAttributeName value:coreStringFont range:range1];
    }
    
    
    return hintString;
}

#pragma mark - 按钮点击事件

-(void)setBtnClicked:(UIButton *)btn{
    
}

-(void)closeBtnClicked{
    NSArray * vcs = [self.navigationController viewControllers];
    [self.navigationController popToViewController:vcs[vcs.count - 3] animated:YES];
}

-(void)choseHuanKuanQiShuBtnClicked:(XZJAfterNumEnterShowView *)btn{
    NSArray * qixianArray = @[@"5个月",@"10个月",@"20个月"];
    weakify(self);
    [XZJActionShitPicker showPickerWithTitle:nil
                                         rows:qixianArray
                             initialSelection:self.selectQiXianIndex
                                    doneBlock:^(XZJActionShitPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                        weakSelf.afterNumEnterShowView.choseHuanKuanQiShuBtn.subtitltLabel.text = selectedValue;
                                        weakSelf.selectQiXianIndex = selectedIndex;
                                        NSUInteger borrowNumMonth = 10;
                                        switch (selectedIndex) {
                                            case 0:{
                                                //5
                                                borrowNumMonth = 5;
                                            }
                                                break;
                                            case 1:{
                                                //10
                                                borrowNumMonth = 10;
                                            }
                                                break;
                                            default:{
                                                //20
                                                borrowNumMonth = 20;
                                            }
                                                break;
                                        }
                                        SingleTon * singleTon = [SingleTon sharedSingleTon];
                                        singleTon.kouKuanRi = [JieQianViewController getCurrentDay];
                                        singleTon.bQiXian = [NSString stringWithFormat:@"%lu",(unsigned long)borrowNumMonth];
                                        singleTon.bFirstBackMoneyDate = [NSString stringWithFormat:@"%@月%@号",[JieQianViewController getNextMonth],[JieQianViewController getCurrentDay]];
                                        NSDate *now = [NSDate date];
                                        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                                        [formatter setDateFormat:@"yyyy/MM/dd"];
                                        singleTon.bFrondTime = [formatter stringFromDate:now];
                                        //结束日期
                                        NSTimeInterval timeInter = 10 * 30 * 24 * 60 * 60;
                                        NSDate * timeData = [NSDate dateWithTimeInterval:timeInter sinceDate:now];
                                        [formatter setDateFormat:@"yyyy/MM"];
                                        singleTon.bEndTime = [NSString stringWithFormat:@"%@/%@",[formatter stringFromDate:timeData],[JieQianViewController getCurrentDay]];
                                        NSString * returnCountMounthly = [JieQianViewController getMounthPayWithBorrowCount:[weakSelf.borrowMoneyView.moneyTextField.text floatValue]
                                                                                 dailyRate:singleTon.riLiLv/100//0.0005
                                                                           borrowMounthNum:borrowNumMonth];
                                        returnCountMounthly = [returnCountMounthly stringByReplacingOccurrencesOfString:@"¥" withString:@""];
                                        singleTon.bReturnCountMounthly = returnCountMounthly;
                                        singleTon.bQiXian = [NSString stringWithFormat:@"%lu",(unsigned long)borrowNumMonth];
                                        singleTon.bFirstBackMoneyDate = [NSString stringWithFormat:@"%@月%@日",[JieQianViewController getNextMonth],[JieQianViewController getCurrentDay]];
                                        //grayHuanKuanQiShuTitleColor
    weakSelf.afterNumEnterShowView.subtitltLabel1.attributedText = [JieQianViewController setAttributeStringWithCoreScring:[NSString stringWithFormat:@"(%@月%@号)",[JieQianViewController getNextMonth],[JieQianViewController getCurrentDay]]
                                               coreStringColor:[UIColor blackColor]
                                                coreStringFont:[UIFont systemFontOfSize:DEFAULT_FONTSIZE]
                                             formatStringBefor:returnCountMounthly
                                             formatStringAfter:nil];
                                        
                                    }
                                  cancelBlock:^(XZJActionShitPicker *picker) {
                                  } origin:self.view];
}

-(void)nextBuBtnClicked:(UIButton *)btn{
    weakify(self);
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    if (self.nextBtn.enabled && !self.afterNumEnterShowView.hidden && self.choseBankCardView.hidden) {
        //开始选择银行卡
        
        //上面的视图变色
        self.borrowMoneyView.backgroundColor = grayHuanKuanQiShuBGColor;
        self.borrowMoneyView.moneyTextField.enabled = NO;
        self.afterNumEnterShowView.choseHuanKuanQiShuBtn.backgroundColor = grayHuanKuanQiShuBGColor;
        self.afterNumEnterShowView.choseHuanKuanQiShuBtn.enabled = NO;
        
        if (!cingleTon.isNeedMessage) {
            [self.nextBtn setTitle:@"确认借钱" forState:UIControlStateNormal];
        }
        
        weakSelf.choseBankCardView.hidden = NO;
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.choseBankCardView.frame = CGRectMake(weakSelf.borrowMoneyView.frame.origin.x, weakSelf.afterNumEnterShowView.frame.size.height + weakSelf.afterNumEnterShowView.frame.origin.y, weakSelf.borrowMoneyView.frame.size.width, choseBankCardViewH);
            weakSelf.nextBtn.frame = CGRectMake(weakSelf.borrowMoneyView.frame.origin.x, weakSelf.choseBankCardView.frame.size.height + weakSelf.choseBankCardView.frame.origin.y-1, weakSelf.borrowMoneyView.frame.size.width, nextBtnH);
            //            weakSelf.mainScrollView.contentSize = CGSizeMake(weakSelf.borrowMoneyView.frame.size.width, weakSelf.mainScrollView.contentSize.height + choseBankCardViewH + weakSelf.nextBtn.frame.size.height + contentSiseSpaceH);
            weakSelf.mainScrollView.contentSize = CGSizeMake(weakSelf.borrowMoneyView.frame.size.width, weakSelf.nextBtn.frame.origin.y + weakSelf.nextBtn.frame.size.height + contentSiseSpaceH);
//            [weakSelf.mainScrollView setContentOffset:CGPointMake(0, weakSelf.choseBankCardView.frame.origin.y - Width_Scall * 64)];
            [weakSelf.mainScrollView setContentOffset:CGPointMake(0, weakSelf.choseBankCardView.frame.origin.y +10)];
            
            weakSelf.label3.frame = CGRectMake(0, weakSelf.mainScrollView.contentSize.height - label3Count, SCREEN_WIDTH, label3H);
        }];
        return;
    }
    if (self.borrowMoneyView.moneyTextField.enabled == NO) {
        cingleTon.bBorrowCountTemp = self.borrowMoneyView.moneyTextField.text;
    }
    
    if (self.borrowMoneyView.moneyTextField.enabled == NO && self.afterNumEnterShowView.choseHuanKuanQiShuBtn.enabled == NO && self.writeUserInfoView.hidden && cingleTon.isNeedMessage) {
        //这里应该出填写个人信息的视图 存储信息到单例
            self.writeUserInfoView.hidden = NO;
            self.choseBankCardView.backgroundColor = grayHuanKuanQiShuBGColor;
            self.choseBankCardView.choseBankCardBtn.enabled = NO;
            self.choseBankCardView.juChiImageView.hidden = YES;
            [UIView animateWithDuration:0.4 animations:^{
                weakSelf.writeUserInfoView.frame = CGRectMake(self.borrowMoneyView.frame.origin.x, self.choseBankCardView.frame.size.height + self.choseBankCardView.frame.origin.y - 1, self.borrowMoneyView.frame.size.width, writeUserInfoViewH);
                weakSelf.nextBtn.frame = CGRectMake(weakSelf.borrowMoneyView.frame.origin.x, weakSelf.writeUserInfoView.frame.size.height + weakSelf.writeUserInfoView.frame.origin.y, weakSelf.borrowMoneyView.frame.size.width, nextBtnH);
                weakSelf.mainScrollView.contentSize = CGSizeMake(weakSelf.borrowMoneyView.frame.size.width, weakSelf.nextBtn.frame.origin.y + weakSelf.nextBtn.frame.size.height + 358/3);
                [weakSelf.mainScrollView setContentOffset:CGPointMake(0, weakSelf.writeUserInfoView.frame.origin.y + 10)];//113/3
                weakSelf.label3.frame = CGRectMake(0, weakSelf.mainScrollView.contentSize.height - label3Count, SCREEN_WIDTH, label3H);
            }];
            [self.writeUserInfoView createLabelsIfBeforeClickMoreBtn:YES];
//        }
        
        cingleTon.bBorrowCountTemp = self.borrowMoneyView.moneyTextField.text;
        
        [self.nextBtn setTitle:@"确认借钱" forState:UIControlStateNormal];
        
        return;
    }
    
    if ([self.nextBtn.titleLabel.text isEqualToString:@"确认借钱"]) {
        //跳转写下一页
        if (cingleTon.isNeedMessage) {
            if (self.writeUserInfoView.nameView.valueTextField.text.length == 0) {
                [JieQianViewController createModeTextProgressHUDInParentView:self.view andLabelText:@"请补全名字" delayTime:0.8];
                return;
            }
            if (self.writeUserInfoView.IdNumView.valueTextField.text.length != 4) {
                [JieQianViewController createModeTextProgressHUDInParentView:self.view andLabelText:@"请补全身份证后四位" delayTime:0.8];
                return;
            }
            cingleTon.bFirstName = self.writeUserInfoView.nameView.valueTextField.text;
            cingleTon.bIdCard2Temp = self.writeUserInfoView.IdNumView.valueTextField.text;
        }
        else{
            cingleTon.bFirstName = @"";
            cingleTon.bIdCard2Temp = @"9999";
        }
        [self nextBtnCLicked];
    }
}

/**
 创建文本提示的MBProgressHUD
 */
+(void)createModeTextProgressHUDInParentView:(UIView *_Nullable)view
                                andLabelText:(NSString * _Nullable)text
                                   delayTime:(CGFloat)delayTime{
    MBProgressHUD * progressHUD = [JieQianViewController createDefaultProgressHUDInParentView:view];
    progressHUD.mode = MBProgressHUDModeText;
    if (text) {
        progressHUD.labelText = text;
    }
    [progressHUD hide:YES afterDelay:delayTime];
}

/**
 创建默认旋转菊花的MBProgressHUD
 
 @param view 添加到的视图
 @return progressHUD
 */
+(MBProgressHUD *)createDefaultProgressHUDInParentView:(UIView *)view{
    MBProgressHUD * progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    return progressHUD;
}


-(void)moreBtnClicked:(UIButton *)btn{
    if (self.writeUserInfoView.nameView.valueTextField.text.length == 0) {
        [JieQianViewController createModeTextProgressHUDInParentView:self.view andLabelText:@"请补全名字" delayTime:0.8];
        return;
    }
    if (self.writeUserInfoView.IdNumView.valueTextField.text.length != 4) {
        [JieQianViewController createModeTextProgressHUDInParentView:self.view andLabelText:@"请补全身份证后四位" delayTime:0.8];
        return;
    }

    btn.hidden = YES;
    [self.writeUserInfoView createLabelsIfBeforeClickMoreBtn:NO];
    //延长视图
    weakify(self);
    
//    CGFloat labelH = [@"首次还款日" getHeightWithFont:[UIFont systemFontOfSize:DEFAULT_FONTSIZE] constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
//    CGFloat messageLabelH = [@"请仔细阅读本借据信息，点击确认借钱表示你同意遵守《合同及相关协议》" getHeightWithFont:[UIFont systemFontOfSize:DEFAULT_FONTSIZE] constrainedToSize:CGSizeMake(self.borrowMoneyView.frame.size.width - Width_Scall * 56 - spaceMargin, MAXFLOAT)];
//    CGFloat moreBtnH = Width_Scall * 90;
//    CGFloat whiteBGViewH = Width_Scall * 397;
//    CGFloat writeUserInfoViewH = spaceMargin + (spaceMargin + labelH) * 5 + moreBtnH + whiteBGViewH;
    
//    CGFloat writeUserInfoViewH2 = spaceMargin + (spaceMargin + labelH) * 10 + moreBtnH + whiteBGViewH + messageLabelH ;//+ spaceMargin * 2;
    CGFloat writeUserInfoViewH2 = 1272/3;
    self.writeUserInfoView.whiteBGView.frame = CGRectMake(self.writeUserInfoView.whiteBGView.frame.origin.x, self.writeUserInfoView.whiteBGView.frame.origin.y, self.writeUserInfoView.whiteBGView.frame.size.width, 0);
    self.writeUserInfoView.titleLabel.hidden = YES;
    self.writeUserInfoView.nameView.hidden = YES;
    self.writeUserInfoView.IdNumView.hidden = YES;
    self.writeUserInfoView.whiteBGViewBottomLineView.hidden = YES;
    self.writeUserInfoView.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.writeUserInfoView.frame = CGRectMake(self.borrowMoneyView.frame.origin.x, self.choseBankCardView.frame.size.height + self.choseBankCardView.frame.origin.y - 1, self.borrowMoneyView.frame.size.width, writeUserInfoViewH2);
        weakSelf.nextBtn.frame = CGRectMake(weakSelf.borrowMoneyView.frame.origin.x, weakSelf.writeUserInfoView.frame.size.height + weakSelf.writeUserInfoView.frame.origin.y, weakSelf.borrowMoneyView.frame.size.width, nextBtnH);
//        weakSelf.mainScrollView.contentSize = CGSizeMake(weakSelf.borrowMoneyView.frame.size.width, weakSelf.mainScrollView.contentSize.height - writeUserInfoViewH + writeUserInfoViewH2);
        weakSelf.mainScrollView.contentSize = CGSizeMake(weakSelf.borrowMoneyView.frame.size.width, weakSelf.nextBtn.frame.origin.y + weakSelf.nextBtn.frame.size.height + 422/3);
//        [weakSelf.mainScrollView setContentOffset:CGPointMake(0, weakSelf.writeUserInfoView.frame.origin.y - Width_Scall * 64)];
        [weakSelf.mainScrollView setContentOffset:CGPointMake(0, weakSelf.writeUserInfoView.frame.origin.y + 10)];//113/3
        weakSelf.label3.frame = CGRectMake(0, weakSelf.mainScrollView.contentSize.height - label3Count, SCREEN_WIDTH, label3H);
    }];

}

-(void)supportBankBtnAction{
    [self.choseSupportBankView showViewAnimated];
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    SingleTon * singleTon = [SingleTon sharedSingleTon];
    NSString * yuE = [NSString stringWithFormat:@"%ld",singleTon.keBorrowCount];
    NSString * inputValue = textField.text;
    NSString * willShowText = @"";
    if (string.length == 0 && inputValue.length > 0) {
        willShowText = [inputValue substringToIndex:range.location];
    }
    else{
        willShowText = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    if (willShowText.length > yuE.length) {
        return NO;
    }
    if ([willShowText integerValue] > singleTon.keBorrowCount) {
        return NO;
    }
    weakify(self);
//    if (inputValue.length >= yuE.length - 2) {
//    if ((inputValue.length >= 1 || inputValue.length >= yuE.length - 2) && ([willShowText integerValue] != 0) && (textField.text.length != 0)) {
//    if ([willShowText integerValue] >= 500&&[willShowText integerValue]%100 == 0) {
    if ([willShowText integerValue] >= 500) {
        singleTon.kouKuanRi = [JieQianViewController getCurrentDay];
        singleTon.bFirstBackMoneyDate = [NSString stringWithFormat:@"%@月%@日",[JieQianViewController getNextMonth],[JieQianViewController getCurrentDay]];
        singleTon.bQiXian = @"10";
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        singleTon.bFrondTime = [formatter stringFromDate:now];
        //结束日期
        NSTimeInterval timeInter = 10 * 30 * 24 * 60 * 60;
        NSDate * timeData = [NSDate dateWithTimeInterval:timeInter sinceDate:now];
        [formatter setDateFormat:@"yyyy/MM"];
        singleTon.bEndTime = [NSString stringWithFormat:@"%@/%@",[formatter stringFromDate:timeData],[JieQianViewController getCurrentDay]];
        //grayHuanKuanQiShuTitleColor
        self.afterNumEnterShowView.subtitltLabel1.attributedText = [JieQianViewController setAttributeStringWithCoreScring:[NSString stringWithFormat:@"(%@月%@号)",[JieQianViewController getNextMonth],[JieQianViewController getCurrentDay]]
                                               coreStringColor:[UIColor blackColor]
                                                coreStringFont:[UIFont systemFontOfSize:DEFAULT_FONTSIZE]
                                             formatStringBefor:[JieQianViewController getMounthPayWithBorrowCount:[willShowText floatValue]
                                                                                                        dailyRate:singleTon.riLiLv/100//0.0005
                                                                                                  borrowMounthNum:10]
                                             formatStringAfter:nil];
        if (weakSelf.nextBtn.frame.origin.y == (weakSelf.borrowMoneyView.frame.size.height + weakSelf.borrowMoneyView.frame.origin.y + afterShowH)) {
            return YES;
        }
        self.nextBtn.enabled = YES;
        self.afterNumEnterShowView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.afterNumEnterShowView.frame = CGRectMake(weakSelf.borrowMoneyView.frame.origin.x, weakSelf.borrowMoneyView.frame.size.height + weakSelf.borrowMoneyView.frame.origin.y - 1, weakSelf.borrowMoneyView.frame.size.width, afterShowH);
            weakSelf.nextBtn.frame = CGRectMake(weakSelf.borrowMoneyView.frame.origin.x, weakSelf.borrowMoneyView.frame.size.height + weakSelf.borrowMoneyView.frame.origin.y + afterShowH - 2, weakSelf.borrowMoneyView.frame.size.width, nextBtnH);
        }];
        
        
        return YES;
    }
    else{
        if (weakSelf.nextBtn.frame.origin.y == (weakSelf.borrowMoneyView.frame.size.height + weakSelf.borrowMoneyView.frame.origin.y)) {
            return YES;
        }
        self.nextBtn.enabled = NO;
        self.afterNumEnterShowView.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.afterNumEnterShowView.frame = CGRectMake(weakSelf.borrowMoneyView.frame.origin.x, weakSelf.borrowMoneyView.frame.size.height + weakSelf.borrowMoneyView.frame.origin.y - 1, weakSelf.borrowMoneyView.frame.size.width, 0);
            weakSelf.nextBtn.frame = CGRectMake(weakSelf.borrowMoneyView.frame.origin.x, weakSelf.borrowMoneyView.frame.size.height + weakSelf.borrowMoneyView.frame.origin.y, weakSelf.borrowMoneyView.frame.size.width, nextBtnH);
//            weakSelf.lineView2.frame = CGRectMake(weakSelf.borrowMoneyView.frame.origin.x, weakSelf.nextBtn.frame.origin.y, weakSelf.borrowMoneyView.frame.size.width, 1);
        }];
        return YES;
    }
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.borrowMoneyView.moneyTextField resignFirstResponder];
    [self.writeUserInfoView.nameView.valueTextField resignFirstResponder];
    [self.writeUserInfoView.IdNumView.valueTextField resignFirstResponder];
}


#pragma mark - 懒加载

-(BorrowMoneyView *)borrowMoneyView{
    if (!_borrowMoneyView) {
        _borrowMoneyView = [[BorrowMoneyView alloc] initWithFrame:CGRectMake(46/3, 63/3, SCREEN_WIDTH - (46/3) * 2, 719/3)];
        _borrowMoneyView.layer.borderWidth = 1;
        _borrowMoneyView.layer.borderColor = grayBorderColor.CGColor;
        _borrowMoneyView.moneyTextField.delegate = self;
    }
    return _borrowMoneyView;
}

-(UILabel *)label3{
    if (!_label3) {
        _label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.mainScrollView.contentSize.height - label3Count, SCREEN_WIDTH, label3H)];
        _label3.text = @"本服务由微众银行提供";
        _label3.textColor = ColorWithRGB(154, 155, 154, 1);
        _label3.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _label3.textAlignment = NSTextAlignmentCenter;
        _label3.numberOfLines = 1;
    }
    return _label3;
}

-(UITapGestureRecognizer *)tapGesture{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWriteEvaluationView:)];
        _tapGesture.delegate = self;
    }
    return _tapGesture;
}

-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.borrowMoneyView.frame.origin.x, self.choseBankCardView.frame.size.height + self.choseBankCardView.frame.origin.y, self.borrowMoneyView.frame.size.width, nextBtnH)];
        _nextBtn.backgroundColor = [UIColor whiteColor];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 5];
        [_nextBtn setTitleColor:ColorWithRGB(188, 188, 188, 1) forState:UIControlStateDisabled];
        [_nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_nextBtn setTitleColor:ColorWithRGB(228, 175, 49, 1) forState:UIControlStateNormal];
//        [_nextBtn setTitleColor:[UIColor colorWithHTRGB:0x464440] forState:UIControlStateNormal];
//        _nextBtn.layer.borderWidth = 0.7;
//        _nextBtn.layer.borderColor = grayBorderColor.CGColor;
        [self setBorderWithView:_nextBtn top:NO left:YES bottom:YES right:YES borderColor:grayBorderColor borderWidth:1];
        _nextBtn.enabled = NO;
        [_nextBtn addTarget:self action:@selector(nextBuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_nextBtn addSubview:self.lineView2];
    }
    return _nextBtn;
}
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}

-(UIView *)lineView2{
    if (!_lineView2) {
//        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(self.borrowMoneyView.frame.origin.x, self.nextBtn.frame.origin.y, self.borrowMoneyView.frame.size.width, 1)];
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, -1, self.borrowMoneyView.frame.size.width, 2)];
        _lineView2.backgroundColor = ColorWithRGB(231, 187, 44, 1);//ColorWithRGB(234, 213, 163, 1);
    }
    return _lineView2;
}

-(XZJAfterNumEnterShowView *)afterNumEnterShowView{
    if (!_afterNumEnterShowView) {
        _afterNumEnterShowView = [[XZJAfterNumEnterShowView alloc] initWithFrame:CGRectMake(self.borrowMoneyView.frame.origin.x, self.borrowMoneyView.frame.size.height + self.borrowMoneyView.frame.origin.y - 1, self.borrowMoneyView.frame.size.width, 0)];
        _afterNumEnterShowView.hidden = YES;
        [_afterNumEnterShowView.choseHuanKuanQiShuBtn addTarget:self action:@selector(choseHuanKuanQiShuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        SingleTon * singleTon = [SingleTon sharedSingleTon];
        singleTon.kouKuanRi = [JieQianViewController getCurrentDay];
        _afterNumEnterShowView.subtitltLabel2.text = [NSString stringWithFormat:@"每月%@日",[JieQianViewController getCurrentDay]];
//        _afterNumEnterShowView.subtitltLabel1.text = [NSString stringWithFormat:@"每月%@日",[JieQianViewController getCurrentDay]];
    }
    return _afterNumEnterShowView;
}

-(XZJChoseBackCardView *)choseBankCardView{
    if (!_choseBankCardView) {
        _choseBankCardView = [[XZJChoseBackCardView alloc] initWithFrame:CGRectMake(self.borrowMoneyView.frame.origin.x, self.afterNumEnterShowView.frame.size.height + self.afterNumEnterShowView.frame.origin.y, self.borrowMoneyView.frame.size.width, 0) firstBankCardIndex:self.index cardNum:self.kahao];
        _choseBankCardView.hidden = YES;
        [_choseBankCardView.supportBankBtn addTarget:self action:@selector(supportBankBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _choseBankCardView;
}

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - NavigationBarHeight - TabBarHeight- _BottomViewH)];
        [_mainScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - TabBarHeight- NavigationBarHeight + 0.3 - _BottomViewH)];
        _mainScrollView.showsVerticalScrollIndicator = YES;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
        
    }
    return _mainScrollView;
}

-(ChangeBankCardView *)chengeBankCardView1{
    if (!_chengeBankCardView1) {
        _chengeBankCardView1 = [[ChangeBankCardView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight + StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - StatusBarHeight) firstBankCardIndex:self.index cardNum:self.kahao];
        _chengeBankCardView1.jieqianVC = self;
        _chengeBankCardView1.hidden = YES;
    }
    return _chengeBankCardView1;
}

-(InputUserInfoView *)writeUserInfoView{
    if (!_writeUserInfoView) {
        _writeUserInfoView = [[InputUserInfoView alloc] initWithFrame:CGRectMake(self.borrowMoneyView.frame.origin.x, self.choseBankCardView.frame.size.height + self.choseBankCardView.frame.origin.y - 1, self.borrowMoneyView.frame.size.width, 0)];
        _writeUserInfoView.hidden = YES;
        [_writeUserInfoView.moreBtn addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _writeUserInfoView;
}

-(XZJChoseSupportBankView *)choseSupportBankView{
    if (!_choseSupportBankView) {
        _choseSupportBankView = [[XZJChoseSupportBankView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight + StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - StatusBarHeight)];
        [_choseSupportBankView hideViewAnimated];
    }
    return _choseSupportBankView;
}

@end
