//
//  ChoseBankCardViewController.m
//  WeiLiDai
//
//  Created by 王宗正 on 2018/7/2.
//  Copyright © 2018年 j. All rights reserved.
//

#import "ChoseBankCardViewController.h"

#import "EditBankCardViewController.h"

#define AlertTextTableViewCellIden @"AlertTextTableViewCell"

@interface ChoseBankCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * myTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation ChoseBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
}

-(void)createDataSources{
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    [self.dataArray removeAllObjects];
    //    cingleTon.bPhoneNum2;
    [self.dataArray addObjectsFromArray:cingleTon.bankCardModels];
    [self.myTableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createDataSources];
    if (self.dataArray.count < maxCardNum) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                                  style:UIBarButtonItemStyleDone
                                                                                 target:self
                                                                                 action:@selector(addBankCardAction)];
    }
    else{
        self.navigationItem.rightBarButtonItem = nil;
    }
}

-(void)createUI{
    self.title = @"添加银行卡";
    if (@available(iOS 10.0, *)) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.myTableView];
    UIView * bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight + StatusBarHeight)];
    bgView2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bgView2];
}

-(void)addBankCardAction{
    EditBankCardViewController * edit = [[EditBankCardViewController alloc] initIfEditCard:NO listIndex:0];
    weakify(self);
    edit.block = ^(BankCardModel *cardModel) {
        [weakSelf createDataSources];
    };
    [self.navigationController pushViewController:edit animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }else{
        return normalSectionHeadH;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return normalSectionFootH;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return normalCellH;
}

#pragma mark - tableViewDelagate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AlertTextTableViewCellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AlertTextTableViewCellIden];
        
    }
    
    BankCardModel * cellDic = self.dataArray[indexPath.row];
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.imageView setImage:[UIImage imageNamed:cellDic.bBankSignImageName]];
    cell.textLabel.text = cellDic.bBankName;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
    cell.detailTextLabel.text = cellDic.bBankCardNum;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.block(self.dataArray[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 懒加载
-(UITableView *)myTableView{
    if (!_myTableView) {
        if (@available(iOS 10.0, *)) {
            _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - StatusBarHeight ) style:UITableViewStyleGrouped];
        }
        else{
            _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight + StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarHeight - StatusBarHeight ) style:UITableViewStyleGrouped];
        }
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        //        _myTableView.backgroundColor = TableViewBGColor;
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        //        if (IS_IPHONE_X) {
        //            UIView * footerView = [XZJFactoryFunc createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, iPhoneXSaftAreaH)
        //                                                      backgroundColor:[UIColor clearColor]];
        //            _myTableView.tableFooterView = footerView;
        //        }
    }
    return _myTableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}


@end
