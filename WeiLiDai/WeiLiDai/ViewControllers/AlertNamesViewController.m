//
//  AlertNamesViewController.m
//  WeiLiDai
//
//  Created by j on 2018/2/25.
//  Copyright © 2018年 j. All rights reserved.
//

#import "AlertNamesViewController.h"
#import "XZJEidtSingleLineTextFieldViewController.h"
#import "AddBankCardViewController.h"
#import "ActionSheetPicker.h"
#import "XZJBaseViewController.h"

#define AlertTextTableViewCellIden @"AlertTextTableViewCell"

@interface AlertNamesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * myTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation AlertNamesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack];
    [self createDataSources];
    [self createUI];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self hideBGView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
    
}


-(void)createDataSources{
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    [self.dataArray removeAllObjects];
//    cingleTon.haveUnreadFriendPoint;
    NSString* lirv = [NSString stringWithFormat:@"%0.3f" ,cingleTon.riLiLv];
    [self.dataArray addObjectsFromArray:@[
                                          @[
                                              @{@"headImage":@"",@"cellTitle":@"姓氏",@"cellSubtitle":cingleTon.bLastName,@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"MoreMyAlbum",@"cellTitle":@"身份证前4位",@"cellSubtitle":cingleTon.bIdCard1,@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"MyCar",@"cellTitle":@"手机号前3位",@"cellSubtitle":cingleTon.bPhoneNum1,@"ifHaveRightArrow":@"0"},
                                              @{@"headImage":@"setting_myQR",@"cellTitle":@"手机号后4位",@"cellSubtitle":cingleTon.bPhoneNum3,@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"setting_myQR",@"cellTitle":@"添加银行卡",@"cellSubtitle":@"",@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"setting_myQR",@"cellTitle":@"是否显示\"保险服务\"",@"cellSubtitle":cingleTon.isShowEnsure,@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"setting_myQR",@"cellTitle":@"放款等待时间(分钟)",@"cellSubtitle":cingleTon.witeTime,@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"setting_myQR",@"cellTitle":@"是否显示\"微粒贷\"",@"cellSubtitle":cingleTon.isShowWeiLiDai,@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"setting_myQR",@"cellTitle":@"是否显示\"获取验证码页面\"",@"cellSubtitle":cingleTon.isShowGetSMSCodeVC,@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"setting_myQR",@"cellTitle":@"日利率(%)",@"cellSubtitle":[NSString stringWithFormat:@"%@%%",@(lirv.floatValue)],@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"setting_myQR",@"cellTitle":@"是否显示\"游戏微商店\"",@"cellSubtitle":cingleTon.isShowGram,@"ifHaveRightArrow":@"1"},
                                            @{@"headImage":@"setting_myQR",@"cellTitle":@"是否显示\"喇叭提示功能\"",@"cellSubtitle":cingleTon.isShowHorn,@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"setting_myQR",@"cellTitle":@"是否显示\"降利功能\"",@"cellSubtitle":cingleTon.isShowDownLi,@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"setting_myQR",@"cellTitle":@"预设可借额度",@"cellSubtitle":[NSString stringWithFormat:@"%0.2lf",cingleTon.yuSheKeJieEDu],@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"setting_myQR",@"cellTitle":@"是否显示不全姓名和银行卡",@"cellSubtitle":cingleTon.isNeedMessage?@"是":@"否",@"ifHaveRightArrow":@"1"}
//                                              ,@{@"headImage":@"erweima2",@"cellTitle":@"我页面未读消息数",@"cellSubtitle":(cingleTon.haveUnreadFriendPoint?@"红点":(cingleTon.unreadFriendCount?cingleTon.unreadFriendCount:@"")),@"ifHaveRightArrow":@"1"}
                                              ]]];
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
//    UIView * bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight + StatusBarHeight)];
//    bgView2.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:bgView2];
    
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
    return self.dataArray.count;
}
//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;//normalSectionHeadH;
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
    
    NSDictionary * cellDic = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.text = cellDic[@"cellTitle"];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:CELL_FONTSIZE];
    cell.detailTextLabel.text = cellDic[@"cellSubtitle"];
    //    cell.detailTextLabel.textColor = tabbarSelectedColor;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
//    if (indexPath.row == 2) {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        switch (indexPath.row) {
            case 0:{
                //姓氏
                XZJEidtSingleLineTextFieldViewController * alertNameVC = [[XZJEidtSingleLineTextFieldViewController alloc] initWithText:cingleTon.bLastName];
                alertNameVC.title = @"修改姓氏";
                alertNameVC.block = ^(NSString *text) {
                    cingleTon.bLastName = text;
                    cell.detailTextLabel.text = text;
                };
                [self.navigationController pushViewController:alertNameVC animated:YES];
            }
                break;
            case 1:{
                //身份证前4位
                XZJEidtSingleLineTextFieldViewController * alertNameVC = [[XZJEidtSingleLineTextFieldViewController alloc] initWithText:cingleTon.bIdCard1];
                alertNameVC.title = @"修改身份证前4位";
                alertNameVC.block = ^(NSString *text) {
                    cingleTon.bIdCard1 = text;
                    cell.detailTextLabel.text = text;
                };
                [self.navigationController pushViewController:alertNameVC animated:YES];
            }
                break;
            case 2:{
                //手机号前3位
                XZJEidtSingleLineTextFieldViewController * alertNameVC = [[XZJEidtSingleLineTextFieldViewController alloc] initWithText:cingleTon.bPhoneNum1];
                alertNameVC.title = @"修改手机号前3位";
                alertNameVC.block = ^(NSString *text) {
                    cingleTon.bPhoneNum1 = text;
                    cell.detailTextLabel.text = text;
                };
                [self.navigationController pushViewController:alertNameVC animated:YES];
            }
                break;
            case 3:{
                //手机号后4位
                XZJEidtSingleLineTextFieldViewController * alertNameVC = [[XZJEidtSingleLineTextFieldViewController alloc] initWithText:cingleTon.bPhoneNum3];
                alertNameVC.title = @"手机号后4位";
                alertNameVC.block = ^(NSString *text) {
                    cingleTon.bPhoneNum3 = text;
                    cell.detailTextLabel.text = text;
                };
                [self.navigationController pushViewController:alertNameVC animated:YES];
            }
                break;
            case 4:{
                //添加银行卡
                AddBankCardViewController * addVC = [[AddBankCardViewController alloc] init];
                [self.navigationController pushViewController:addVC animated:YES];
                
            }
                break;
            case 5:{
                //是否显示保险服务
                NSArray * arr = @[@"是",@"否"];
                NSUInteger selIndex = 0;
                if ([cingleTon.isShowEnsure isEqualToString:@"否"]) {
                    selIndex = 1;
                }
                [ActionSheetStringPicker showPickerWithTitle:@"选择是否显示保险服务"
                                                        rows:arr
                                            initialSelection:selIndex
                                                   doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                       cell.detailTextLabel.text = selectedValue;
                                                       cingleTon.isShowEnsure = selectedValue;
                                                   }
                                                 cancelBlock:^(ActionSheetStringPicker *picker) {
                                                     
                                                 }
                                                      origin:self.view];
                
            }
                break;
            case 6:{
                //放款等待时间
                XZJEidtSingleLineTextFieldViewController * alertNameVC = [[XZJEidtSingleLineTextFieldViewController alloc] initWithText:cingleTon.witeTime];
                alertNameVC.title = @"修改放款等待时间(分钟)";
                alertNameVC.block = ^(NSString *text) {
                    cingleTon.witeTime = text;
                    cell.detailTextLabel.text = text;
                };
                [self.navigationController pushViewController:alertNameVC animated:YES];
            }
                break;
            case 7:{
                //是否显示微粒贷
                NSArray * arr = @[@"是",@"否"];
                NSUInteger selIndex = 0;
                if ([cingleTon.isShowWeiLiDai isEqualToString:@"否"]) {
                    selIndex = 1;
                }
                [ActionSheetStringPicker showPickerWithTitle:@"选择是否显示微粒贷"
                                                        rows:arr
                                            initialSelection:selIndex
                                                   doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                       cell.detailTextLabel.text = selectedValue;
                                                       cingleTon.isShowWeiLiDai = selectedValue;
                                                   }
                                                 cancelBlock:^(ActionSheetStringPicker *picker) {
                                                     
                                                 }
                                                      origin:self.view];
                
            }
                break;
            case 8:{
                //是否显示获取验证码页面
                NSArray * arr = @[@"是",@"否"];
                NSUInteger selIndex = 0;
                if ([cingleTon.isShowGetSMSCodeVC isEqualToString:@"否"]) {
                    selIndex = 1;
                }
                [ActionSheetStringPicker showPickerWithTitle:@"选择是否显示验证码页面"
                                                        rows:arr
                                            initialSelection:selIndex
                                                   doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                       cell.detailTextLabel.text = selectedValue;
                                                       cingleTon.isShowGetSMSCodeVC = selectedValue;
                                                   }
                                                 cancelBlock:^(ActionSheetStringPicker *picker) {
                                                     
                                                 }
                                                      origin:self.view];
                
            }
                break;
//            case 9:{
//                XZJBaseViewController * baseVC = [XZJBaseViewController sharedBaseViewController];
//
//                int tabIndex = 0;
//                NSString * unreadCount = nil;
//                BOOL haveUnreadPoint = NO;
//
//                tabIndex = 3;
//                unreadCount = cingleTon.unreadFriendCount;
//                haveUnreadPoint = cingleTon.haveUnreadFriendPoint;
//
//                UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"设置按钮上的未读消息数" preferredStyle:UIAlertControllerStyleActionSheet];
//                UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//                }];
//                weakify(self);
//                UIAlertAction * okAction2 = [UIAlertAction actionWithTitle:@"未读消息数" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    [baseVC.tabbar.tabBar hideBadgeOnItemIndex:tabIndex];
//                    UIAlertController * alertT = [FactryFucClass showDoubleBtnWithTextFieldAlertControllerWithTitle:@"修改未读消息数"
//                                         Message:nil
//                                    doneBtnTitle:nil
//                                  cancelBtnTitle:nil
//                                   textFieldText:unreadCount
//                           textFieldKeyboardType:UIKeyboardTypeNumberPad
//                                    andDoneBlock:^(UIAlertAction * _Nonnull action, NSArray<UITextField *> * _Nullable textFields) {
//                                        UITabBarItem * item1 = [baseVC.tabbar.tabBar.items objectAtIndex:tabIndex];
//                                        UITextField * textfield = [textFields firstObject];
//                                        if (textfield.text.length > 2) {
//                                            item1.badgeValue = @"...";
//                                        }
//                                        else{
//                                            item1.badgeValue = textfield.text;
//                                            cell.detailTextLabel.text = textfield.text;
//                                        }
//
//                                        switch (tabIndex) {
//                                            case 0:{
//                                                cingleTon.unreadHomeCount = textfield.text;
//                                                cingleTon.haveUnreadHomePoint = NO;
//                                            }
//                                                break;
//                                            case 1:{
//                                                cingleTon.unreadWealthCount = textfield.text;
//                                                cingleTon.haveUnreadWealthPoint = NO;
//                                            }
//                                                break;
//                                            case 2:{
//                                                cingleTon.unreadPraiseCount = textfield.text;
//                                                cingleTon.haveUnreadPraisePoint = NO;
//                                            }
//                                                break;
//                                            case 3:{
//                                                cingleTon.unreadFriendCount = textfield.text;
//                                                cingleTon.haveUnreadFriendPoint = NO;
//                                            }
//                                                break;
//                                            default:
//                                                break;
//                                        }
//                                        [weakSelf createDataSources];
//                                    }
//                                  andCancelBlock:^(UIAlertAction * _Nonnull action) {
//
//                                  }];
//                    [self presentViewController:alertT animated:YES completion:^{
//
//                    }];
//
//                }];
//                UIAlertAction * okAction3 = [UIAlertAction actionWithTitle:@"消息提醒(小圆点)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    [baseVC.tabbar.tabBar showBadgeOnItemIndex:tabIndex];
//                    UITabBarItem * item1 = [baseVC.tabbar.tabBar.items objectAtIndex:tabIndex];
//                    item1.badgeValue = nil;
//                    switch (tabIndex) {
//                        case 0:{
//                            cingleTon.unreadHomeCount = nil;
//                            cingleTon.haveUnreadHomePoint = YES;
//                        }
//                            break;
//                        case 1:{
//                            cingleTon.unreadWealthCount = nil;
//                            cingleTon.haveUnreadWealthPoint = YES;
//                        }
//                            break;
//                        case 2:{
//                            cingleTon.unreadPraiseCount = nil;
//                            cingleTon.haveUnreadPraisePoint = YES;
//                        }
//                            break;
//                        case 3:{
//                            cingleTon.unreadFriendCount = nil;
//                            cingleTon.haveUnreadFriendPoint = YES;
//                        }
//                            break;
//                        default:
//                            break;
//                    }
//                    [weakSelf createDataSources];
//                }];
//                UIAlertAction * okAction4 = [UIAlertAction actionWithTitle:@"还原" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    [baseVC.tabbar.tabBar hideBadgeOnItemIndex:tabIndex];
//                    UITabBarItem * item1 = [baseVC.tabbar.tabBar.items objectAtIndex:tabIndex];
//                    item1.badgeValue = nil;
//                    switch (tabIndex) {
//                        case 0:{
//                            cingleTon.unreadHomeCount = nil;
//                            cingleTon.haveUnreadHomePoint = NO;
//                        }
//                            break;
//                        case 1:{
//                            cingleTon.unreadWealthCount = nil;
//                            cingleTon.haveUnreadWealthPoint = NO;
//                        }
//                            break;
//                        case 2:{
//                            cingleTon.unreadPraiseCount = nil;
//                            cingleTon.haveUnreadPraisePoint = NO;
//                        }
//                            break;
//                        case 3:{
//                            cingleTon.unreadFriendCount = nil;
//                            cingleTon.haveUnreadFriendPoint = NO;
//                        }
//                            break;
//                        default:
//                            break;
//                    }
//                    [weakSelf createDataSources];
//                }];
//
//                [alert addAction:okAction];
//                [alert addAction:okAction2];
//                [alert addAction:okAction3];
//                [alert addAction:okAction4];
//                [self presentViewController:alert animated:YES completion:^{
//
//                }];
//            }
//                break;
            case 9:{
                //日利率
                NSString* lirv = [NSString stringWithFormat:@"%0.3f" ,cingleTon.riLiLv];
                XZJEidtSingleLineTextFieldViewController * alertNameVC = [[XZJEidtSingleLineTextFieldViewController alloc] initWithText:[NSString stringWithFormat:@"%@",@(lirv.floatValue)]];
                alertNameVC.riLiLv = [cell.detailTextLabel.text stringByReplacingOccurrencesOfString:@"%" withString:@""];
                alertNameVC.title = @"修改修改日利率(%%)";
//                NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
//                NSString* old = [userdefault objectForKey:DownLi];
//                NSString* new = [userdefault objectForKey:DownLiNew];
//                [userdefault setObject:[cell.detailTextLabel.text stringByReplacingOccurrencesOfString:@"%" withString:@""] forKey:DownLi];
                __weak typeof (SingleTon*) weakcingleTon = cingleTon;
                alertNameVC.block = ^(NSString *text) {
                    weakcingleTon.riLiLv = [text floatValue];
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%%",text];
//                    [userdefault setObject:text forKey:DownLiNew];
                };
                [self.navigationController pushViewController:alertNameVC animated:YES];
            }
                break;
            case 10:{
                //是否显示游戏微商店
                NSArray * arr = @[@"是",@"否"];
                NSUInteger selIndex = 0;
                if ([cingleTon.isShowGram isEqualToString:@"否"]) {
                    selIndex = 1;
                }
                [ActionSheetStringPicker showPickerWithTitle:@"选择是否显示游戏微商店"
                                                        rows:arr
                                            initialSelection:selIndex
                                                   doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                       cell.detailTextLabel.text = selectedValue;
                                                       cingleTon.isShowGram = selectedValue;
                                                   }
                                                 cancelBlock:^(ActionSheetStringPicker *picker) {
                                                     
                                                 }
                                                      origin:self.view];
                
            }
                break;
            case 11:{
                //是否显示喇叭内容
                NSArray * arr = @[@"是",@"否"];
                NSUInteger selIndex = 0;
                if ([cingleTon.isShowHorn isEqualToString:@"否"]) {
                    selIndex = 1;
                }
                UIAlertController* aleart = [UIAlertController alertControllerWithTitle:@"选择是否显示喇叭提示功能" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                [aleart addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.placeholder = @"提示内容";
                    cingleTon.hornContent = textField.text;
                    //添加监听
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
                    
                    
                }];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction *alertAction){
                    cell.detailTextLabel.text = arr[0];
                    cingleTon.isShowHorn = arr[0];
                    //移除监听
                    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                    
                }];
//                okAction.enabled = NO;//设置不可点击
                [aleart addAction:okAction];
                UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    cell.detailTextLabel.text = arr[1];
                    cingleTon.isShowHorn = arr[1];
                }];
                [aleart addAction:cancalAction];
                [self presentViewController:aleart animated:YES completion:nil];
            }
                break;
            case 12:{
                //是否显示降利
                NSArray * arr = @[@"是",@"否"];
                NSUInteger selIndex = 0;
                if ([cingleTon.isShowDownLi isEqualToString:@"否"]) {
                    selIndex = 1;
                }
//                [ActionSheetStringPicker showPickerWithTitle:@"选择是否显示降利"
//                                                        rows:arr
//                                            initialSelection:selIndex
//                                                   doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
//                                                       cell.detailTextLabel.text = selectedValue;
//                                                       cingleTon.isShowDownLi = selectedValue;
//                                                   }
//                                                 cancelBlock:^(ActionSheetStringPicker *picker) {
//
//                                                 }
//                                                      origin:self.view];
                UIAlertController* aleart = [UIAlertController alertControllerWithTitle:@"选择是否显示降利功能" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                [aleart addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.placeholder = @"提示内容";
//                    textField.keyboardType = UIKeyboardTypeNumberPad;
                    cingleTon.downLi = [textField.text floatValue];
                    //添加监听
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange1:) name:UITextFieldTextDidChangeNotification object:textField];
                    
                    
                }];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:arr[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction *alertAction){
                    cell.detailTextLabel.text = arr[0];
                    cingleTon.isShowDownLi = arr[0];
                    //移除监听
                    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                    
                }];
                //                okAction.enabled = NO;//设置不可点击
                [aleart addAction:okAction];
                UIAlertAction *cancalAction = [UIAlertAction actionWithTitle:arr[1] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    cell.detailTextLabel.text = arr[1];
                    cingleTon.isShowDownLi = arr[1];
                }];
                [aleart addAction:cancalAction];
                [self presentViewController:aleart animated:YES completion:nil];
                
            }
                break;
            case 13:{
                //预设可借额度
                NSString* lirv = [NSString stringWithFormat:@"%0.2f" ,cingleTon.yuSheKeJieEDu];
                XZJEidtSingleLineTextFieldViewController * alertNameVC = [[XZJEidtSingleLineTextFieldViewController alloc] initWithText:[NSString stringWithFormat:@"%@",@(lirv.floatValue)]];
//                alertNameVC.riLiLv = [cell.detailTextLabel.text stringByReplacingOccurrencesOfString:@"%" withString:@""];
                alertNameVC.title = @"修改预设可借额度";
                //                NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
                //                NSString* old = [userdefault objectForKey:DownLi];
                //                NSString* new = [userdefault objectForKey:DownLiNew];
                //                [userdefault setObject:[cell.detailTextLabel.text stringByReplacingOccurrencesOfString:@"%" withString:@""] forKey:DownLi];
                __weak typeof (SingleTon*) weakcingleTon = cingleTon;
                alertNameVC.block = ^(NSString *text) {
                    weakcingleTon.yuSheKeJieEDu = [text floatValue];
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%0.2f",weakcingleTon.yuSheKeJieEDu];
                    weakcingleTon.isOnYuShe = NO;
                    //                    [userdefault setObject:text forKey:DownLiNew];
                };
                [self.navigationController pushViewController:alertNameVC animated:YES];
            }
                break;
            case 14:{
                //选择是否显示不全银行卡和姓名
                NSArray * arr = @[@"是",@"否"];
                NSUInteger selIndex = 0;
                if (!cingleTon.isNeedMessage) {
                    selIndex = 1;
                }
                [ActionSheetStringPicker showPickerWithTitle:@"选择是否显示补全姓名和银行卡尾号"
                                                        rows:arr
                                            initialSelection:selIndex
                                                   doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                       cell.detailTextLabel.text = selectedValue;
                                                       if ([selectedValue isEqualToString:@"是"]) {
                                                           cingleTon.isNeedMessage = YES;
                                                       }
                                                       else{
                                                           cingleTon.isNeedMessage = NO;
                                                       }
                                                       
                                                   }
                                                 cancelBlock:^(ActionSheetStringPicker *picker) {
                                                     
                                                 }
                                                      origin:self.view];
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

- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *login = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = login.text.length > 2;
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        cingleTon.hornContent = login.text;
    }
}
- (void)alertTextFieldDidChange1:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *login = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = login.text.length > 2;
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        cingleTon.downLi = [login.text floatValue];
    }
}


@end
