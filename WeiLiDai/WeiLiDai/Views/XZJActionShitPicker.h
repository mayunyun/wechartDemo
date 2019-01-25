//
//  XZJActionShitPicker.h
//  WeiLiDai
//
//  Created by iMac on 2018/3/5.
//  Copyright © 2018年 j. All rights reserved.
//

#import "AbstractActionSheetPicker.h"

@class XZJActionShitPicker;
typedef void(^XZJActionStringDoneBlock)(XZJActionShitPicker *picker, NSInteger selectedIndex, id selectedValue);
typedef void(^XZJActionStringCancelBlock)(XZJActionShitPicker *picker);

@interface XZJActionShitPicker : AbstractActionSheetPicker<UIPickerViewDelegate, UIPickerViewDataSource>

+ (instancetype)showPickerWithTitle:(NSString *)title rows:(NSArray *)data initialSelection:(NSInteger)index target:(id)target successAction:(SEL)successAction cancelAction:(SEL)cancelActionOrNil origin:(id)origin;

// Create an action sheet picker, but don't display until a subsequent call to "showActionPicker".  Receiver must release the picker when ready. */
- (instancetype)initWithTitle:(NSString *)title rows:(NSArray *)data initialSelection:(NSInteger)index target:(id)target successAction:(SEL)successAction cancelAction:(SEL)cancelActionOrNil origin:(id)origin;



+ (instancetype)showPickerWithTitle:(NSString *)title rows:(NSArray *)strings initialSelection:(NSInteger)index doneBlock:(XZJActionStringDoneBlock)doneBlock cancelBlock:(XZJActionStringCancelBlock)cancelBlock origin:(id)origin;

- (instancetype)initWithTitle:(NSString *)title rows:(NSArray *)strings initialSelection:(NSInteger)index doneBlock:(XZJActionStringDoneBlock)doneBlock cancelBlock:(XZJActionStringCancelBlock)cancelBlockOrNil origin:(id)origin;

@property (nonatomic, copy) XZJActionStringDoneBlock onActionSheetDone;
@property (nonatomic, copy) XZJActionStringCancelBlock onActionSheetCancel;

@end
