//
//  FNProgressHUD.h
//  FNYunYing
//
//  Created by 毕杰涛 on 2018/5/10.
//  Copyright © 2018年 bijietao. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSUInteger, HUDMaskType) {
    /** 用户仍然可以做其他操作*/
    HUDMaskTypeNone,
    /** 用用户不可以做其他操作*/
    HUDMaskTypeClear,
};

@interface FNProgressHUD : MBProgressHUD

/**
 window菊花加载

 @param maskType 设置样式
 @return FNProgressHUD
 */
+ (instancetype)showLoadingWithMaskType:(HUDMaskType)maskType;

/**
 固定视图提示加载
 @param view 所在视图
 @param maskType 样式
 @return FNProgressHUD
 */
+ (instancetype)showLoadingToView:(UIView *)view maskType:(HUDMaskType)maskType;

/**
 文字提示加载

 @param text 提示文字
 @param view 所在视图
 @param maskType 样式
 @return FNProgressHUD
 */
+ (instancetype)showLoadingWithText:(NSString *)text toView:(UIView *)view maskType:(HUDMaskType)maskType;

/**
 一句话文案提示，自动消失

 @param text 提示文字
 @param view 所在视图
 */
+ (void)showMessageWithText:(NSString *)text toView:(UIView *)view;

/**
 info文案提示，自动消失

 @param text 文字内容
 @param view 所在视图
 */
+ (void)showInfoWithText:(NSString *)text toView:(UIView *)view;

/**
 成功文案提示，自动消失

 @param text 文字内容
 @param view 所在视图
 */
+ (void)showSuccessWithText:(NSString *)text toView:(UIView *)view;

/**
  失败文案提示，自动消失

 @param text 文字内容
 @param view 所在视图
 */
+ (void)showErrorWithText:(NSString *)text toView:(UIView *)view;

/**
 隐藏方法与
 */
+ (void)dismiss;

/**
 固定视图隐藏提示框

 @param view 所在视图
 */
+ (void)dismissForView:(UIView *)view;

@end
