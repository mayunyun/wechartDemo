//
//  MYYZhiFuViewController.m
//  WeiLiDai
//
//  Created by LONG on 2019/1/4.
//  Copyright © 2019年 j. All rights reserved.
//

#import "MYYZhiFuViewController.h"
#import "HomeIconsCollectionView.h"
#import "ShowAlertBGView.h"
#import "CollectionHeaderBtn.h"
#import "WeiLiDaiEDuViewController.h"
#define leftgap 10
#define cellHeader 50
#define cellWh ((SCREEN_WIDTH - 3 - leftgap*2) / 3)
#define navcolor ColorWithRGB(247, 247, 247, 1)
@interface MYYZhiFuViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ShowAlertBGViewDelegate>
@property (nonatomic,strong)UIScrollView* mySView;
@property (nonatomic,strong)UIView* firstView;
@property (nonatomic,strong)UIView* secondView;
@property (nonatomic,strong)UIView* thridView;
@property (nonatomic,strong)NSMutableArray* getAllProductTypeArray;
@property (nonatomic,strong)NSMutableArray* getHotProductArray;
@property (nonatomic,strong)NSMutableArray* sectionTitleArray;
@property (nonatomic,strong)HomeIconsCollectionView* iconsCollView;
@property (nonatomic,strong)HomeIconsCollectionView* downCollView;
@property (nonatomic, strong) ShowAlertBGView * alertBGView;
@end

@implementation MYYZhiFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    UIImage* image = [FactryFucClass imageWithColor:navcolor];
    UIImage *bgImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];//
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    [self hideBGView];
    self.title = @"支付";
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    UIImage *bgImage = [[UIImage imageNamed:@"发现导航"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];//
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

- (void)creatUI{
    self.view.backgroundColor = navcolor;
    [self showBack];
    [self createDataSource];
    [self.view addSubview:self.mySView];
    [self.mySView addSubview:self.firstView];
    [self firstViewUI];
    [self.mySView addSubview:self.secondView];
    [self secondViewUI];
    [self.mySView addSubview:self.thridView];
    [self thridViewUI];
    [self.navigationController.view addSubview:self.alertBGView];
}

- (void)firstViewUI{
    NSArray*titleArr = @[@"收付款",@"钱包"];
    NSArray* imgArr = @[@"收付款",@"钱包"];
//    NSArray* imgArr = @[@"shouFuKuan",@"lingQian"];
//    CGFloat imgW = 30;
//    CGFloat imgH = 30;
    CGFloat cellW = _firstView.width/2;
    for (int i = 0; i < titleArr.count; i++) {
        
        CollectionHeaderBtn* btn = [[CollectionHeaderBtn alloc]initWithFrame:CGRectMake(0+cellW*i, 0, cellW, CollectionHeaderViewH)];
        btn.tag = 200+i;
        btn.nameLabel.text = titleArr[i];
        [btn.headImageView setImage:[UIImage imageNamed:imgArr[i]]];
        btn.moneyLabel.hidden = YES;
        if (btn.tag == 201) {
            btn.moneyLabel.hidden = NO;
        }
        SingleTon * singleTon = [SingleTon sharedSingleTon];
        btn.moneyLabel.text = [NSString stringWithFormat:@"%@%0.2f",RMBSign,singleTon.yuECount];
        [btn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_firstView addSubview:btn];
//        UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake((_firstView.width - imgW*2)/4 +cellW*i, 30, imgW, imgH)];
//        imageView.image = [UIImage imageNamed:imgArr[i]];
//        [_firstView addSubview:imageView];
//        UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(0+cellW*i, imageView.bottom+30, cellW, 30)];
//        title.text = titleArr[i];
//        title.textAlignment = NSTextAlignmentCenter;
//        [_firstView addSubview:title];
//        title.textColor = [UIColor whiteColor];
//
//        UILabel* moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0+cellW*i, title.bottom, title.width, 30)];
//        moneyLabel.text = [NSString stringWithFormat:@"%@00.00",RMBSign];
//        moneyLabel.textColor = ColorWithRGB(180, 183, 188, 1);
//        moneyLabel.font = [UIFont fontWithName:@"WeChat Sans Std" size:DEFAULT_FONTSIZE - 1];
//        moneyLabel.textAlignment = NSTextAlignmentCenter;
//        moneyLabel.numberOfLines = 1;
//        moneyLabel.hidden = YES;
//        moneyLabel.tag = 100+i;
//        if (moneyLabel.tag == 101) {
//            moneyLabel.hidden = NO;
//        }
//        [_firstView addSubview:moneyLabel];
    }
}

- (void)secondViewUI{
    UIView* bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.secondView.width, cellHeader+[self array:self.getAllProductTypeArray rowNum:3]*qianbaoCollectionCellH)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, bgView.width - 40, 45)];
    label.text = @"腾讯服务";
    label.textColor = grayMineTitleColor;
    label.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
    [bgView addSubview:label];
    [bgView addSubview:self.iconsCollView];
    UIView* line = [[UIView alloc]initWithFrame:CGRectMake(0, label.bottom - 1, bgView.width, 1)];
    line.backgroundColor = TableViewBGColor;
    [bgView addSubview:line];
    if (self.getAllProductTypeArray.count >= 0) {
        self.iconsCollView.dataArr = self.getAllProductTypeArray;
        [self.iconsCollView reloadData];
    }
    bgView.layer.cornerRadius =10;
    bgView.layer.masksToBounds =YES;
    [self.secondView addSubview:bgView];
}
- (void)thridViewUI{
    UIView* bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.thridView.width, cellHeader+[self array:self.getHotProductArray rowNum:3]*qianbaoCollectionCellH)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, bgView.width - 40, 45)];
    label.text = @"第三方服务";
    label.textColor = grayMineTitleColor;
    label.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
    [bgView addSubview:label];
    UIView* line = [[UIView alloc]initWithFrame:CGRectMake(0, label.bottom - 1, bgView.width, 1)];
    line.backgroundColor = TableViewBGColor;
    [bgView addSubview:line];
    [bgView addSubview:self.downCollView];
    if (self.getHotProductArray.count >= 0) {
        self.downCollView.dataArr = self.getHotProductArray;
        [self.downCollView reloadData];
    }
    bgView.layer.cornerRadius =10;
    bgView.layer.masksToBounds =YES;
    [self.thridView addSubview:bgView];
}
- (NSInteger)array:(NSArray*)array rowNum:(NSInteger)index
{
    if (array.count == 0||array == nil || index == (NSInteger)nil ) {
        return 0;
    }else{
        if (array.count%index!=0) {
            return array.count/index+1;
        }else{
            return array.count/index;
        }
        
    }
}
- (UIScrollView*)mySView{
    if (!_mySView) {
        //2.初始化collectionView
        if (@available(iOS 10.0, *)) {
            _mySView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (NavigationBarHeight + StatusBarHeight))];
        }
        else{
            _mySView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight + StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT- (NavigationBarHeight + StatusBarHeight))];
        }
        _mySView.contentSize = CGSizeMake(SCREEN_WIDTH, CollectionHeaderViewH+cellHeader+[self array:self.getAllProductTypeArray rowNum:3]*qianbaoCollectionCellH+cellHeader+[self array:self.getHotProductArray rowNum:3]*qianbaoCollectionCellH+leftgap*4);
        _mySView.showsVerticalScrollIndicator = YES;
        _mySView.showsHorizontalScrollIndicator = NO;
        _mySView.scrollEnabled = YES;
    }
    return _mySView;
}

- (UIView*)firstView{
    if (!_firstView) {
        _firstView = [[UIView alloc]initWithFrame:CGRectMake(leftgap, leftgap, SCREEN_WIDTH - leftgap*2, CollectionHeaderViewH)];
        _firstView.backgroundColor = ColorWithRGB(60,179, 113, 1);
        _firstView.layer.masksToBounds = YES;
        _firstView.layer.cornerRadius = 10;
    }
    return _firstView;
}


- (UIView*)secondView{
    if (!_secondView) {
        _secondView = [[UIView alloc]initWithFrame:CGRectMake(leftgap, self.firstView.bottom+leftgap, SCREEN_WIDTH - leftgap*2, cellHeader+[self array:self.getAllProductTypeArray rowNum:3]*qianbaoCollectionCellH)];
        _secondView.backgroundColor = [UIColor whiteColor];
        _secondView.layer.masksToBounds = YES;
        _secondView.layer.cornerRadius = 10;
    }
    return _secondView;
}
- (UIView*)thridView{
    if (!_thridView) {
        _thridView = [[UIView alloc]initWithFrame:CGRectMake(leftgap, self.secondView.bottom+leftgap, SCREEN_WIDTH - leftgap*2, cellHeader+[self array:self.getHotProductArray rowNum:3]*qianbaoCollectionCellH)];
        _thridView.backgroundColor = [UIColor whiteColor];
        _thridView.layer.masksToBounds = YES;
        _thridView.layer.cornerRadius = 10;
    }
    return _thridView;
}


-(NSMutableArray *)sectionTitleArray{
    if (!_sectionTitleArray) {
        _sectionTitleArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _sectionTitleArray;
}
- (NSMutableArray*)getHotProductArray{
    if (!_getHotProductArray) {
        _getHotProductArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _getHotProductArray;
}
- (NSMutableArray*)getAllProductTypeArray{
    if (!_getAllProductTypeArray) {
        _getAllProductTypeArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _getAllProductTypeArray;
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
    [self.getAllProductTypeArray addObjectsFromArray:array];
    [self.sectionTitleArray addObjectsFromArray:@[@"腾讯服务",@"第三方服务"]];
    NSArray* array1 = @[
                        @{@"cellImage":@"火车票机票",@"cellTitle":@"火车票机票"},
                        @{@"cellImage":@"diDi",@"cellTitle":@"滴滴出行"},
                        @{@"cellImage":@"jingDong",@"cellTitle":@"京东优选"},
                        @{@"cellImage":@"meiTuan",@"cellTitle":@"美团外卖"},
                        @{@"cellImage":@"maoyan",@"cellTitle":@"电影演出赛事"},
                        @{@"cellImage":@"chiHe",@"cellTitle":@"吃喝玩乐"},
                        @{@"cellImage":@"jiuDian2",@"cellTitle":@"酒店"},
                        @{@"cellImage":@"拼多多",@"cellTitle":@"拼多多"},
                        @{@"cellImage":@"moBai",@"cellTitle":@"摩拜单车"},
                        @{@"cellImage":@"蘑菇街女装",@"cellTitle":@"蘑菇街女装"},
                        //                                                  @{@"cellImage":@"58",@"cellTitle":@"58到家"},
                        @{@"cellImage":@"唯品会特卖",@"cellTitle":@"唯品会特卖"},
                        @{@"cellImage":@"转转二手",@"cellTitle":@"转转二手"}
                        
                        ];
    [self.getHotProductArray addObjectsFromArray:array1];
    [self resetMeney];
}

-(void)resetMeney{
    SingleTon * singleTon = [SingleTon sharedSingleTon];
    CollectionHeaderBtn* btn = (CollectionHeaderBtn*)[self.view viewWithTag:201];
    btn.moneyLabel.text = [NSString stringWithFormat:@"%@%0.2f",RMBSign,singleTon.yuECount];
}

- (HomeIconsCollectionView*)iconsCollView{
    if (!_iconsCollView) {
        _iconsCollView = [[HomeIconsCollectionView alloc]initWithFrame:CGRectMake(0, 45,self.secondView.width, [self array:self.getAllProductTypeArray rowNum:3]*qianbaoCollectionCellH)];
        _iconsCollView.contentSize = CGSizeMake(self.secondView.width, [self array:self.getAllProductTypeArray rowNum:3]*qianbaoCollectionCellH);
        _iconsCollView.delegate = self;
        _iconsCollView.bounces = NO;
        _iconsCollView.scrollsToTop = NO;
        _iconsCollView.scrollEnabled = NO;
        _iconsCollView.userInteractionEnabled = YES;
        _iconsCollView.backgroundColor = [UIColor clearColor];
        
    }
    return _iconsCollView;
}

- (HomeIconsCollectionView*)downCollView{
    if (!_downCollView) {
        _downCollView = [[HomeIconsCollectionView alloc]initWithFrame:CGRectMake(0, cellHeader, self.thridView.width, [self array:self.getHotProductArray rowNum:3]*qianbaoCollectionCellH)];
        _downCollView.contentSize = CGSizeMake(self.thridView.width, [self array:self.getHotProductArray rowNum:3]*qianbaoCollectionCellH);
        _downCollView.delegate = self;
        _downCollView.bounces = NO;
        _downCollView.scrollsToTop = NO;
        _downCollView.scrollEnabled = NO;
        _downCollView.userInteractionEnabled = YES;
        _downCollView.backgroundColor = [UIColor clearColor];
    }
    return _downCollView;
}

#pragma mark ---UIcollectionViewLayoutDelegate
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellWh, qianbaoCollectionCellH);
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


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView  == _iconsCollView){
        if (indexPath.section == 0 && indexPath.row == 1) {
            WeiLiDaiEDuViewController * eDuVC = [[WeiLiDaiEDuViewController alloc] init];
            //        eDuVC.title = @"微粒贷";
            [self.navigationController pushViewController:eDuVC animated:YES];
        }
    }
}
#pragma mark - collectionViewCell点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = ColorWithRGB(217, 217, 217, 1);
    
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

-(void)showAlertBGView:(ShowAlertBGView *)showAlertBGView newYuE:(CGFloat)yuE newBorrowCount:(NSUInteger)borrowCount{
    [self resetMeney];
}
#pragma mark - 按钮点击事件
- (void)backBtnClicked:(UIButton*)sender{
    if (sender.tag == 200) {
        [self.alertBGView showView];
    }
}
-(ShowAlertBGView *)alertBGView{
    if (!_alertBGView) {
        _alertBGView = [[ShowAlertBGView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.alertBGView.delegate = self;
    }
    return _alertBGView;
}


@end
