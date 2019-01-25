//
//  FactryFucClass.h
//  WeiLiDai
//
//  Created by j on 2018/3/1.
//  Copyright © 2018年 j. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^doneBlock)(UIAlertAction * _Nonnull action);
typedef void (^cancelBlock)(UIAlertAction * _Nonnull action);
typedef void (^doneBlockWithTextFelds)(UIAlertAction * _Nonnull action,NSArray<UITextField *> * _Nullable textFields);
@interface FactryFucClass : NSObject

+ (UIImage * _Nullable)imageWithColor:(UIColor * _Nullable)color;

/**
 *创建button，无背景图片
 */
+ (UIButton * _Nullable)createButtonWithFrame:(CGRect )frame
                              backgroundColor:(UIColor * _Nullable)color
                                     setTitle:(NSString * _Nullable)title
                                setTitleColor:(UIColor * _Nullable)titleColor
                            andTitleLabelFont:(UIFont *_Nullable)titleLabelFont
                                    addTarget:(nullable id)target
                                       action:(nullable SEL)action
                             forControlEvents:(UIControlEvents)controlEvent;

/**
 *创建button，有背景图片,无字体
 */
+ (UIButton * _Nullable)createButtonWithFrame:(CGRect )frame
                           setBackgroundImage:(UIImage * _Nullable)image
                                    addTarget:(nullable id)target
                                       action:(nullable SEL)action
                             forControlEvents:(UIControlEvents)controlEvents;


/**
 *创建button，有背景图片,有标题
 */
+ (UIButton * _Nullable)createButtonWithFrame:(CGRect)frame
                           setBackgroundImage:(UIImage * _Nullable)image
                                     setTitle:(NSString * _Nullable)title
                                setTitleColor:(UIColor * _Nullable)titleColor
                            andTitleLabelFont:(UIFont *_Nullable)titleLabelFont
                                    addTarget:(nullable id)target
                                       action:(nullable SEL)action
                             forControlEvents:(UIControlEvents)controlEvents;

+(UIAlertController * _Nullable )showDoubleBtnWithTextFieldAlertControllerWithTitle:(NSString * _Nullable )title
                                                                            Message:(NSString * _Nullable )message
                                                                       doneBtnTitle:(NSString * _Nullable)doneBtnTitle
                                                                     cancelBtnTitle:(NSString * _Nullable)cancelBtnTitle
                                                                      textFieldText:(NSString * _Nullable)textFieldText
                                                              textFieldKeyboardType:(UIKeyboardType)keyboardType
                                                                       andDoneBlock:(_Nullable doneBlockWithTextFelds)doneBlock
                                                                     andCancelBlock:(_Nullable cancelBlock)cancelBlock;

/**
 创建文本提示的MBProgressHUD
 */
+(void)createModeTextProgressHUDInParentView:(UIView *_Nullable)view
                                andLabelText:(NSString * _Nullable)text
                                   delayTime:(CGFloat)delayTime;

/**
 创建默认旋转菊花的MBProgressHUD
 
 @param view 添加到的视图
 @return progressHUD
 */
+(MBProgressHUD *)createDefaultProgressHUDInParentView:(UIView *)view;

+(void)setNavigationTintColorWithBlack:(BOOL)isBlack;

/**
 创建label,可设置字体大小
 */
+ (UILabel * _Nullable)createLabelWithFrame:(CGRect)frame
                                       text:(NSString * _Nullable)text
                                  textColor:(UIColor * _Nullable)textColor
                                   fontSize:(CGFloat)textFontSize
                              textAlignment:(NSTextAlignment)textAlignment
                              numberOfLines:(NSInteger)numberOfLines;

/**
 *创建imageView,使用图片名
 */
+ (UIImageView * _Nullable)createImageViewWithFrame:(CGRect)frame imageName:(NSString * _Nullable)imageName contentMode:(UIViewContentMode)contentMode;



@end
