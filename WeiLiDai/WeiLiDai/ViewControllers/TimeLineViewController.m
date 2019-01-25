//
//  TimeLineViewController.m
//  WeiLiDai
//
//  Created by j on 2018/2/19.
//  Copyright © 2018年 j. All rights reserved.
//

#import "TimeLineViewController.h"
#import "XZJDetailTypeCell.h"
#define detailTypeCellIden @"XZJDetailTypeCell"
#import "UITabBar+badge.h"
#import "AlertHeadImageTableViewCell.h"
#define AlertHeadImageTableViewCellIden @"AlertHeadImageTableViewCell"
#import "YeeBadgeView.h"
@interface TimeLineViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UITableView* tbView;
@property (nonatomic,strong)NSMutableArray* dataArray;
@property (nonatomic,strong)YeeBadgeView * dotView;

@end

@implementation TimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [self creatNav];
    [self creatUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self hideBGView];
    UIImage *bgImage = [[UIImage imageNamed:@"发现导航"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];//
//    [_tbView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)requestData{
    [self.dataArray addObjectsFromArray:@[
  @[@{@"headImage":@"朋友圈",@"cellTitle":@"朋友圈",@"cellSubtitle":@"",@"ifHaveRightArrow":@"0"}],
  @[@{@"headImage":@"扫一扫",@"cellTitle":@"扫一扫",@"cellSubtitle":@"",@"ifHaveRightArrow":@"0"},
  @{@"headImage":@"摇一摇",@"cellTitle":@"摇一摇",@"cellSubtitle":@"",@"ifHaveRightArrow":@"0"}],
  @[@{@"headImage":@"看一看",@"cellTitle":@"看一看",@"cellSubtitle":@"",@"ifHaveRightArrow":@"0"},
  @{@"headImage":@"搜一搜",@"cellTitle":@"搜一搜",@"cellSubtitle":@"",@"ifHaveRightArrow":@"0"}],
  @[@{@"headImage":@"附近的人",@"cellTitle":@"附近的人",@"cellSubtitle":@"",@"ifHaveRightArrow":@"0"},
  @{@"headImage":@"漂流瓶",@"cellTitle":@"漂流瓶",@"cellSubtitle":@"",@"ifHaveRightArrow":@"0"}],
  @[@{@"headImage":@"购物",@"cellTitle":@"购物",@"cellSubtitle":@"",@"ifHaveRightArrow":@"0"},
  @{@"headImage":@"游戏",@"cellTitle":@"游戏",@"cellSubtitle":@"",@"ifHaveRightArrow":@"0"}],
  @[@{@"headImage":@"小程序",@"cellTitle":@"小程序",@"cellSubtitle":@"",@"ifHaveRightArrow":@"0"}]]];
}

- (void)creatNav{
    UIImage *bgImage = [[UIImage imageNamed:@"发现导航"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];//
}

- (void)creatUI{
    [self.view addSubview:self.tbView];
}

#pragma mark -tableViewDataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;//normalSectionHeadH;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return normalSectionFootH*2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return normalCellH;
}

#pragma mark -tableViewDelegate
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0&&indexPath.row == 0) {
//        AlertHeadImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AlertHeadImageTableViewCellIden forIndexPath:indexPath];
//        if (!cell) {
//            cell = [[AlertHeadImageTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AlertHeadImageTableViewCellIden];
//
//        }
//        NSDictionary * cellDic = self.dataArray[indexPath.section][indexPath.row];
//        cell.textLabel.text = cellDic[@"cellTitle"];
//        SingleTon * cingleTon = [SingleTon sharedSingleTon];
//
//        [cell.headImageView setImage:[UIImage imageNamed:cellDic[@"headImage"]]];
//        CGFloat imageWH = 0;
//        CGFloat cellH = 0;
//        if (cingleTon.userHeadImage != nil) {
//            [cell.headImageView setImage:cingleTon.userHeadImage];
//        }
//        cellH = 246/3;
//        imageWH = cellH - Width_Scall * 18 * 2;
//        cell.headImageView.layer.masksToBounds = YES;
//        cell.headImageView.layer.cornerRadius = Width_Scall * 8;
//        cell.headImageView.frame = CGRectMake(SCREEN_WIDTH - imageWH - Width_Scall * 76, (cellH - imageWH) / 2, imageWH, imageWH);
//        return cell;
        XZJDetailTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:detailTypeCellIden forIndexPath:indexPath];
        if (!cell) {
            cell = [[XZJDetailTypeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:detailTypeCellIden];
            
        }
        
        NSDictionary * cellData = self.dataArray[indexPath.section][indexPath.row];
        [cell setCellData:cellData];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        SingleTon * cingleTon = [SingleTon sharedSingleTon];
        [cell.headImageView setImage:[UIImage imageNamed:cellData[@"headImage"]]];
        CGFloat imageWH = 0;
        CGFloat cellH = 0;
        if (cingleTon.userHeadImage != nil) {
            [cell.headImageView setImage:cingleTon.userHeadImage];
        }
        cellH = 246/3;
        imageWH = cellH - Width_Scall * 18 * 2;
        cell.headImageView.layer.masksToBounds = YES;
        cell.headImageView.layer.cornerRadius = Width_Scall * 8;
        cell.headImageView.frame = CGRectMake(SCREEN_WIDTH - imageWH - Width_Scall * 76, (cellH - imageWH) / 2, imageWH, imageWH);
        cell.headImageView.hidden = YES;
        cell.badgeView.hidden = YES;
        [cell.contentView addSubview:self.dotView];
        return cell;
    }else{
        XZJDetailTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:detailTypeCellIden forIndexPath:indexPath];
        if (!cell) {
            cell = [[XZJDetailTypeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:detailTypeCellIden];
            
        }
        
        NSDictionary * cellData = self.dataArray[indexPath.section][indexPath.row];
        [cell setCellData:cellData];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self myAlbum];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            [self cellClick:0];
        }else if (indexPath.row == 1){
            [self cellClick:2];
        }
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
//        _tbView.scrollsToTop = YES;
//        _tbView.scrollEnabled = YES;
        _tbView.backgroundColor = [UIColor clearColor];
        [_tbView registerClass:[XZJDetailTypeCell class] forCellReuseIdentifier:detailTypeCellIden];
        [_tbView registerClass:[AlertHeadImageTableViewCell class] forCellReuseIdentifier:AlertHeadImageTableViewCellIden];
        _tbView.estimatedRowHeight = 0;
        _tbView.estimatedSectionHeaderHeight = 0;
        _tbView.estimatedSectionFooterHeight = 0;
        [_tbView  setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        //        [self setupTableHeaderView];
        
    }
    return _tbView;
}

- (NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (YeeBadgeView*)dotView{
    if (!_dotView) {
        _dotView = [[YeeBadgeView alloc]initWithFrame:CGRectMake(120, normalCellH/2-12, 30, 30)];
        _dotView.redDotStytle = YeeBadgeNumberStytle;
    }
    return _dotView;
}

-(void)viewDidLayoutSubviews

{
    if ([self.tbView respondsToSelector:@selector(setSeparatorInset:)]) {

        [self.tbView setSeparatorInset:UIEdgeInsetsMake(0,40,0,0)];

    }
    if ([self.tbView respondsToSelector:@selector(setLayoutMargins:)]) {

        [self.tbView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];

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

- (void)cellClick:(int)index{
    int tabIndex = index;
    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    NSString * unreadCount = nil;
                //隐藏
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"设置按钮上的未读消息数" preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
                }];
                weakify(self);
                UIAlertAction * okAction2 = [UIAlertAction actionWithTitle:@"未读消息数" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.tabBarController.tabBar hideBadgeOnItemIndex:tabIndex];
                    
                    UIAlertController * alertT = [FactryFucClass showDoubleBtnWithTextFieldAlertControllerWithTitle:@"修改未读消息数"
                                                                                                             Message:nil
                                                                                                        doneBtnTitle:nil
                                                                                                      cancelBtnTitle:nil
                                                                                                       textFieldText:unreadCount
                                                                                               textFieldKeyboardType:UIKeyboardTypeNumberPad
                                                                                                        andDoneBlock:^(UIAlertAction * _Nonnull action, NSArray<UITextField *> * _Nullable textFields) {
                                                                                                            UITabBarItem * item1 = [weakSelf.tabBarController.tabBar.items objectAtIndex:tabIndex];
                                                                                                            UITextField * textfield = [textFields firstObject];
                                                                                                            if (textfield.text.length > 2) {
                                                                                                                item1.badgeValue = @"...";
                                                                                                            }
                                                                                                            else{
                                                                                                                item1.badgeValue = textfield.text;
                                                                                                            }
    
                                                                                                            cingleTon.unreadPraiseCount = textfield.text;
                                                                                                            cingleTon.haveUnreadPraisePoint = NO;
                                                                                                            if (tabIndex == 2) {
                                                                                                                NSIndexPath* index = [NSIndexPath indexPathForRow:0 inSection:0];
                                                                                                                XZJDetailTypeCell* cell = [self.tbView cellForRowAtIndexPath:index];
                                                                                                                cell.headImageView.hidden = YES;
                                                                                                                cell.badgeView.hidden = YES;
                                                                                                                weakSelf.dotView.hidden = NO;
                                                                                                                if (textfield.text.length>2) {
                                                                                                                    weakSelf.dotView.redDotNumber = 1000;
                                                                                                                }else{
                                                                                                                    weakSelf.dotView.redDotNumber = [textfield.text integerValue];
                                                                                                                }
                                                                                                                
                                                                                                            }
                                                                                                        }
                                                                                                      andCancelBlock:^(UIAlertAction * _Nonnull action) {
    
                                                                                                      }];
                    [weakSelf presentViewController:alertT animated:YES completion:^{
    
                    }];
    
                }];
                UIAlertAction * okAction3 = [UIAlertAction actionWithTitle:@"消息提醒(小圆点)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.tabBarController.tabBar showBadgeOnItemIndex:tabIndex];
                    UITabBarItem * item1 = [weakSelf.tabBarController.tabBar.items objectAtIndex:tabIndex];
                    item1.badgeValue = nil;
                    cingleTon.unreadPraiseCount = nil;
                    cingleTon.haveUnreadPraisePoint = YES;
                    if (tabIndex == 2) {
                        weakSelf.dotView.hidden = YES;
                        NSIndexPath* index = [NSIndexPath indexPathForRow:0 inSection:0];
                        XZJDetailTypeCell* cell = [self.tbView cellForRowAtIndexPath:index];
                        cell.headImageView.hidden = NO;
                        cell.badgeView.hidden = NO;
                        NSString* imageName = [NSString stringWithFormat:@"%u",arc4random() % 900 + 100000];
                        cell.headImageView.image = [UIImage imageNamed:imageName];
                    }
                }];
                UIAlertAction * okAction4 = [UIAlertAction actionWithTitle:@"还原" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.tabBarController.tabBar hideBadgeOnItemIndex:tabIndex];
                    UITabBarItem * item1 = [weakSelf.tabBarController.tabBar.items objectAtIndex:tabIndex];
                    item1.badgeValue = nil;
                    cingleTon.unreadPraiseCount = nil;
                    cingleTon.haveUnreadPraisePoint = NO;
                    if (tabIndex == 2) {
                        weakSelf.dotView.hidden = YES;
                        NSIndexPath* index = [NSIndexPath indexPathForRow:0 inSection:0];
                        XZJDetailTypeCell* cell = [self.tbView cellForRowAtIndexPath:index];
                        cell.headImageView.hidden = YES;
                        cell.badgeView.hidden = YES;
                    }
                }];
    
                [alert addAction:okAction];
                [alert addAction:okAction2];
                [alert addAction:okAction3];
                [alert addAction:okAction4];
                [self presentViewController:alert animated:YES completion:^{
    
                }];
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
        UIAlertController * alertC = [TimeLineViewController showSingleBtnAlertControllerWithMessage:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！"
                                                                                         doneBtnTitle:@"确定"
                                                                                         andDoneBlock:^(UIAlertAction * _Nonnull action) {
                                                                                             
                                                                                         }];
        [weakSelf presentViewController:alertC animated:YES completion:nil];
        
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
#pragma mark-> imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.获取选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //压缩图片
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    UIImage *resultImage = [UIImage imageWithData:data];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    XZJDetailTypeCell * cell = [self.tbView cellForRowAtIndexPath:indexPath];
//    SingleTon * cingleTon = [SingleTon sharedSingleTon];
    //    cingleTon.userHeadImageName = [NSString stringWithFormat:@"%u",arc4random() % 1000 + 100000];
//    cingleTon.userHeadImage = resultImage;
    [cell.headImageView setImage:resultImage];
    cell.headImageView.hidden = NO;
    cell.badgeView.hidden = NO;
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}
@end
