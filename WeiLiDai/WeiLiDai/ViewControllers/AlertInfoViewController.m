
//
//  AlertInfoViewController.m
//  WeiLiDai
//
//  Created by j on 2018/2/24.
//  Copyright © 2018年 j. All rights reserved.
//

#import "AlertInfoViewController.h"
#import "AlertHeadImageTableViewCell.h"
#import "XZJEidtSingleLineTextFieldViewController.h"
#import "AlertNamesViewController.h"

#define AlertHeadImageTableViewCellIden @"AlertHeadImageTableViewCell.h"
#define AlertTextTableViewCellIden @"AlertTextTableViewCell"

typedef void (^doneBlock)(UIAlertAction * _Nonnull action);
typedef void (^cancelBlock)(UIAlertAction * _Nonnull action);

@interface AlertInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView * myTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation AlertInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack];
    [self createDataSources];
    [self createUI];
}

-(void)createDataSources{
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    [self.dataArray removeAllObjects];
    
    [self.dataArray addObjectsFromArray:@[
                                          @[
                                              @{@"headImage":cingleTon.userHeadImageName,@"cellTitle":@"头像",@"cellSubtitle":@"",@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"MoreMyAlbum",@"cellTitle":@"名字",@"cellSubtitle":cingleTon.userNick,@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"MyCar",@"cellTitle":@"微信号",@"cellSubtitle":cingleTon.userNum,@"ifHaveRightArrow":@"0"},
                                              @{@"headImage":@"我页面的小二维码",@"cellTitle":@"我的二维码",@"cellSubtitle":@"",@"ifHaveRightArrow":@"1"},
                                              @{@"headImage":@"MoreShops",@"cellTitle":@"更多",@"cellSubtitle":@"",@"ifHaveRightArrow":@"1"}],
                                          @[
                                              @{@"headImage":@"MoreSetting",@"cellTitle":@"我的地址",@"cellSubtitle":@"",@"ifHaveRightArrow":@"1"}]]];
}

-(void)createUI{
    if (@available(iOS 10.0, *)) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.title = @"个人信息";
    [self.view addSubview:self.myTableView];
//    UIView * bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarHeight + StatusBarHeight)];
//    bgView2.backgroundColor = baseViewVCBG;
//    [self.view addSubview:bgView2];
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
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return normalSectionFootH;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 246/3;
    }
    return normalCellH;
}

#pragma mark - tableViewDelagate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 3)) {
        AlertHeadImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AlertHeadImageTableViewCellIden forIndexPath:indexPath];
        if (!cell) {
            cell = [[AlertHeadImageTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AlertHeadImageTableViewCellIden];
            
        }
        
        NSDictionary * cellDic = self.dataArray[indexPath.section][indexPath.row];
        cell.textLabel.text = cellDic[@"cellTitle"];
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        
        [cell.headImageView setImage:[UIImage imageNamed:cellDic[@"headImage"]]];
        CGFloat imageWH = 0;
        CGFloat cellH = 0;
        if (indexPath.row == 0) {
            if (cingleTon.userHeadImage != nil) {
                [cell.headImageView setImage:cingleTon.userHeadImage];
            }
            cellH = 246/3;
            imageWH = cellH - Width_Scall * 18 * 2;
            cell.headImageView.layer.masksToBounds = YES;
            cell.headImageView.layer.cornerRadius = Width_Scall * 8;
        }
        else{
            cellH = normalCellH;
//            imageWH = cellH - Width_Scall * 18 * 2;
//            imageWH = Width_Scall * 34;
            imageWH = 78/3;
            cell.headImageView.layer.masksToBounds = YES;
            cell.headImageView.layer.cornerRadius = 0;
        }
        cell.headImageView.frame = CGRectMake(SCREEN_WIDTH - imageWH - Width_Scall * 76, (cellH - imageWH) / 2, imageWH, imageWH);
        
        return cell;
    }
    else{
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
        cell.detailTextLabel.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE+1];
        if (indexPath.row == 2) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        
        return cell;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    weakify(self);
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                //头像
                AlertHeadImageTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"选择图片来源" preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                weakify(self);
                UIAlertAction * okAction2 = [UIAlertAction actionWithTitle:@"随机一个" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    cingleTon.userHeadImageName = [NSString stringWithFormat:@"%u",arc4random() % 1000 + 100000];
                    cingleTon.userHeadImage = nil;
                    [cell.headImageView setImage:[UIImage imageNamed:cingleTon.userHeadImageName]];
                }];
                UIAlertAction * okAction3 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf myAlbum];
                }];
                
                [alert addAction:okAction];
                [alert addAction:okAction2];
                [alert addAction:okAction3];
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
            }
                break;
            case 1:{
                //昵称
                UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
                XZJEidtSingleLineTextFieldViewController * alertNameVC = [[XZJEidtSingleLineTextFieldViewController alloc] initWithText:cingleTon.userNick];
                alertNameVC.title = @"修改昵称";
                alertNameVC.block = ^(NSString *text) {
                    cingleTon.userNick = text;
                    cell.detailTextLabel.text = text;
                    [weakSelf createDataSources];
                    [weakSelf.myTableView reloadData];
                };
                [self.navigationController pushViewController:alertNameVC animated:YES];
            }
                break;
            case 2:{
                //微信号
                UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
                XZJEidtSingleLineTextFieldViewController * alertNameVC = [[XZJEidtSingleLineTextFieldViewController alloc] initWithText:cingleTon.userNum];
                alertNameVC.title = @"修改微信号";
                alertNameVC.block = ^(NSString *text) {
                    cingleTon.userNum = text;
                    cell.detailTextLabel.text = text;
                    [weakSelf createDataSources];
                    [weakSelf.myTableView reloadData];
                };
                [self.navigationController pushViewController:alertNameVC animated:YES];
            }
                break;
            case 4:{
                AlertNamesViewController * alertVC = [[AlertNamesViewController alloc] init];
                [self.navigationController pushViewController:alertVC animated:YES];
            }
                break;
            default:
                break;
        }
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
        [_myTableView registerClass:[AlertHeadImageTableViewCell class] forCellReuseIdentifier:AlertHeadImageTableViewCellIden];
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

+(void)setNavigationTintColorWithBlack:(BOOL)isBlack{
    UIStatusBarStyle barStyle = UIStatusBarStyleLightContent;
    UIColor * tintColor = [UIColor whiteColor];
    if (isBlack) {
        barStyle = UIStatusBarStyleDefault;
        tintColor = [UIColor blackColor];
    }
    [UIApplication sharedApplication].statusBarStyle = barStyle;
    UINavigationBar  *bar = [UINavigationBar appearance];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        bar.barStyle = UIBarStyleDefault;
        NSDictionary *dict =@{NSForegroundColorAttributeName:tintColor/*,
                                                                       NSFontAttributeName:[UIFont systemFontOfSize:CELL_FONTSIZE]*/
                              };
        [bar setTitleTextAttributes:dict];
        //设置主题
        [bar setTintColor:tintColor];
    }
}

+(UIAlertController * _Nullable )showSingleBtnAlertControllerWithMessage:( NSString * _Nullable )message
                                                            doneBtnTitle:(NSString * _Nullable)doneBtnTitle
                                                            andDoneBlock:(_Nullable doneBlock)doneBlock{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    NSString * doneTitle = @"确定";
    if (doneBtnTitle) {
        doneTitle = doneBtnTitle;
    }
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:doneTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //        if (action) {
        doneBlock(action);
        //        }
        
    }];
    [alert addAction:okAction];
    return alert;
}

-(void)myAlbum{
    weakify(self);
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        //1.初始化相册拾取器
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        //2.设置代理
        controller.delegate = weakSelf;
        //3.设置资源：
        /**
         UIImagePickerControllerSourceTypePhotoLibrary,相册
         UIImagePickerControllerSourceTypeCamera,相机
         UIImagePickerControllerSourceTypeSavedPhotosAlbum,照片库
         */
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //4.随便给他一个转场动画
        controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        
//        [AlertInfoViewController setNavigationTintColorWithBlack:YES];
        
        [weakSelf presentViewController:controller animated:YES completion:NULL];
        
    }else{
        UIAlertController * alertC = [AlertInfoViewController showSingleBtnAlertControllerWithMessage:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！"
                                                                                doneBtnTitle:@"确定"
                                                                                andDoneBlock:^(UIAlertAction * _Nonnull action) {
                                                                                    
                                                                                }];
        [weakSelf presentViewController:alertC animated:YES completion:nil];
        
    }
    
    
    
}
#pragma mark-> imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.获取选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //压缩图片
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    UIImage *resultImage = [UIImage imageWithData:data];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    AlertHeadImageTableViewCell * cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
//    cingleTon.userHeadImageName = [NSString stringWithFormat:@"%u",arc4random() % 1000 + 100000];
    cingleTon.userHeadImage = resultImage;
    [cell.headImageView setImage:resultImage];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
