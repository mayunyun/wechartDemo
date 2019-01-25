
//  EveryDayBenefit
//
//  Created by 邱 德政 on 16/8/10.
//  Copyright © 2016年 济南联祥技术有限公司. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeIconsCollectionView.h"
#import "MYYZhifuHeaderViewCell.h"
#import "HanTableViewCell.h"
#define cellW ((SCREEN_WIDTH - 2 - 45) / 3)
#define cellHeader 45
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic,strong)UITableView* tbView;
@property (nonatomic,strong)HomeIconsCollectionView* iconsCollView;
@property (nonatomic,strong)HomeIconsCollectionView* downCollView;
//@property (nonatomic,strong)MYYZhifuHeaderView* headerTbView;
@property (nonatomic,strong)NSMutableArray* getAllProductTypeArray;
@property (nonatomic,strong)NSMutableArray* getHotProductArray;
@property (nonatomic,strong)NSMutableArray* sectionTitleArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDataSource];
    [self creatUI];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)creatUI
{

    [self.view addSubview:self.tbView];
    
//    weakify(self);
//    [self.tbView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, SCREEN_HEIGHT - StatusBarHeight - NavigationBarHeight));
//        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
//        make.top.mas_equalTo(weakSelf.view.mas_top).with.offset(0);
//    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tbView) {
        return 3;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tbView) {
        if (indexPath.row == 1) {
            NSInteger hight = qianbaoCollectionCellH*[self array:self.getAllProductTypeArray rowNum:3]+cellHeader;
            return hight;
        }else if (indexPath.row == 2){
            NSInteger hight = qianbaoCollectionCellH*[self array:self.getHotProductArray rowNum:3]+cellHeader;
            return hight;
        }else if (indexPath.row == 0){
            return CollectionHeaderViewH;
        }
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义cell标识  每个cell对应一个自己的标识
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
////    // 通过不同标识创建cell实例
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    HanTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell)
    {
        cell = [[HanTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier cellForRowAtIndexPath:indexPath withTabel:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType  = UITableViewCellAccessoryNone;
    }
//    if (indexPath.row == 0)
//    {
//        cell.imageView.image = [UIImage imageNamed:@"白导航"];
//    }
    MYYZhifuHeaderViewCell* headerCell = [tableView cellForRowAtIndexPath:indexPath];
    if (!headerCell) {
        headerCell = [[MYYZhifuHeaderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        headerCell.accessoryType  = UITableViewCellAccessoryNone;
    }
    if (tableView == _tbView) {
        if (indexPath.row == 1||indexPath.row == 2) {
            if (indexPath.row == 1) {
                UIView* bgView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, cellHeader+[self array:self.getAllProductTypeArray rowNum:3]*qianbaoCollectionCellH)];
                bgView.backgroundColor = [UIColor whiteColor];
                UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, bgView.width - 40, 45)];
                label.text = @"腾讯服务";
                label.textColor = [UIColor blackColor];
                [bgView addSubview:label];
                [bgView addSubview:self.iconsCollView];
                if (_getAllProductTypeArray.count >= 0) {
                    self.iconsCollView.dataArr = _getAllProductTypeArray;
                    [self.iconsCollView reloadData];
                }
                cell.contentView.layer.cornerRadius =10;
                cell.layer.cornerRadius =10;
                cell.contentView.layer.masksToBounds =YES;
                [cell.contentView addSubview:bgView];
            }else if (indexPath.row == 2){
                
                UIView* bgView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 40, cellHeader+[self array:self.getHotProductArray rowNum:3]*qianbaoCollectionCellH)];
                bgView.backgroundColor = [UIColor redColor];
                UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, bgView.width - 40, 45)];
                label.text = @"腾讯服务";
                label.textColor = [UIColor blackColor];
                [bgView addSubview:label];
                [bgView addSubview:self.downCollView];
                if (_getHotProductArray.count >= 0) {
                    _downCollView.dataArr = _getHotProductArray;
                    [_downCollView reloadData];
                }
                cell.contentView.layer.cornerRadius =10;
                cell.layer.cornerRadius =10;
                cell.contentView.layer.masksToBounds =YES;
                [cell.contentView addSubview:bgView];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return headerCell;
        }

    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了%ld",(long)indexPath.row);
}

#pragma mark ---UIcollectionViewLayoutDelegate
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

////设置每个item水平间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 1;
//}
//
//
////设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 1;
//}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isKindOfClass:[HomeIconsCollectionView class]]){
        
    }
}

#pragma mark - 懒加载
-(UITableView *)tbView{
    if (!_tbView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - NavigationBarHeight );
        if (@available(iOS 10.0, *)) {
            
        }
        else{
            frame = CGRectMake(0, StatusBarHeight + NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - NavigationBarHeight);
        }
        _tbView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.showsVerticalScrollIndicator = NO;
        _tbView.scrollsToTop = YES;
        _tbView.scrollEnabled = YES;
        _tbView.backgroundColor = [UIColor clearColor];
        _tbView.estimatedRowHeight = 0;
        _tbView.estimatedSectionHeaderHeight = 0;
        _tbView.estimatedSectionFooterHeight = 0;
        [_tbView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        [self setupTableHeaderView];
        
    }
    return _tbView;
}

//- (void)setupTableHeaderView
//{
//    _tbView.tableHeaderView = self.headerTbView;
//    _tbView.tableHeaderView.height = CollectionHeaderViewH;
//    _tbView.tableHeaderView.backgroundColor = [UIColor redColor];
////    weakify(self);
////    [_headerTbView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.width.equalTo(weakSelf.tbView);
////    }];
////    [_tbView layoutIfNeeded];
////    _tbView.tableHeaderView = _headerTbView;
//}
//
//- (MYYZhifuHeaderView*)headerTbView{
//    if (!_headerTbView) {
//        _headerTbView = [[MYYZhifuHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CollectionHeaderViewH)];//51，197，94
//    }
//    return _headerTbView;
//}

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
- (HomeIconsCollectionView*)iconsCollView{
    if (!_iconsCollView) {
        _iconsCollView = [[HomeIconsCollectionView alloc]initWithFrame:CGRectMake(20, 45, SCREEN_WIDTH - 40, [self array:self.getAllProductTypeArray rowNum:3]*qianbaoCollectionCellH)];
        _iconsCollView.contentSize = CGSizeMake(SCREEN_WIDTH - 40, [self array:self.getAllProductTypeArray rowNum:3]*qianbaoCollectionCellH);
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
        _downCollView = [[HomeIconsCollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self array:self.getHotProductArray rowNum:3]*qianbaoCollectionCellH)];
        _downCollView.contentSize = CGSizeMake(SCREEN_WIDTH, [self array:self.getHotProductArray rowNum:3]*qianbaoCollectionCellH);
        _downCollView.delegate = self;
        _downCollView.bounces = NO;
        _downCollView.scrollsToTop = NO;
        _downCollView.scrollEnabled = NO;
        _downCollView.userInteractionEnabled = YES;
        _downCollView.backgroundColor = [UIColor clearColor];
    }
    return _downCollView;
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
                        @{@"cellImage":@"moBai",@"cellTitle":@"摩拜单车"},
                        @{@"cellImage":@"moGuJie",@"cellTitle":@"蘑菇街女装"},
                        //                                                  @{@"cellImage":@"58",@"cellTitle":@"58到家"},
                        @{@"cellImage":@"唯品会",@"cellTitle":@"唯品会"},
                        @{@"cellImage":@"转转二手",@"cellTitle":@"转转二手"}
                        
                        ];
    [self.getHotProductArray addObjectsFromArray:array1];
    [self resetMeney];
}

-(void)resetMeney{
    SingleTon * singleTon = [SingleTon sharedSingleTon];
    NSIndexPath* index = [NSIndexPath indexPathForRow:0 inSection:0];
    MYYZhifuHeaderViewCell* cell = [_tbView cellForRowAtIndexPath:index];
    cell.changeBtn.moneyLabel.text = [NSString stringWithFormat:@"%@%0.2f",RMBSign,singleTon.yuECount];
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

@end
