
//
//  FactryFucClass.m
//  WeiLiDai
//
//  Created by j on 2018/3/1.
//  Copyright © 2018年 j. All rights reserved.
//

#import "FactryFucClass.h"

@implementation FactryFucClass

//颜色转换图片
+ (UIImage * _Nullable)imageWithColor:(UIColor * _Nullable)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *创建button，无背景图片
 */
+ (UIButton * _Nullable)createButtonWithFrame:(CGRect )frame
                              backgroundColor:(UIColor * _Nullable)color
                                     setTitle:(NSString * _Nullable)title
                                setTitleColor:(UIColor * _Nullable)titleColor
                            andTitleLabelFont:(UIFont *)titleLabelFont
                                    addTarget:(nullable id)target
                                       action:(nullable SEL)action
                             forControlEvents:(UIControlEvents)controlEvents{
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleLabelFont) {
        button.titleLabel.font = titleLabelFont;
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (color) {
        button.backgroundColor = color;
    }
    
    [button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    
    return button;
}

/**
 *创建button，有背景图片,无字体
 */
+ (UIButton * _Nullable)createButtonWithFrame:(CGRect )frame
                           setBackgroundImage:(UIImage * _Nullable)image
                                    addTarget:(nullable id)target
                                       action:(nullable SEL)action
                             forControlEvents:(UIControlEvents)controlEvents{
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
    
    if (image) {
        [button setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    if (target && action && controlEvents) {
        [button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    }
    
    
    return button;
}

/**
 *创建button，有背景图片,有标题
 */
+ (UIButton * _Nullable)createButtonWithFrame:(CGRect)frame
                           setBackgroundImage:(UIImage * _Nullable)image
                                     setTitle:(NSString * _Nullable)title
                                setTitleColor:(UIColor * _Nullable)titleColor
                            andTitleLabelFont:(UIFont *)titleLabelFont
                                    addTarget:(nullable id)target
                                       action:(nullable SEL)action
                             forControlEvents:(UIControlEvents)controlEvents{
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (image) {
        [button setBackgroundImage:image forState:UIControlStateNormal];
    }
    if (titleLabelFont) {
        button.titleLabel.font = titleLabelFont;
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    
    [button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    
    return button;
    
}

+(UIAlertController * _Nullable )showDoubleBtnWithTextFieldAlertControllerWithTitle:(NSString * _Nullable )title
                                                                            Message:(NSString * _Nullable )message
                                                                       doneBtnTitle:(NSString * _Nullable)doneBtnTitle
                                                                     cancelBtnTitle:(NSString * _Nullable)cancelBtnTitle
                                                                      textFieldText:(NSString * _Nullable)textFieldText
                                                              textFieldKeyboardType:(UIKeyboardType)keyboardType
                                                                       andDoneBlock:(_Nullable doneBlockWithTextFelds)doneBlock
                                                                     andCancelBlock:(_Nullable cancelBlock)cancelBlock{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    NSString * cancelTitle = @"取消";
    if (cancelBtnTitle) {
        cancelTitle = cancelBtnTitle;
    }
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (action) {
            cancelBlock(action);
        }
        
    }];
    NSString * doneTitle = @"确定";
    if (doneBtnTitle) {
        doneTitle = doneBtnTitle;
    }
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:doneTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (action) {
            doneBlock(action,alert.textFields);
        }
        
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    
    UITextField * textfield = [alert.textFields firstObject];
    textfield.keyboardType = keyboardType;
    if (textFieldText.length>0) {
        textfield.text = textFieldText;
    }
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    return alert;
    
}

/**
 创建文本提示的MBProgressHUD
 */
+(void)createModeTextProgressHUDInParentView:(UIView *_Nullable)view
                                andLabelText:(NSString * _Nullable)text
                                   delayTime:(CGFloat)delayTime{
    MBProgressHUD * progressHUD = [FactryFucClass createDefaultProgressHUDInParentView:view];
    if (progressHUD) {
        progressHUD.mode = MBProgressHUDModeText;
        if (text.length>0) {
            progressHUD.labelText = text;
        }
        [progressHUD hide:YES afterDelay:delayTime];
    }
}

/**
 创建默认旋转菊花的MBProgressHUD
 
 @param view 添加到的视图
 @return progressHUD
 */
+(MBProgressHUD *)createDefaultProgressHUDInParentView:(UIView *)view{
    if (view) {
        MBProgressHUD * progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        progressHUD.mode = MBProgressHUDModeIndeterminate;
        return progressHUD;
    }
    return nil;
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

/**
 创建label,可设置字体大小
 */
+ (UILabel * _Nullable)createLabelWithFrame:(CGRect)frame
                                       text:(NSString * _Nullable)text
                                  textColor:(UIColor * _Nullable)textColor
                                   fontSize:(CGFloat)textFontSize
                              textAlignment:(NSTextAlignment)textAlignment
                              numberOfLines:(NSInteger)numberOfLines{
    UILabel * label = [[UILabel alloc] init];
    label.frame = frame;
    if (text) {
        label.text = text;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    if (textFontSize > 0) {
        label.font = [UIFont systemFontOfSize:textFontSize];
    }
    if (textAlignment) {
        label.textAlignment = textAlignment;
    }
    label.numberOfLines = numberOfLines;
    
    return label;
}

/**
 *创建imageView,使用图片名
 */
+ (UIImageView * _Nullable)createImageViewWithFrame:(CGRect)frame imageName:(NSString * _Nullable)imageName contentMode:(UIViewContentMode)contentMode{
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = frame;
    imageView.contentMode = contentMode;
    imageView.layer.masksToBounds = YES;
    return imageView;
}


@end
