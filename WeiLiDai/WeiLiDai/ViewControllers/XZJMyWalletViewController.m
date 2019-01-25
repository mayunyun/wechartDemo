//
//  XZJMyWalletViewController.m
//  WeiLiDai
//
//  Created by j on 2017/12/18.
//  Copyright © 2017年 j. All rights reserved.
//

#import "XZJMyWalletViewController.h"
#import "XZJMyWalletCollectionViewCell.h"
#import "XZJCollectionHeaderView.h"
#import "XZJCollectionSectionHeaderView.h"
#import "WeiLiDaiEDuViewController.h"
#import "ShowAlertBGView.h"
#import "AddBankCardViewController.h"
#import "XZJBaseViewController.h"
#import "HomeViewController.h"
#import "MYYZhiFuViewController.h"
#define XZJMyWalletCollectionViewCellIden @"XZJMyWalletCollectionViewCell"
#define XZJCollectionSectionHeaderViewIden @"XZJCollectionSectionHeaderView"
#define cellW ((SCREEN_WIDTH - 2) / 3)


@interface XZJMyWalletViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ShowAlertBGViewDelegate>

@property (nonatomic, strong) UICollectionView * myCollectionView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSMutableArray * sectionTitleArray;

@property (nonatomic, strong) XZJCollectionHeaderView * collectionHeaderView;

@property (nonatomic, strong) ShowAlertBGView * alertBGView;

@end

@implementation XZJMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDataSource];
    [self createUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[FactryFucClass imageWithColor:CollectionHeaderViewBGColor] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
////    self.bgView.backgroundColor = CollectionHeaderViewBGColor;
//    UIStatusBarStyle barStyle = UIStatusBarStyleLightContent;
//    [UIApplication sharedApplication].statusBarStyle = barStyle;
//    [FactryFucClass setNavigationTintColorWithBlack:NO];
//    UINavigationBar  *bar = [UINavigationBar appearance];
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
//        bar.barStyle = UIBarStyleDefault;
//        NSDictionary *dict =@{NSForegroundColorAttributeName:[UIColor whiteColor]/*,
//                                                                       NSFontAttributeName:[UIFont systemFontOfSize:CELL_FONTSIZE]*/
//                              };
//        [bar setTitleTextAttributes:dict];
//        //设置主题
//        [bar setTintColor:[UIColor whiteColor]];
//    }
    
    self.title = @"支付";
    
    XZJBaseViewController * baseVC = [XZJBaseViewController sharedBaseViewController];
    [baseVC.btnsView hideView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIImage *bgImage = [[UIImage imageNamed:@"发现导航"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];//
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.title = @"返回";
}


-(void)createDataSource{
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
    [array addObject:@{@"cellImage":@"xinYongKa2",@"cellTitle":@"信用卡还款"}];
    if ([cingleTon.isShowWeiLiDai isEqualToString:@"是"]) {
        [array addObject:@{@"cellImage":@"weiLiDai",@"cellTitle":@"微粒贷借钱"}];
    }
    [array addObjectsFromArray:@[@{@"cellImage":@"chongZhi2",@"cellTitle":@"手机充值"},
                                 @{@"cellImage":@"liCaiTong",@"cellTitle":@"理财通"},
                                 @{@"cellImage":@"jiaoFei",@"cellTitle":@"生活缴费"},
                                 @{@"cellImage":@"QBiChongZhi",@"cellTitle":@"Q币充值"},
                                 @{@"cellImage":@"chengShi",@"cellTitle":@"城市服务"}]];
    if ([cingleTon.isShowGram isEqualToString:@"是"]) {
        [array addObject:@{@"cellImage":@"youxiweishangdian",@"cellTitle":@"游戏微商店"}];
    }
    [array addObject:@{@"cellImage":@"gongYi",@"cellTitle":@"腾讯公益"}];
    if ([cingleTon.isShowEnsure isEqualToString:@"是"]) {
        [array addObject:@{@"cellImage":@"baoxianfuwu",@"cellTitle":@"保险服务"}];
    }
    
    NSUInteger lineNum = 2;
    if (lineNum == 2) {
        [self.sectionTitleArray addObjectsFromArray:@[@"腾讯服务",@"第三方服务"]];
        [self.dataArray addObjectsFromArray:@[
                                              array,
                                              @[
                                                  @{@"cellImage":@"火车票机票",@"cellTitle":@"火车票机票"},
                                                  @{@"cellImage":@"diDi",@"cellTitle":@"滴滴出行"},
                                                  @{@"cellImage":@"jingDong",@"cellTitle":@"京东优选"},
                                                  @{@"cellImage":@"meiTuan",@"cellTitle":@"美团外卖"},
                                                  @{@"cellImage":@"maoyan",@"cellTitle":@"电影演出赛事"},
                                                  @{@"cellImage":@"chiHe",@"cellTitle":@"吃喝玩乐"},
                                                  @{@"cellImage":@"jiuDian2",@"cellTitle":@"酒店"},
                                                 @{@"cellImage":@"拼多多",@"cellTitle":@"拼多多"}, @{@"cellImage":@"moBai",@"cellTitle":@"摩拜单车"},
                                                  @{@"cellImage":@"蘑菇街女装",@"cellTitle":@"蘑菇街女装"},
//                                                  @{@"cellImage":@"58",@"cellTitle":@"58到家"},
                                                  @{@"cellImage":@"唯品会特卖",@"cellTitle":@"唯品会特卖"},
                                                  @{@"cellImage":@"转转二手",@"cellTitle":@"转转二手"}
                                                  
                                                  ]]];
    }
    else{
        [self.sectionTitleArray addObjectsFromArray:@[@"腾讯服务",@"限时推广",@"第三方服务"]];
        [self.dataArray addObjectsFromArray:@[
                                              array,
                                              @[
                                                  @{@"cellImage":@"moBai",@"cellTitle":@"摩拜单车"}
                                                  ],
                                              @[
                                                  @{@"cellImage":@"huoChePiao",@"cellTitle":@"火车票机票"},
                                                  @{@"cellImage":@"diDi",@"cellTitle":@"滴滴出行"},
                                                  @{@"cellImage":@"jingDong",@"cellTitle":@"京东优选"},
                                                  @{@"cellImage":@"meiTuan",@"cellTitle":@"美团外卖"},
                                                  @{@"cellImage":@"maoyan",@"cellTitle":@"电影演出赛事"},                                                  @{@"cellImage":@"chiHe",@"cellTitle":@"吃喝玩乐"},
                                                  @{@"cellImage":@"jiuDian2",@"cellTitle":@"酒店"},
                                                  @{@"cellImage":@"moGuJie",@"cellTitle":@"蘑菇街女装"},
                                                  @{@"cellImage":@"58",@"cellTitle":@"58到家"},
                                                  @{@"cellImage":@"weipinhui",@"cellTitle":@"唯品会"}]]];
    }
    
    [self resetMeney];
}

-(void)resetMeney{
    SingleTon * singleTon = [SingleTon sharedSingleTon];
    self.collectionHeaderView.changeBtn.moneyLabel.text = [NSString stringWithFormat:@"%@%0.2f",RMBSign,singleTon.yuECount];
}

-(void)createUI{
    if (@available(iOS 10.0, *)) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.view.backgroundColor = CollectionHeaderViewBGColor;
    UIView * bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight + StatusBarHeight)];
    bgView2.backgroundColor = CollectionHeaderViewBGColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"PayMenuIcon"]
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(setBtnClicked:)];
    
    [self.view addSubview:self.myCollectionView];
    [self.view addSubview:bgView2];
    [self.navigationController.view addSubview:self.alertBGView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlertBGView:(ShowAlertBGView *)showAlertBGView newYuE:(CGFloat)yuE newBorrowCount:(NSUInteger)borrowCount{
    [self resetMeney];
}

#pragma mark - 按钮点击事件
-(void)backBtnClicked{
    [self.alertBGView showView];
}

-(void)setBtnClicked:(UIButton *)btn{
    
}

-(void)cardsBtnClicked{
    AddBankCardViewController * addVC = [[AddBankCardViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XZJMyWalletCollectionViewCell *cell = (XZJMyWalletCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:XZJMyWalletCollectionViewCellIden forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[XZJMyWalletCollectionViewCell alloc] initWithFrame:CGRectZero];
//    }
    NSDictionary * dic = self.dataArray[indexPath.section][indexPath.row];
    [cell.headImageView setImage:[UIImage imageNamed:[dic objectForKey:@"cellImage"]]];
    cell.nameLabel.text = [dic objectForKey:@"cellTitle"];

    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellW, qianbaoCollectionCellH);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

//协议方法里面创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    XZJCollectionSectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:XZJCollectionSectionHeaderViewIden forIndexPath:indexPath];
    header.nameLabel.text = self.sectionTitleArray[indexPath.section];
    [collectionView sendSubviewToBack:header];
    return header;
    
}


// cell点击变色
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    XZJMyWalletCollectionViewCell *cell = (XZJMyWalletCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:ColorWithRGB(216, 217, 218, 1)];
}
// cell点击变色
- (void)collectionView:(UICollectionView *)collectionView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    XZJMyWalletCollectionViewCell *cell = (XZJMyWalletCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor whiteColor]];
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 1) {
        WeiLiDaiEDuViewController * eDuVC = [[WeiLiDaiEDuViewController alloc] init];
//        eDuVC.title = @"微粒贷";
        [self.navigationController pushViewController:eDuVC animated:YES];
    }
    else if(indexPath.section == 0 && indexPath.row == 2){
//        [self backBtnClicked];
        HomeViewController* vc = [[HomeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3 && indexPath.section == 0){
        MYYZhiFuViewController* vc = [[MYYZhiFuViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 懒加载
-(UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //设置headerView的尺寸大小
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, qianbaoCollectionSectionHeadH);
        //该方法也可以设置itemSize
//        layout.itemSize =CGSizeMake(cellW, qianbaoCollectionCellH);
        
        //2.初始化collectionView
        if (@available(iOS 10.0, *)) {
            _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        }
        else{
            _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight + StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT- (NavigationBarHeight + StatusBarHeight)) collectionViewLayout:layout];
        }
        
        
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        _myCollectionView.contentInset = UIEdgeInsetsMake(CollectionHeaderViewH, 0, 0, 0);
//        _myCollectionView.contentInset = UIEdgeInsetsMake(154, 0, 0, 0);
        
        //3.注册collectionViewCell
        [_myCollectionView registerClass:[XZJMyWalletCollectionViewCell class] forCellWithReuseIdentifier:XZJMyWalletCollectionViewCellIden];
//        [_myCollectionView registerClass:[XZJCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:XZJCollectionHeaderViewIden];
        [_myCollectionView registerClass:[XZJCollectionSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:XZJCollectionSectionHeaderViewIden];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.showsVerticalScrollIndicator = NO;
        _myCollectionView.showsVerticalScrollIndicator = YES;

        //添加头视图
        [_myCollectionView addSubview:self.collectionHeaderView];
    }
    return _myCollectionView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

-(NSMutableArray *)sectionTitleArray{
    if (!_sectionTitleArray) {
        _sectionTitleArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _sectionTitleArray;
}

-(XZJCollectionHeaderView *)collectionHeaderView{
    if (!_collectionHeaderView) {
        _collectionHeaderView = [[XZJCollectionHeaderView alloc] initWithFrame:CGRectMake(0, -CollectionHeaderViewH * 3, SCREEN_WIDTH, CollectionHeaderViewH * 3)];
        [_collectionHeaderView.cardsBtn addTarget:self action:@selector(cardsBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_collectionHeaderView.paymentBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionHeaderView;
}

-(ShowAlertBGView *)alertBGView{
    if (!_alertBGView) {
        _alertBGView = [[ShowAlertBGView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.alertBGView.delegate = self;
    }
    return _alertBGView;
}


@end
