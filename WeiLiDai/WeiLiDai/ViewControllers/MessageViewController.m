//
//  MessageViewController.m
//  WeiLiDai
//
//  Created by j on 2018/2/19.
//  Copyright © 2018年 j. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UIImageView* imageView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"微信右上角"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(setBtnClicked:)];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hideBGView];
    self.navigationController.navigationBar.translucent = NO;
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)creatUI{
    [self.view addSubview:self.imageView];
}

- (void)setBtnClicked:(UIButton*)sender{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"选择图片来源" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    weakify(self);
    UIAlertAction * okAction3 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf myAlbum];
    }];
    
    [alert addAction:okAction];
    [alert addAction:okAction3];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (UIImageView*)imageView{
    if (!_imageView) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - NavigationBarHeight - TabBarHeight );
        if (@available(iOS 10.0, *)) {
        }
        else{
            frame = CGRectMake(0, StatusBarHeight + NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarHeight - NavigationBarHeight - TabBarHeight );
        }
        _imageView = [[UIImageView alloc]initWithFrame:frame];
        _imageView.image = [UIImage imageNamed:@""];
    }
    return _imageView;
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
        UIAlertController * alertC = [MessageViewController showSingleBtnAlertControllerWithMessage:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！"
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
//    SingleTon * cingleTon = [SingleTon sharedSingleTon];
//    cingleTon.userHeadImage = resultImage;
    [self.imageView setImage:resultImage];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
