//
//  FNDeviceMacros.h
//  FNYunWei
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#ifndef FNDeviceMacros_h
#define FNDeviceMacros_h

/**
 头文件说明：
 1、与设备有关的宏定义
 */

#pragma mark - *************************  硬件相关  *************************
//Retina分辨率
#define kIsRetina [[UIScreen mainScreen] scale] == 2.f

//ISRETINA
#define kCuttingLineHeight (kIsRetina ? 0.5 : 0.34)

//px To CGRect
#define FNPixelToSize(px)    ((px)/2.0)

#pragma mark - *************************  系统相关  *************************
//delegate对象//AppWindow
//获取系统对象
#define kApplication                 [UIApplication sharedApplication]
#define kAppWindow                   [UIApplication sharedApplication].delegate.window
#define kAppDelegate                 [AppDelegate shareAppDelegate]
#define kRootViewController          [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults                [NSUserDefaults standardUserDefaults]
#define kNotificationCenter          [NSNotificationCenter defaultCenter]

#pragma mark - 获取系统版本 字符串和浮点型

#define     kSystemVersion         ([UIDevice currentDevice].systemVersion.doubleValue)

/** 最低系统为iOS6、7、8、9、10、11系统 */
#define iOS6                    ((kSystemVersion >= 6.0) ? YES : NO)
#define iOS7                    ((kSystemVersion >= 7.0) ? YES : NO)
#define iOS8                    ((kSystemVersion >= 8.0) ? YES : NO)
#define iOS9                    ((kSystemVersion >= 9.0) ? YES : NO)
#define iOS10                   ((kSystemVersion >= 10.0) ? YES : NO)
#define iOS11                   ((kSystemVersion >= 11.0) ? YES : NO)



#pragma mark - **************************  通用设置宏定义  *********************************

/****************************    屏幕相关宏    ****************************/
/** 区分iPhone4s、iPhone5、iPhone5s、iPhone6、iPhone6Plus和放大模式
 *  设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x
 */
//是否是垂直
#define isPortrait                  ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)

//UIScreen是否响应currentMode方法
#define     isRespondCurrModel          [UIScreen instancesRespondToSelector:@selector(currentMode)]
#define     isEqualToCurrModelSize(w,h) CGSizeEqualToSize(CGSizeMake(w,h), kScreenCurrModeSize)

/**
 *  设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x
 */
#define     iPhone4                     (isRespondCurrModel ? isEqualToCurrModelSize(640,960) : NO)

/**
 *  设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x
 */
#define     iPhone5                     (isRespondCurrModel ? isEqualToCurrModelSize(640,1136) : NO)

/**
 *  设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x
 */
#define     iPhone6                     (isRespondCurrModel ? isEqualToCurrModelSize(750, 1334) || isEqualToCurrModelSize(640, 1136) : NO)

/**
 *  设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x
 */
#define     iPhone6Plus                 (isRespondCurrModel ? isEqualToCurrModelSize(1125, 2001) || isEqualToCurrModelSize(1242, 2208) : NO)
/**
 *  设备是否为iPhone X 分辨率375x812，像素1125x2436，@3x
 */
#define     iPhoneX                     (isRespondCurrModel ? isEqualToCurrModelSize(1125, 2436) : NO)

/**
 *  放大模式
 */
#define     iPhone6PlusZoom             (isRespondCurrModel ? isEqualToCurrModelSize(1125, 2001) : NO)

/**
 *  设备是否是iPad
 */
#define     isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define     isIPad                      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)    //是否是ipad设备
#define     isIPhone                    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)  //是否是iPhone设备
#define     isRetina                    (kScreenScale >= 2.0)

#endif /* FNDeviceMacros_h */
