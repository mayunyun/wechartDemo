//
//  AlertYiJIeViewController.m
//  WeiLiDai
//
//  Created by iMac on 2018/4/21.
//  Copyright © 2018年 j. All rights reserved.
//

#import "AlertYiJIeViewController.h"
#import "XZJActionShitPicker.h"
#import "XZJEidtSingleLineTextFieldViewController.h"
#import "ActionSheetPicker.h"
//#import "EditBankCardViewController.h"
#import "ChoseBankCardViewController.h"

#define AlertTextTableViewCellIden @"AlertTextTableViewCell"

@interface AlertYiJIeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * myTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, assign) NSUInteger selectQiXianIndex;

@property (nonatomic, copy) NSString * bBorrowCount;
@property (nonatomic, copy) NSString * bFrondTime;
@property (nonatomic, copy) NSString * bEndTime;
@property (nonatomic, copy) NSString * bReturnCountMounthly;
@property (nonatomic, copy) NSString * bQiXian;
@property (nonatomic, copy) NSString * bFirstBackMoneyDate;
@property (nonatomic, strong) BankCardModel * cardModel;


@end

@implementation AlertYiJIeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack];
    [self createDataSources];
    [self createUI];
    
}

-(void)createDataSources{
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    
    //    cingleTon.haveUnreadFriendPoint;
    NSDate * nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    self.bFrondTime = [formatter stringFromDate:nowDate];
    //结束日期
    NSTimeInterval timeInter = 10 * 30 * 24 * 60 * 60;
    NSDate * timeData = [NSDate dateWithTimeInterval:timeInter sinceDate:nowDate];
    [formatter setDateFormat:@"yyyy/MM"];
    self.bEndTime = [NSString stringWithFormat:@"%@/%@",[formatter stringFromDate:timeData],[AlertYiJIeViewController getCurrentDayWithDate:nowDate]];
    self.bFirstBackMoneyDate = cingleTon.bFirstBackMoneyDate?cingleTon.bFirstBackMoneyDate:[NSString stringWithFormat:@"%@月%@日",[AlertYiJIeViewController getNextMonthWithDate:nowDate],[AlertYiJIeViewController getCurrentDayWithDate:nowDate]];
    self.bBorrowCount = cingleTon.bBorrowCount;
    self.selectQiXianIndex = 1;
    NSString * returnCountMounthly = [AlertYiJIeViewController getMounthPayWithBorrowCount:[self.bBorrowCount floatValue]
                                                                                 dailyRate:cingleTon.riLiLv/100//0.0005
                                                                           borrowMounthNum:10];
    returnCountMounthly = [returnCountMounthly stringByReplacingOccurrencesOfString:@"¥" withString:@""];
    self.bReturnCountMounthly = returnCountMounthly;
    if (cingleTon.bBankName) {
        BankCardModel * model = [[BankCardModel alloc] init];
        model.bBankName = cingleTon.bBankName;
        model.bBankCardNum = cingleTon.bBankCardNum;
        model.bBankSignIndex = cingleTon.bBankSignIndex;
        self.cardModel =model;
    }
    self.bQiXian = cingleTon.bQiXian?cingleTon.bQiXian:@"10";
    [self refreshData];
}

-(void)refreshData{
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:@[
                                          @{@"headImage":@"MyCar",@"cellTitle":@"借款金额",@"cellSubtitle":self.bBorrowCount,@"ifHaveRightArrow":@"0"},
                                          @{@"headImage":@"",@"cellTitle":@"借款期限",@"cellSubtitle":cingleTon.bQiXian?cingleTon.bQiXian:@"10个月",@"ifHaveRightArrow":@"1"},
                                          @{@"headImage":@"MoreMyAlbum",@"cellTitle":@"借款日期",@"cellSubtitle":cingleTon.bFrondTime?cingleTon.bFrondTime:self.bFrondTime,@"ifHaveRightArrow":@"1"},
                                          @{@"headImage":@"setting_myQR",@"cellTitle":@"选择还款银行卡",@"cellSubtitle":self.cardModel?[NSString stringWithFormat:@"%@(%@)",self.cardModel.bBankName,self.cardModel.bBankCardNum]:@"",@"ifHaveRightArrow":@"1"},
                                          @{@"headImage":@"MoreMyAlbum",@"cellTitle":@"首月还款金额",@"cellSubtitle":self.bReturnCountMounthly,@"ifHaveRightArrow":@"1"},
                                          @{@"headImage":@"MoreMyAlbum",@"cellTitle":@"借钱笔数",@"cellSubtitle":[NSString stringWithFormat:@"%lu",(unsigned long)cingleTon.jieQianBiShu]
                                            ,@"ifHaveRightArrow":@"1"},
                                          @{@"headImage":@"MoreMyAlbum",@"cellTitle":@"首次还款日期",@"cellSubtitle":self.bFirstBackMoneyDate
                                            ,@"ifHaveRightArrow":@"1"}
                                          ]];
    [self.myTableView reloadData];
}

-(void)createUI{
    if (@available(iOS 10.0, *)) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.myTableView];
    self.selectQiXianIndex = 1;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(saveBtnClcked)];
//    UIView * bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight + StatusBarHeight)];
//    bgView2.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:bgView2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveBtnClcked{
    if ([self.bBorrowCount integerValue] < 500) {
        [FactryFucClass createModeTextProgressHUDInParentView:self.view andLabelText:@"借钱总金额不能低于500元" delayTime:0.8];
        return;
    }
    if (!self.cardModel) {
        [FactryFucClass createModeTextProgressHUDInParentView:self.view andLabelText:@"请选择银行卡" delayTime:0.8];
        return;
    }
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
//    NSString * returnCountMounthly = [AlertYiJIeViewController getMounthPayWithBorrowCount:[self.bBorrowCount floatValue]
//                                                                                 dailyRate:cingleTon.riLiLv/100//0.0005
//                                                                           borrowMounthNum:[self.bQiXian integerValue]];
//    returnCountMounthly = [returnCountMounthly stringByReplacingOccurrencesOfString:@"¥" withString:@""];
//    self.bReturnCountMounthly = returnCountMounthly;
    
    cingleTon.bBorrowCount = self.bBorrowCount;
    cingleTon.bQiXian = self.bQiXian;
    cingleTon.bFrondTime = self.bFrondTime;
    cingleTon.bEndTime = self.bEndTime;
    cingleTon.bBankName = self.cardModel.bBankName;
    cingleTon.bBankCardNum = self.cardModel.bBankCardNum;
    cingleTon.bReturnCountMounthly = self.bReturnCountMounthly;
    cingleTon.bFirstBackMoneyDate = self.bFirstBackMoneyDate;
    cingleTon.bIdCard2 = @"9999";
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
    cell.textLabel.text = cellDic[@"cellTitle"];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
    cell.detailTextLabel.text = cellDic[@"cellSubtitle"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:{
            //借款金额
            XZJEidtSingleLineTextFieldViewController * editVC = [[XZJEidtSingleLineTextFieldViewController alloc] initWithText:self.bBorrowCount];
            [self.navigationController pushViewController:editVC animated:YES];
            weakify(self);
            editVC.block = ^(NSString *text) {
                weakSelf.bBorrowCount = text;
//                cell.detailTextLabel.text = text;
                NSString * returnCountMounthly = [AlertYiJIeViewController getMounthPayWithBorrowCount:[self.bBorrowCount floatValue]
                                                                                             dailyRate:cingleTon.riLiLv/100//0.0005
                                                                                       borrowMounthNum:10];
                returnCountMounthly = [returnCountMounthly stringByReplacingOccurrencesOfString:@"¥" withString:@""];
                self.bReturnCountMounthly = returnCountMounthly;
                [weakSelf refreshData];
            };
        }
            break;
        case 1:{
            //借款期限
            NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell * jineCell = [tableView cellForRowAtIndexPath:indexPath1];
            if (jineCell.detailTextLabel.text.length > 0 && [jineCell.detailTextLabel.text integerValue] >= 500) {
                [self choseQiXianWithCell:cell];
            }
            else{
                //提示输入借钱金额

            }
        }
            break;
        case 2:{
            //借款日期
            NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell * jineCell = [tableView cellForRowAtIndexPath:indexPath1];
            if (jineCell.detailTextLabel.text.length > 0 && [jineCell.detailTextLabel.text integerValue] >= 500) {
                weakify(self);
                [ActionSheetDatePicker showPickerWithTitle:@""
                                            datePickerMode:UIDatePickerModeDate
                                              selectedDate:[NSDate date]
                                                 doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                                                     NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                                                     [formatter setDateFormat:@"yyyy/MM/dd"];
                                                     weakSelf.bFrondTime = [formatter stringFromDate:selectedDate];
                                                     cell.detailTextLabel.text = weakSelf.bFrondTime;
                                                     //结束日期
                                                     NSTimeInterval timeInter = 10 * 30 * 24 * 60 * 60;
                                                     NSDate * timeData = [NSDate dateWithTimeInterval:timeInter sinceDate:selectedDate];
                                                     [formatter setDateFormat:@"yyyy/MM"];
                                                     weakSelf.bEndTime = [NSString stringWithFormat:@"%@/%@",[formatter stringFromDate:timeData],[AlertYiJIeViewController getCurrentDayWithDate:selectedDate]];
                                                     NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
                                                     UITableViewCell * jineCell = [weakSelf.myTableView cellForRowAtIndexPath:indexPath1];
                                                     NSUInteger borrowNumMonth = 10;
                                                     switch (weakSelf.selectQiXianIndex) {
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
                                                     NSString * returnCountMounthly = [AlertYiJIeViewController getMounthPayWithBorrowCount:[jineCell.detailTextLabel.text floatValue]
                                                                                                                                  dailyRate:cingleTon.riLiLv/100//0.0005
                                                                                                                            borrowMounthNum:borrowNumMonth];
                                                     returnCountMounthly = [returnCountMounthly stringByReplacingOccurrencesOfString:@"¥" withString:@""];
                                                     weakSelf.bReturnCountMounthly = returnCountMounthly;
                                                     weakSelf.bQiXian = [NSString stringWithFormat:@"%ld",borrowNumMonth];
                                                     weakSelf.bFirstBackMoneyDate = [NSString stringWithFormat:@"%@月%@日",[AlertYiJIeViewController getNextMonthWithDate:selectedDate],[AlertYiJIeViewController getCurrentDayWithDate:selectedDate]];
                                                     [weakSelf refreshData];
                                                 }
                                               cancelBlock:^(ActionSheetDatePicker *picker) {
                                                   
                                               }
                                                    origin:self.view];
            }
            
            }
            break;
        case 3:{
            //选择还款银行卡
//            EditBankCardViewController * edit = [[EditBankCardViewController alloc] initIfEditCard:NO listIndex:0];
            ChoseBankCardViewController * edit = [[ChoseBankCardViewController alloc] init];
            weakify(self);
            edit.block = ^(BankCardModel *cardModel) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@(%@)",cardModel.bBankName,cardModel.bBankCardNum];
                weakSelf.cardModel = cardModel;
            };
            [self.navigationController pushViewController:edit animated:YES];
        }
            break;
        case 4:{
            //首月还款金额
            XZJEidtSingleLineTextFieldViewController * editVC = [[XZJEidtSingleLineTextFieldViewController alloc] initWithText:self.bReturnCountMounthly];
            [self.navigationController pushViewController:editVC animated:YES];
            weakify(self);
            editVC.block = ^(NSString *text) {
                weakSelf.bReturnCountMounthly = text;
                cell.detailTextLabel.text = text;
                
            };
        }
            break;
        case 5:{
            //借钱笔数
            XZJEidtSingleLineTextFieldViewController * editVC = [[XZJEidtSingleLineTextFieldViewController alloc] initWithText:[NSString stringWithFormat:@"%ld",cingleTon.jieQianBiShu]];
            [self.navigationController pushViewController:editVC animated:YES];
            editVC.block = ^(NSString *text) {
                cingleTon.jieQianBiShu = [text integerValue];
                cell.detailTextLabel.text = text;
                
            };
        }
            break;
        case 6:{
            //首次还款日期
            weakify(self);
            [ActionSheetDatePicker showPickerWithTitle:@""
                                        datePickerMode:UIDatePickerModeDate
                                          selectedDate:[NSDate date]
                                             doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                                                 NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                                                 [formatter setDateFormat:@"yyyy/MM/dd"];
                                                 weakSelf.bFrondTime = [formatter stringFromDate:selectedDate];
                                                 cell.detailTextLabel.text = weakSelf.bFrondTime;
                                                 weakSelf.bFirstBackMoneyDate = [NSString stringWithFormat:@"%@月%@日",[AlertYiJIeViewController getCurrentMonthWithDate:selectedDate],[AlertYiJIeViewController getCurrentDayWithDate:selectedDate]];
                                             }
                                           cancelBlock:^(ActionSheetDatePicker *picker) {
                                               
                                           }
                                                origin:self.view];
            
        }
            break;

        default:
            break;
    }
}

-(void)choseQiXianWithCell:(UITableViewCell *)cell{
    NSArray * qixianArray = @[@"5个月",@"10个月",@"20个月"];
    weakify(self);
    [XZJActionShitPicker showPickerWithTitle:nil
                                        rows:qixianArray
                            initialSelection:self.selectQiXianIndex
                                   doneBlock:^(XZJActionShitPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                       cell.detailTextLabel.text = selectedValue;
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
                                   }
                                 cancelBlock:^(XZJActionShitPicker *picker) {
                                 } origin:self.view];
}

+(NSString *)getCurrentMonthWithDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];
    return [formatter stringFromDate:date];
}


/**
 获得下个月份
 
 @return 月
 */
+(NSString *)getNextMonthWithDate:(NSDate *)date{
    NSString * currentMonth = [AlertYiJIeViewController getCurrentMonthWithDate:date];
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

+(NSString *)getCurrentDayWithDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd"];
    return [formatter stringFromDate:date];
}

/**
 获得当前日期
 
 @return 日
 */
+(NSString *)getCurrentYearWithDate:(NSDate *)date{
//    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    return [formatter stringFromDate:date];
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
    return [NSString stringWithFormat:@"¥%.2lf",(borrowCount + zongLiXi) / mounthNum];
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
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
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
