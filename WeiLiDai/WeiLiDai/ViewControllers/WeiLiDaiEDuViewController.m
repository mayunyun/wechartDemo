//
//  WeiLiDaiEDuViewController.m
//  WeiLiDai
//
//  Created by j on 2017/12/20.
//  Copyright © 2017年 j. All rights reserved.
//

#import "WeiLiDaiEDuViewController.h"
#import "EDuView.h"
#import "JieQianViewController.h"
#import "EDuTableViewCell.h"
#import "EDuSectonHeaderView.h"
#import "TiQianHuanKuanViewController.h"
#import "AlertYiJIeViewController.h"
#import "XZJBaseViewController.h"

#define EDuTableViewCellIden @"EDuTableViewCell"

@interface WeiLiDaiEDuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) EDuView * borrowView;
@property (nonatomic, strong) EDuSectonHeaderView * edSectonHeaderView;
@property (nonatomic, strong) UILabel * label1;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UILabel * label2;
@property (nonatomic, strong) UILabel * label3;

/**
 用于计数开启预设可借额度
 */
@property (nonatomic, strong) UIButton * countBtn;

/**
 点击次数
 */
@property (nonatomic, assign) NSUInteger touchCount;

@property (nonatomic, strong) UITableView * myTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation WeiLiDaiEDuViewController

-(instancetype)init{
    if (self = [super init]) {
        self.touchCount = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = NSLocalizedString(@"正在加载", @"HUD loading title");
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
            [self createUI];
//            SingleTon * singleTon = [SingleTon sharedSingleTon];
////            self.borrowView.edLabel.text = [NSString stringWithFormat:@" %ld",singleTon.borrowCount];
//            [self.borrowView resetEDuLabelData:[NSString stringWithFormat:@"%ld",singleTon.borrowCount]];
            [self setTAbleHeaderViewData];
//            SingleTon * cingleTon = [SingleTon sharedSingleTon];
//            NSUInteger restED = cingleTon.borrowCount - [cingleTon.bBorrowCount integerValue];
//            cingleTon.keBorrowCount = restED;
//            [self.borrowView resetEDuLabelData:[NSString stringWithFormat:@"%lu",(unsigned long)cingleTon.keBorrowCount]];
//            self.borrowView.edLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)cingleTon.keBorrowCount];
//            if (cingleTon.bIdCard2.length > 0) {
//                if (ifBorrowSuccess) {
//                    [self refreshData];
//                    [self.borrowView resetSize:CGSizeMake(SCREEN_WIDTH, eduBGViewHaveDataH)];
//                }
//            }
//            else{
//                [self.borrowView resetSize:CGSizeMake(SCREEN_WIDTH, eduBGViewH)];
//            }
//            self.myTableView.tableHeaderView = self.borrowView;
        });
        
    });
}

-(void)refreshData{
    [self.dataArray removeAllObjects];
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    NSString* money = [NSString stringWithFormat:@"%.2f",[cingleTon.bReturnCountMounthly floatValue]];
    [self.dataArray addObject:@{@"returnMoneyDate":cingleTon.bFirstBackMoneyDate,@"returnMoneyCount":money,@"bankCardName":cingleTon.bBankName,@"bankCardNum":cingleTon.bBankCardNum}];
    [self.myTableView reloadData];
}

-(void)createUI{
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    if (@available(iOS 10.0, *)) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.myTableView];
    UIView * bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight + StatusBarHeight)];
    bgView2.backgroundColor = grayNavigationBGColor;
    [self.view addSubview:bgView2];
    [self.view addSubview:self.label1];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.label3];
    [self.view addSubview:self.countBtn];
    weakify(self);
    CGFloat space = Width_Scall * 14;
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, Width_Scall * 26));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).with.offset(-messageLabelBottomSpaceY);
        make.top.mas_equalTo(weakSelf.lineView.mas_bottom).with.offset(Width_Scall * 12);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, Width_Scall * 26));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.bottom.mas_equalTo(weakSelf.label3.mas_top).with.offset(-Width_Scall * 12);
        make.left.mas_equalTo(weakSelf.label1.mas_right).with.offset(space);
        make.right.mas_equalTo(weakSelf.label2.mas_left).with.offset(-space);
    }];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.lineView.mas_height);
        make.centerY.mas_equalTo(weakSelf.lineView.mas_centerY);
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.right.mas_equalTo(weakSelf.lineView.mas_left).with.offset(-space);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.lineView.mas_height);
        make.centerY.mas_equalTo(weakSelf.lineView.mas_centerY);
        make.right.mas_equalTo(weakSelf.view.mas_right);
        make.left.mas_equalTo(weakSelf.lineView.mas_right).with.offset(space);
    }];
    
    [self.countBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat label3W = [weakSelf.label3.text getWidthWithFont:weakSelf.label3.font constrainedToSize:CGSizeMake(MAXFLOAT, 13)];
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(weakSelf.label1.mas_top);
        make.bottom.mas_equalTo(weakSelf.label3.mas_bottom);
        make.width.mas_equalTo(@(label3W));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    self.touchCount = 1;
    
    [self setTAbleHeaderViewData];
    self.myTableView.tableHeaderView = self.borrowView;
//    [self.navigationController.navigationBar setBackgroundImage:[FactryFucClass imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
//    [self.dataArray removeAllObjects];
//    [self.dataArray addObject:@{@"returnMoneyDate":@"2月11日",@"returnMoneyCount":@"8888",@"bankCardName":@"中国银行",@"bankCardNum":@"6666"}];
//    [self.myTableView reloadData];
    
    XZJBaseViewController * baseVC = [XZJBaseViewController sharedBaseViewController];
    [baseVC.btnsView hideView];
    [baseVC.btnsView setLeftBtnEnabled:NO];
    [baseVC.btnsView setRightBtnEnabled:NO];
    baseVC.btnsView.leftClickedBlock = ^{
        
    };
    
    baseVC.btnsView.rightClickedBlock = ^{
        
    };
}

-(void)setTAbleHeaderViewData{
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    NSUInteger restED = cingleTon.borrowCount - [cingleTon.bBorrowCount integerValue];
//    if (cingleTon.isOnYuShe == YES) {
//        restED =  cingleTon.yuSheKeJieEDu;
//    }
    cingleTon.keBorrowCount = restED;
    if (restED >= 500) {
        self.borrowView.borrowBtn.enabled = YES;
    }
    else{
        self.borrowView.borrowBtn.enabled = NO;
    }
    
    [self.borrowView resetEDuLabelData:[NSString stringWithFormat:@"%lu",(unsigned long)cingleTon.keBorrowCount]];
//    self.borrowView.edLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)cingleTon.keBorrowCount];
    if (cingleTon.bIdCard2.length > 0) {
        if (ifBorrowSuccess) {
            [self refreshData];
            [self.borrowView resetSize:CGSizeMake(SCREEN_WIDTH, eduBGViewHaveDataH)];
        }
    }
    else{
        [self.borrowView resetSize:CGSizeMake(SCREEN_WIDTH, eduBGViewH)];
        self.label1.hidden = NO;
        self.label2.hidden = NO;
        self.label3.hidden = NO;
        self.lineView.hidden = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.title = @"返回";
    UIImage *bgImage = [[UIImage imageNamed:@"发现导航"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];//navigationView
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - tableViewDataSource
/**
 tableView组数
 
 @param tableView tableView对象
 @return 组数
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        return 0;
    }
    return 194/3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 305/3;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        return [UIView new];
    }
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    self.edSectonHeaderView.cellSubtitleLabel.text = [NSString stringWithFormat:@"共%lu笔",(unsigned long)cingleTon.jieQianBiShu];
    return self.edSectonHeaderView;
}

#pragma mark - tableViewDelagate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:EDuTableViewCellIden];
    if (!cell) {
        cell = [[EDuTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:EDuTableViewCellIden];
    }
    
    [cell setCellDataWithDict:self.dataArray[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TiQianHuanKuanViewController * regVC = [[TiQianHuanKuanViewController alloc] init];
    [self.navigationController pushViewController:regVC animated:YES];
    
}

#pragma mark - 按钮点击事件

-(void)setBtnClicked:(UIButton *)btn{
    AlertYiJIeViewController * VC= [[AlertYiJIeViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)borrowBtnClicked:(UIButton *)btn{
    JieQianViewController * jqVC = [[JieQianViewController alloc] init];
    jqVC.title = @"微粒贷";
    [self.navigationController pushViewController:jqVC animated:YES];
}

-(void)whiteBGBtnClicked:(UIButton *)btn{
    TiQianHuanKuanViewController * regVC = [[TiQianHuanKuanViewController alloc] init];
    [self.navigationController pushViewController:regVC animated:YES];
}

-(void)closeBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)countBtnClicked:(UIButton *)btn{
    self.touchCount ++;
    if (self.touchCount == 3) {
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        cingleTon.isOnYuShe = !cingleTon.isOnYuShe;
//        cingleTon.keBorrowCount = cingleTon.yuSheKeJieEDu;
        if (cingleTon.isOnYuShe) {
            cingleTon.borrowCount += cingleTon.yuSheKeJieEDu;
        }
        else{
            cingleTon.borrowCount -= cingleTon.yuSheKeJieEDu;
        }
        
        [self setTAbleHeaderViewData];
        self.touchCount = 0;
    }
}

#pragma mark - 懒加载
-(EDuView *)borrowView{
    if (!_borrowView) {
        _borrowView = [[EDuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, eduBGViewH)];
        [_borrowView.borrowBtn addTarget:self action:@selector(borrowBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _borrowView;
}

-(EDuSectonHeaderView *)edSectonHeaderView{
    if (!_edSectonHeaderView) {
        _edSectonHeaderView = [[EDuSectonHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Width_Scall * 122)];
        [_edSectonHeaderView.whiteBGBtn addTarget:self action:@selector(whiteBGBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _edSectonHeaderView;
}

-(UITableView *)myTableView{
    if (!_myTableView) {
        if (@available(iOS 10.0, *)) {
            _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - StatusBarHeight) style:UITableViewStylePlain];
        }
        else{
            _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight + StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - StatusBarHeight) style:UITableViewStylePlain];
        }
        
//        _myTableView.backgroundColor = TableViewBGColor;
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        _myTableView.tableHeaderView = self.borrowView;
        [_myTableView registerClass:[EDuTableViewCell class] forCellReuseIdentifier:EDuTableViewCellIden];
    }
    return _myTableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

-(UILabel *)label3{
    if (!_label3) {
        _label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _label3.text = @"本服务由微众银行提供";
        _label3.textColor = ColorWithRGB(154, 155, 154, 1);
        _label3.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _label3.textAlignment = NSTextAlignmentCenter;
        _label3.numberOfLines = 1;
    }
    return _label3;
}

-(UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _label1.text = @"借钱须知";
        _label1.textColor = ColorWithRGB(22, 64, 127, 1);
        _label1.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _label1.textAlignment = NSTextAlignmentRight;
        _label1.numberOfLines = 1;
    }
    return _label1;
}


-(UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        _label2.text = @"常见问题";
        _label2.textColor = ColorWithRGB(22, 64, 127, 1);
        _label2.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _label2.textAlignment = NSTextAlignmentLeft;
        _label2.numberOfLines = 1;
    }
    return _label2;
}


-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, Width_Scall * 26)];
        _lineView.backgroundColor = ColorWithRGB(222, 220, 220, 1);
    }
    return _lineView;
}

-(UIButton *)countBtn{
    if (!_countBtn) {
        _countBtn = [FactryFucClass createButtonWithFrame:CGRectZero
                                       setBackgroundImage:nil
                                                addTarget:self
                                                   action:@selector(countBtnClicked:)
                                         forControlEvents:UIControlEventTouchUpInside];
    }
    return _countBtn;
}

@end
