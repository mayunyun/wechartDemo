//
//  EditBankCardViewController.m
//  WeiLiDai
//
//  Created by j on 2018/2/25.
//  Copyright © 2018年 j. All rights reserved.
//

#import "EditBankCardViewController.h"
//#import "BankCardModel.h"
#import "XZJEidtSingleLineTextFieldViewController.h"
#import "ActionSheetPicker.h"

#define AlertTextTableViewCellIden @"AlertTextTableViewCell"

@interface EditBankCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * myTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) BankCardModel * bankCardModel;

@property (nonatomic, assign) BOOL isEditCard;

@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, strong) UIView * footerView;

@end

@implementation EditBankCardViewController

-(instancetype)initIfEditCard:(BOOL)isEditCard listIndex:(NSUInteger)index{
    if (self = [super init]) {
        self.isEditCard = isEditCard;
        self.index = index;
        if (isEditCard) {
            SingleTon * cingleTon = [SingleTon sharedSingleTon];
            self.bankCardModel = cingleTon.bankCardModels[index];
            self.footerView.hidden = NO;
        }
        else{
            self.bankCardModel = [[BankCardModel alloc] init];
            self.footerView.hidden = YES;
        }
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDataSources];
    [self createUI];
    
}

-(void)createDataSources{
//    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    [self.dataArray removeAllObjects];
    //    cingleTon.bPhoneNum2;
    if (self.isEditCard) {
        [self.dataArray addObjectsFromArray:@[@{@"cellTitle":@"储蓄卡",@"cellSubtitle":self.bankCardModel.bBankName},
                                              @{@"cellTitle":@"银行卡尾号后4位",@"cellSubtitle":self.bankCardModel.bBankCardNum}]];
    }
    else{
        NSString * num = [NSString stringWithFormat:@"%04d",arc4random() % 9999];
        [self.dataArray addObjectsFromArray:@[@{@"cellTitle":@"储蓄卡",@"cellSubtitle":@"中国银行"},
                                              @{@"cellTitle":@"银行卡尾号后4位",@"cellSubtitle":num}]];
        self.bankCardModel.bBankSignIndex = 0;
        self.bankCardModel.bBankSignImageName = @"zhongguo";
        self.bankCardModel.bBankName = @"中国银行";
        self.bankCardModel.bBankCardNum = num;
    }
    
    [self.myTableView reloadData];
}

-(void)createUI{
    self.title = @"编辑银行卡";
    if (@available(iOS 10.0, *)) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if (!self.isEditCard) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                                                       style:UIBarButtonItemStyleDone
                                                                                                      target:self
                                                                                                      action:@selector(addBankCardAction)];
    }
    
    [self.view addSubview:self.myTableView];
    UIView * bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight + StatusBarHeight)];
    bgView2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bgView2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addBankCardAction{
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    NSMutableArray * cards = [NSMutableArray arrayWithCapacity:0];
    [cards addObjectsFromArray:cingleTon.bankCardModels];
    if (cards.count == maxCardNum) {
        [cards replaceObjectAtIndex:cards.count-1 withObject:self.bankCardModel];
    }
    else{
        [cards addObject:self.bankCardModel];
    }
    
    cingleTon.bankCardModels = cards;
    self.block(self.bankCardModel);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)editBtnCLicked{
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    NSMutableArray * cards = [NSMutableArray arrayWithCapacity:0];
    [cards addObjectsFromArray:cingleTon.bankCardModels];
    [cards replaceObjectAtIndex:self.index withObject:self.bankCardModel];
    cingleTon.bankCardModels = cards;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)deleteBtnCLicked{
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    NSMutableArray * cards = [NSMutableArray arrayWithCapacity:0];
    [cards addObjectsFromArray:cingleTon.bankCardModels];
    [cards removeObjectAtIndex:self.index];
    cingleTon.bankCardModels = cards;
    [self.navigationController popViewControllerAnimated:YES];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AlertTextTableViewCellIden];
        
    }
    
    NSDictionary * cellDic = self.dataArray[indexPath.row];
//    cell.imageView.layer.masksToBounds = YES;
//    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [cell.imageView setImage:[UIImage imageNamed:cellDic[]]];
    cell.textLabel.text = cellDic[@"cellTitle"];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
    cell.detailTextLabel.text = cellDic[@"cellSubtitle"];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    weakify(self);
    switch (indexPath.row) {
        case 0:{
            //选择银行
            NSMutableArray * names = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary * dic in bankCards) {
                [names addObject:dic[@"bankName"]];
            }
            [ActionSheetStringPicker showPickerWithTitle:@"选择银行"
                                                    rows:names
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   cell.detailTextLabel.text = selectedValue;
                                                   NSDictionary * dic = bankCards[selectedIndex];
                                                   weakSelf.bankCardModel.bBankName = dic[@"bankName"];
                                                   weakSelf.bankCardModel.bBankSignImageName = dic[@"imageName"];
                                                   weakSelf.bankCardModel.bBankSignIndex = selectedIndex;
                                               }
                                             cancelBlock:^(ActionSheetStringPicker *picker) {
                                                 
                                             }
                                                  origin:self.view];
        }
            break;
        case 1:{
            //填写卡号
            XZJEidtSingleLineTextFieldViewController * alertNameVC = [[XZJEidtSingleLineTextFieldViewController alloc] initWithText:cell.detailTextLabel.text];
            alertNameVC.title = @"填写卡号";
            alertNameVC.block = ^(NSString *text) {
                weakSelf.bankCardModel.bBankCardNum = text;
                cell.detailTextLabel.text = text;
            };
            [self.navigationController pushViewController:alertNameVC animated:YES];
        }
            break;
        default:
            break;
    }
    
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
        _myTableView.tableFooterView = self.footerView;
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

-(UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (Width_Scall * 17 + ToolBarHeight) * 2)];
        _footerView.backgroundColor = TableViewBGColor;
        UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        editBtn.layer.masksToBounds = YES;
        editBtn.layer.cornerRadius = Width_Scall * 8;
        editBtn.frame = CGRectMake(spaceMargin, Width_Scall * 17, SCREEN_WIDTH - spaceMargin * 2, ToolBarHeight);
        [editBtn setTitle:@"修改" forState:UIControlStateNormal];
        [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 3];
        editBtn.backgroundColor = [UIColor greenColor];
        [editBtn addTarget:self action:@selector(editBtnCLicked) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:editBtn];
        
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.layer.masksToBounds = YES;
        deleteBtn.layer.cornerRadius = Width_Scall * 8;
        deleteBtn.frame = CGRectMake(spaceMargin, Width_Scall * 17 + editBtn.frame.size.height + editBtn.frame.origin.y, SCREEN_WIDTH - spaceMargin * 2, ToolBarHeight);
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE + 3];
        deleteBtn.backgroundColor = [UIColor redColor];
        [deleteBtn addTarget:self action:@selector(deleteBtnCLicked) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:deleteBtn];
    }
    return _footerView;
}

@end
