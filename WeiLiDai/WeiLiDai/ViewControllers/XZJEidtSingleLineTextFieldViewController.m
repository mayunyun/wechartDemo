//
//  XZJEidtSingleLineTextFieldViewController.m
//  HuaShiJinFu
//
//  Created by j on 2018/2/8.
//  Copyright © 2018年 FangLian. All rights reserved.
//

#import "XZJEidtSingleLineTextFieldViewController.h"

@interface XZJEidtSingleLineTextFieldViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) UIButton * leftBarBtn;
@property (nonatomic, strong) UIButton * rightBarBtn;

@end

@implementation XZJEidtSingleLineTextFieldViewController

-(instancetype)initWithText:(NSString *)oldText{
    if (self = [super init]) {
        self.textField.text = oldText;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navUI];
//    UIView * textBgView = [XZJFactoryFunc createViewWithFrame:CGRectMake(0, spaceMargin, SCREEN_WIDTH, self.textField.frame.size.height)
//                                              backgroundColor:[UIColor whiteColor]];
    UIView * textBgView = [[UIView alloc] initWithFrame:CGRectMake(0,  NavigationBarHeight + StatusBarHeight, SCREEN_WIDTH, self.textField.frame.size.height)];//spaceMargin
    textBgView.backgroundColor = [UIColor whiteColor];
    if (!IsEmptyValue(self.riLiLv)) {
        self.textField.text = self.riLiLv;
    }
    [textBgView addSubview:self.textField];
    [self.view addSubview:textBgView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.textField];

}
- (void)navUI{
    UIBarButtonItem* left = [[UIBarButtonItem alloc]initWithCustomView:self.leftBarBtn];
    self.navigationItem.leftBarButtonItem = left;
    UIBarButtonItem* right = [[UIBarButtonItem alloc]initWithCustomView:self.rightBarBtn];
    self.navigationItem.rightBarButtonItem = right;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length == 0) {
        //        [XZJFactoryFunc createModeTextProgressHUDInParentView:self.view andLabelText:[NSString stringWithFormat:@"%@不能为空",self.title] delayTime:progressHUDShowTime];
        MBProgressHUD * progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progressHUD.mode = MBProgressHUDModeText;
        progressHUD.labelText = [NSString stringWithFormat:@"%@不能为空",self.title];
        [progressHUD hide:YES afterDelay:0.8];
        return NO;
    }
    self.block(textField.text);
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}


#pragma mark - 懒加载

//-(UITextField *)textField{
//    if (!_textField) {
//        _textField = [XZJFactoryFunc createTextFieldWithFrame:CGRectMake(spaceMargin, 0, SCREEN_WIDTH - spaceMargin * 2, Width_Scall * 86)
//                                                         font:[UIFont systemFontOfSize:DEFAULT_FONTSIZE]
//                                              backgroundColor:nil
//                                                  placeholder:@""
//                                         clearsOnBeginEditing:NO];
//        _textField.delegate = self;
//        _textField.returnKeyType = UIReturnKeyDone;
//    }
//    return _textField;
//}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(spaceMargin, 0, SCREEN_WIDTH - spaceMargin * 2, normalCellH)];
        _textField.placeholder = @"";
        _textField.font = [UIFont systemFontOfSize:DEFAULT_FONTSIZE];
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeyDone;
    }
    return _textField;
}
- (UIButton*)leftBarBtn{
    if (!_leftBarBtn) {
        _leftBarBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _leftBarBtn.frame = CGRectMake(0, 0, 40, 30);
        _leftBarBtn.backgroundColor = [UIColor clearColor];
        [_leftBarBtn setTitle:@"取消" forState:UIControlStateNormal];
        _leftBarBtn.titleLabel.textColor = [UIColor blackColor];
        [_leftBarBtn addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBarBtn;
}
- (void)leftClick:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIButton*)rightBarBtn{
    if (!_rightBarBtn) {
        _rightBarBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _rightBarBtn.frame = CGRectMake(0, 0, 40, 30);
        [_rightBarBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_rightBarBtn setTitleColor:ColorWithRGB(189, 238, 213, 1) forState:UIControlStateNormal];
        _rightBarBtn.enabled = NO;
        _rightBarBtn.backgroundColor = ColorWithRGB(156, 230, 190, 1);
        _rightBarBtn.layer.masksToBounds = YES;
        _rightBarBtn.layer.cornerRadius = 5;
        [_rightBarBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _rightBarBtn;
}
- (void)rightClick:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

// 文字发生改变时调用

-(void)textChange{
    NSLog(@"textchange");
    if (self.textField.text.length == 0) {
        //        [XZJFactoryFunc createModeTextProgressHUDInParentView:self.view andLabelText:[NSString stringWithFormat:@"%@不能为空",self.title] delayTime:progressHUDShowTime];
        MBProgressHUD * progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progressHUD.mode = MBProgressHUDModeText;
        progressHUD.labelText = [NSString stringWithFormat:@"%@不能为空",self.title];
        [progressHUD hide:YES afterDelay:0.8];
    }else{
        self.rightBarBtn.enabled = YES;
        _rightBarBtn.backgroundColor = ColorWithRGB(45, 193, 96, 1);
        _rightBarBtn.titleLabel.textColor = [UIColor whiteColor];
        self.block(self.textField.text);
    }

}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end
