//
//  WaittingShenHeViewController.m
//  WeiLiDai
//
//  Created by j on 2018/2/4.
//  Copyright © 2018年 j. All rights reserved.
//

#import "BorrowSuccessViewController.h"
#import "UIColor+HTRGB.h"
#import "XZJBaseViewController.h"

#define sucheadImageViewWH (286/3 + 9)
//#define sucheadImageViewWH (286/3)
#define bankSignImageViewWH (68/3)
#define moneyLabelNumFontSize (42.5)

@interface BorrowSuccessViewController ()

@property (nonatomic, strong) UIImageView * headImageView;
@property (nonatomic, strong) UILabel * titleLabel;//微众银行已放款
//@property (nonatomic, strong) UILabel * rmbLabel;
@property (nonatomic, strong) UIImageView * rmbImageView;
@property (nonatomic, strong) UILabel * moneyLabel;//¥555.00
@property (nonatomic, strong) UILabel * messageLabel;//预计15分钟到账

@property (nonatomic, strong) UIView * topLineView;
@property (nonatomic, strong) UIView * bottomLineView;
@property (nonatomic, strong) UILabel * bankTitleLabel;
@property (nonatomic, strong) UIImageView * bankSignImageView;
@property (nonatomic, strong) UILabel * bankNameLabel;

@property (nonatomic, strong) UIButton * doneBtn;

@property (nonatomic, strong) UILabel * bottomMessageLabel;//本服务由微众银行提供
@end

@implementation BorrowSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
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
    
//    UIBarButtonItem * closeBtn = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
//                                                                  style:UIBarButtonItemStyleDone
//                                                                 target:self
//                                                                 action:@selector(nextBtnCLicked)];
//
//    self.navigationItem.leftBarButtonItems = @[leftItemBtn,closeBtn];
//    self.title = @"借款申请成功";
    [self.view addSubview:self.headImageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.moneyLabel];
    [self.view addSubview:self.rmbImageView];
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.topLineView];
    [self.view addSubview:self.bottomLineView];
    [self.view addSubview:self.bankTitleLabel];
    [self.view addSubview:self.bankSignImageView];
    [self.view addSubview:self.bankNameLabel];
    [self.view addSubview:self.doneBtn];
    [self.view addSubview:self.bottomMessageLabel];
    UIView * bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight + StatusBarHeight)];
    bgView2.backgroundColor = grayNavigationBGColor;//[UIColor blackColor];
    [self.view addSubview:bgView2];
    weakify(self);
    CGFloat headImageViewY = NavigationBarHeight + StatusBarHeight + 234/3;
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(sucheadImageViewWH, sucheadImageViewWH));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.view.mas_top).with.offset(headImageViewY);
    }];
    CGFloat titleLabelSpaceY = 87/3;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        CGFloat labelH = [weakSelf.titleLabel.text getHeightWithFont:weakSelf.titleLabel.font constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50/3));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.headImageView.mas_bottom).with.offset(titleLabelSpaceY);
    }];
//    CGFloat moneyLabelSpaceY = 56/3;
    CGFloat messageLabelSpaceY = 189/3;
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGSize labelSZ = [weakSelf.moneyLabel.text getSizeWithFont:[UIFont fontWithName:@"WeChat Sans Std" size:moneyLabelNumFontSize] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        make.size.mas_equalTo(CGSizeMake(labelSZ.width, labelSZ.height));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(messageLabelSpaceY / 2);
    }];
    [self.rmbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(48/3, 66/3));
        make.top.mas_equalTo(weakSelf.moneyLabel.mas_top).with.offset(39/3);
        make.left.mas_equalTo(weakSelf.moneyLabel.mas_left).with.offset(24/3);
    }];
    
    
    CGFloat messageLabelW = SCREEN_WIDTH - spaceMargin * 6;
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(messageLabelW, 49/3));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(messageLabelSpaceY);
    }];
    CGFloat topLineViewSpaceY = 96/3;
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - spaceMargin * 2, 1));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.messageLabel.mas_bottom).with.offset(topLineViewSpaceY);
    }];
    
    CGFloat bottomLineViewSpaceY = 134/3;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - spaceMargin * 2, 1));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.topLineView.mas_bottom).with.offset(bottomLineViewSpaceY);
    }];
    
    CGFloat bankTitleLabelX = 18/3;
    [self.bankTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat labelW = [weakSelf.bankTitleLabel.text getWidthWithFont:weakSelf.bankTitleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, bottomLineViewSpaceY)];
        make.size.mas_equalTo(CGSizeMake(labelW, bottomLineViewSpaceY));
        make.top.mas_equalTo(weakSelf.topLineView.mas_bottom);
        make.left.mas_equalTo(weakSelf.topLineView.mas_left).with.offset(bankTitleLabelX);
    }];
    
    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat labelW = [weakSelf.bankNameLabel.text getWidthWithFont:weakSelf.bankNameLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, bottomLineViewSpaceY)];
        make.size.mas_equalTo(CGSizeMake(labelW, bottomLineViewSpaceY));
        make.top.mas_equalTo(weakSelf.bankTitleLabel.mas_top);
        make.right.mas_equalTo(weakSelf.topLineView.mas_right).with.offset(-12/3);
    }];
    
    [self.bankSignImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(bankSignImageViewWH, bankSignImageViewWH));
        make.centerY.mas_equalTo(weakSelf.bankNameLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.bankNameLabel.mas_left).with.offset(-28/3);
    }];
    
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - spaceMargin * 2, 126/3));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.bottomLineView.mas_bottom).with.offset(126/3);
    }];
    
}

-(void)backBtnClicked:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)nextBtnCLicked{
    NSArray * vcs = [self.navigationController viewControllers];
    [self.navigationController popToViewController:vcs[vcs.count - 3] animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"借款申请成功";
//    [self.navigationController.navigationBar setBackgroundImage:[FactryFucClass imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
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
//    self.title = @"返回";
//    UIImage *bgImage = [[UIImage imageNamed:@"navigationView"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
//    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    XZJBaseViewController * baseVC = [XZJBaseViewController sharedBaseViewController];
    [baseVC.btnsView hideView];
}

-(void)setBtnClicked:(UIButton *)btn{
    
}

-(void)closeBtnClicked{
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
        _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"applySuccess"]];
        _headImageView.frame = CGRectMake(0, 0, sucheadImageViewWH, sucheadImageViewWH);
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"微众银行已放款";
        _titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 2];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UIImageView *)rmbImageView{
    if (!_rmbImageView) {
        _rmbImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RMBBlack"]];
        _rmbImageView.frame = CGRectMake(0, 0, 0, Width_Scall * 164);
        _rmbImageView.contentMode = UIViewContentModeScaleAspectFill;
        //        _rmbImageView.layer.masksToBounds = YES;
    }
    return _rmbImageView;
}

-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        _moneyLabel.text = [NSString stringWithFormat:@"   %@.00",cingleTon.bBorrowCount];
        _moneyLabel.font = [UIFont fontWithName:@"WeChat Sans Std" size:moneyLabelNumFontSize];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.textColor = [UIColor blackColor];
        _moneyLabel.numberOfLines = 0;
    }
    return _moneyLabel;
}


-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        
        _messageLabel.text = [NSString stringWithFormat:@"预计%@分钟内到账",cingleTon.witeTime];
        _messageLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.textColor = ColorWithRGB(179, 177, 179, 1);
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

-(UIView *)topLineView{
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = grayBorderColor;
    }
    return _topLineView;
}

-(UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = grayBorderColor;
    }
    return _bottomLineView;
}

-(UILabel *)bankTitleLabel{
    if (!_bankTitleLabel) {
        _bankTitleLabel = [[UILabel alloc] init];
        _bankTitleLabel.text = @"收款银行卡";
        _bankTitleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _bankTitleLabel.textAlignment = NSTextAlignmentLeft;
        _bankTitleLabel.textColor = [UIColor blackColor];
        _bankTitleLabel.numberOfLines = 0;
    }
    return _bankTitleLabel;
}


-(UIImageView *)bankSignImageView{
    if (!_bankSignImageView) {
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        NSDictionary * dic = bankCards[cingleTon.bBankSignIndex];
        _bankSignImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:dic[@"imageName"]]];
        _bankSignImageView.frame = CGRectMake(0, 0, bankSignImageViewWH, bankSignImageViewWH);
        _bankSignImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bankSignImageView.layer.masksToBounds = YES;
        _bankSignImageView.backgroundColor = [UIColor clearColor];
//        _bankSignImageView.backgroundColor = [UIColor blackColor];
        _bankSignImageView.layer.cornerRadius = bankSignImageViewWH / 2;
    }
    return _bankSignImageView;
}

-(UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        _bankNameLabel.text = [NSString stringWithFormat:@"%@储蓄卡(%@)",cingleTon.bBankName,cingleTon.bBankCardNum];
        _bankNameLabel.textColor = [UIColor blackColor];
        _bankNameLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE - 1];
        _bankNameLabel.textAlignment = NSTextAlignmentRight;
        _bankNameLabel.numberOfLines = 1;
        
    }
    return _bankNameLabel;
}


-(UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneBtn.layer.masksToBounds = YES;
        _doneBtn.layer.cornerRadius = Width_Scall * 8;
//        _doneBtn.layer.borderColor = ColorWithRGB(150, 197, 151, 1).CGColor;
        _doneBtn.layer.borderColor = ColorWithRGB(72, 151, 50, 1).CGColor;
        _doneBtn.layer.borderWidth = 1;
        [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 2];
//        _doneBtn.backgroundColor = ColorWithRGB(26, 173, 25, 1);
        _doneBtn.backgroundColor = [UIColor colorWithHTRGB:0x56bb37];
//        [_doneBtn setBackgroundImage:[CheckPhoneNumViewController imageWithColor:ColorWithRGB(163, 223, 163, 1)] forState:UIControlStateDisabled];
//        [_doneBtn setBackgroundImage:[CheckPhoneNumViewController imageWithColor:ColorWithRGB(26, 173, 25, 1)] forState:UIControlStateNormal];
//        _doneBtn.enabled = NO;
        [_doneBtn addTarget:self action:@selector(doneBtnCLicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

-(UILabel *)bottomMessageLabel{
    if (!_bottomMessageLabel) {
        CGFloat labelH = Width_Scall * 26;
        _bottomMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - messageLabelBottomSpaceY - (IS_IPHONE_X?(labelH + iPhoneXSaftAreaH):labelH) - 50, SCREEN_WIDTH, labelH)];
        _bottomMessageLabel.text = @"本服务由微众银行提供";
        _bottomMessageLabel.textColor = ColorWithRGB(154, 155, 154, 1);
        _bottomMessageLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _bottomMessageLabel.textAlignment = NSTextAlignmentCenter;
        _bottomMessageLabel.numberOfLines = 1;
    }
    return _bottomMessageLabel;
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


@end
