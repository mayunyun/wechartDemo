//
//  MineViewController.m
//  WeiLiDai
//
//  Created by j on 2018/2/19.
//  Copyright © 2018年 j. All rights reserved.
//

#import "MineViewController.h"
#import "XZJDetailTypeCell.h"
#import "XZJMyWalletViewController.h"
#import "XZJMineHeadTableViewCell.h"
#import "AlertInfoViewController.h"
#import "MYYZhiFuViewController.h" 
#define detailTypeCellIden @"XZJDetailTypeCell"
#define XZJMineHeadTableViewCellIden @"XZJMineHeadTableViewCell"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    CGFloat _oldY;
}
@property (nonatomic, strong) UITableView * myTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) NSUInteger clickNum;
@property (nonatomic, strong) NSDate * lastClickDate;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.topItem.title = @"";
    UIImage *bgImage = [[UIImage imageNamed:@"白导航"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];//

    [self createDataSource];
    self.clickNum = 0;
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.translucent = YES;
    UIImage *bgImage = [[UIImage imageNamed:@"发现导航"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];//
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)createDataSource{
    [self.dataArray removeAllObjects];
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    [self.dataArray addObjectsFromArray:@[@[@{@"headImage":cingleTon.userHeadImageName,@"cellTitle":cingleTon.userNick,@"cellSubtitle":cingleTon.userNum,@"ifHaveRightArrow":@"0"}],
                                          @[@{@"headImage":@"支付",@"cellTitle":@"支付",@"cellSubtitle":@"",@"ifHaveRightArrow":@"0"}],
                                          @[
                                              @{@"headImage":@"收藏",@"cellTitle":@"收藏",@"cellSubtitle":@"",@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"相册",@"cellTitle":@"相册",@"cellSubtitle":@"",@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"卡包",@"cellTitle":@"卡包",@"cellSubtitle":@"",@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"表情",@"cellTitle":@"表情",@"cellSubtitle":@"",@"ifHaveRightArrow":@"1"}],
                                          @[
                                              @{@"headImage":@"我设置",@"cellTitle":@"设置",@"cellSubtitle":@"",@"ifHaveRightArrow":@"1"}]]];
    
    [self.myTableView reloadData];
}


-(void)createUI{
    
    if (@available(iOS 10.0, *)) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    //    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.myTableView];
//    NSLog(@"SCREEN_WIDTH:%f,SCREEN_HEIGHT:%f,Width_Scall:%f,normalCellH:%f",SCREEN_WIDTH,SCREEN_HEIGHT,Width_Scall,normalCellH);
    UIView * bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, -NavigationBarHeight - StatusBarHeight, SCREEN_WIDTH, NavigationBarHeight + StatusBarHeight)];
    bgView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView2];

    UIButton* rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBarBtn.frame = CGRectMake(0, 0, 30, 30);
    [rightBarBtn setImage:[UIImage imageNamed:@"摄像头2"] forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(cameraClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* right = [[UIBarButtonItem alloc]initWithCustomView:rightBarBtn];
    self.navigationItem.rightBarButtonItem = right;
    [self hideBGView];
}

#pragma mark - tableViewDataSource
/**
 tableView组数
 
 @param tableView tableView对象
 @return 组数
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return normalSectionHeadH;
    return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return normalSectionFootH*2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return Width_Scall * 254;
    }
    return normalCellH;
}

#pragma mark - tableViewDelagate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        XZJMineHeadTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:XZJMineHeadTableViewCellIden forIndexPath:indexPath];
        if (!cell) {
            cell = [[XZJMineHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:XZJMineHeadTableViewCellIden];
            
        }
        
        NSDictionary * cellData = self.dataArray[indexPath.section][indexPath.row];
//        [cell setCellData:cellData];
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        if (cingleTon.userHeadImage != nil) {
            [cell.headIconView setImage:cingleTon.userHeadImage];
        }
        else{
            [cell.headIconView setImage:[UIImage imageNamed:cellData[@"headImage"]]];
        }
        cell.cellTitleLabel.text = cellData[@"cellTitle"];
        cell.cellSubtitleLabel.text = [NSString stringWithFormat:@"微信号：%@",cellData[@"cellSubtitle"]];
        
        return cell;
    }
    else{
        XZJDetailTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:detailTypeCellIden forIndexPath:indexPath];
        if (!cell) {
            cell = [[XZJDetailTypeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:detailTypeCellIden];
            
        }
        
        NSDictionary * cellData = self.dataArray[indexPath.section][indexPath.row];
        [cell setCellData:cellData];
        return cell;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        AlertInfoViewController * mwVC = [[AlertInfoViewController alloc] init];
        mwVC.hidesBottomBarWhenPushed = YES;
        weakify(self);
        mwVC.block = ^(NSString *headImageName, NSString *userNick, NSString *userNum) {
            [weakSelf createDataSource];
        };
        [self.navigationController pushViewController:mwVC animated:YES];
    }
    if (indexPath.section == 1) {
//        XZJMyWalletViewController * mwVC = [[XZJMyWalletViewController alloc] init];
//        mwVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:mwVC animated:YES];
        
        MYYZhiFuViewController* vc = [[MYYZhiFuViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)footerViewAction{
    NSDate * nowDate = [NSDate date];
    if (self.lastClickDate) {
        NSTimeInterval lastTimeInt = [self.lastClickDate timeIntervalSince1970];
        NSTimeInterval nowTimeInt = [nowDate timeIntervalSince1970];
        NSTimeInterval timeInt = nowTimeInt - lastTimeInt;
//        NSLog(@"%f %f %f %ld",lastTimeInt,nowTimeInt,timeInt,self.clickNum);
        self.lastClickDate = nowDate;
        if (timeInt <= 1) {
            self.clickNum ++;
        }
        else{
            self.clickNum = 1;
        }
        if (self.clickNum == 3) {
            SingleTon * cingleTon = [SingleTon sharedSingleTon];
            if ([cingleTon.isShowWeiLiDai isEqualToString:@"是"]) {
                cingleTon.isShowWeiLiDai = @"否";
            }
            else{
                cingleTon.isShowWeiLiDai = @"是";
            }
            self.clickNum = 0;
        }
        
    }
    else{
        self.lastClickDate = nowDate;
        self.clickNum ++;
    }
    
}

#pragma mark - 懒加载
-(UITableView *)myTableView{
    if (!_myTableView) {
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - NavigationBarHeight - TabBarHeight );
        if (@available(iOS 10.0, *)) {
        }
        else{
            frame = CGRectMake(0, StatusBarHeight + NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - NavigationBarHeight - TabBarHeight );
        }
        _myTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.backgroundColor = [UIColor clearColor];
        [_myTableView registerClass:[XZJDetailTypeCell class] forCellReuseIdentifier:detailTypeCellIden];
        [_myTableView registerClass:[XZJMineHeadTableViewCell class] forCellReuseIdentifier:XZJMineHeadTableViewCellIden];
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        [_myTableView  setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        //        if (IS_IPHONE_X) {
        UIButton * footerView = [UIButton buttonWithType:UIButtonTypeCustom];
        footerView.backgroundColor = [UIColor clearColor];
        footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 124);
        [footerView addTarget:self action:@selector(footerViewAction) forControlEvents:UIControlEventTouchUpInside];
        _myTableView.tableFooterView = footerView;
        //        }
        
        UIView* line = [[UIView alloc]initWithFrame:CGRectMake(0, -1, self.myTableView.width, 2)];
        line.backgroundColor = [UIColor whiteColor];
        [self.myTableView addSubview:line];
        
    }
    return _myTableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
#pragma mark -点击事件
- (void)cameraClick:(UIButton*)sender{
    
}

-(void)viewDidLayoutSubviews
{
    
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.myTableView setSeparatorInset:UIEdgeInsetsMake(0,40,0,0)];
        
    }
    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.myTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        
    }
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0,40,0,0)];//UIEdgeInsetsZero
        
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{ if ([scrollView isEqual: self.myTableView]) {
//    if (self.myTableView.contentOffset.y > _oldY) {
//    // 上滑
//        [self.navigationController.navigationBar setHidden:NO];
//        self.navigationController.navigationBar.translucent = NO;
//        self.navigationController.navigationBar.topItem.title = @"";
//        UIImage *bgImage = [[UIImage imageNamed:@"白导航"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
//        [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];//
//    } else{ // 下滑
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//    } }}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    // 获取开始拖拽时tableview偏移量
//    _oldY = self.myTableView.contentOffset.y;
//
//}

@end
