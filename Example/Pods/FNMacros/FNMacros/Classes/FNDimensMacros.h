//
//  FNDimensMacros.h
//  FNYunWei
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#ifndef FNDimensMacros_h
#define FNDimensMacros_h

/**
 *  获取屏幕尺寸、宽度、高度
 */
#define kScreenRect                 ([[UIScreen mainScreen] bounds])            //屏幕frame
#define kScreenSize                 ([UIScreen mainScreen].bounds.size)         //屏幕size
#define kScreenWidth                ([UIScreen mainScreen].bounds.size.width)   //屏幕宽度
#define kScreenHeight               ([UIScreen mainScreen].bounds.size.height)  //屏幕高度

/**
 *  不同尺寸手机真实宽度、高度（以6s为基准）
 */
#define kRealWidth(value)           (((value)/375.0f) * kScreenWidth)
#define kRealHeight(value)          (((value)/667.0f) * kScreenHeight)

#define FNPixelToX(value)          (((value)/375.0f) * kScreenWidth)
#define FNPixelToY(value)          (((value)/667.0f) * kScreenHeight)

#define FNPixelToMultipleX(value)          (((value)/750.0f) * kScreenWidth)
#define FNPixelToMultipleY(value)          (((value)/1334.0f) * kScreenHeight)

/**
 *  获取屏幕最大最小
 */
#define kScreenMaxLength            (MAX(kScreenWidth, kScreenHeight))          //获取屏幕宽高最大者
#define kScreenMinLength            (MIN(kScreenWidth, kScreenHeight))          //获取屏幕宽高最小者

/**
 *  缩放系数和屏幕分辨率
 */
//#define kScreenScale                ([[UIScreen mainScreen] scale])                 //缩放系数
#define kScreenResolution           (kScreenWidth * kScreenHeight * kScreenScale)   //屏幕分辨率

/**
 *  当前设备的size
 *  iPhone (3.5 inch): 320 x 480
 *  iPhone Retina (3.5 inch): 640 x 960
 *  iPhone Retina (4.0 inch): 640 x 1136
 *  iPad: 768 x 1024
 *  iPad Retina: 1536 x 2048
 */
#define kScreenCurrModeSize         [[UIScreen mainScreen] currentMode].size    //currentModel的size


/**
 *  控件高度
 */

//判断是否iPhone X

#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// status bar height.
#define  kStatusBarHeight      (IS_iPhoneX ? 44.f : 20.f)

// Navigation bar height.
#define  kNavigationBarHeight  44.f

// Tabbar height.
#define  kTabbarHeight         (IS_iPhoneX ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define  kTabbarSafeBottomMargin         (IS_iPhoneX ? 34.f : 0.f)

// Status bar & navigation bar height.
#define  kStatusBarAndNavigationBarHeight  (IS_iPhoneX ? 88.f : 64.f)

// Status bar & navigation bar height.
#define  kExceedStatusBarHeight  (IS_iPhoneX ? 24 : 0)

#define kkeyBoardHeight             kRealHeight(258)                            //键盘高度
#define kStatusAndNavigationHeight  (kStatusBarHeight + kNavigationBarHeight)     //状态栏+导航栏 高度
#define kContentHeight              (kScreenHeight - kStatusAndNavigationHeight)  //减去状态栏和导航栏的高度
#define kContentHeightRidKeyboard   (kScreenHeight - kStatusAndNavigationHeight -kkeyBoardHeight)//除取键盘的高度
#define kContentRidTabBarHeight     (kScreenHeight - kStatusAndNavigationHeight - kTabbarHeight)



#endif /* FNDimensMacros_h */
