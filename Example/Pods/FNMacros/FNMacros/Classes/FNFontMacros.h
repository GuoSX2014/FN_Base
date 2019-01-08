//
//  FNFontMacros.h
//  FNYunWei
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#ifndef FNFontMacros_h
#define FNFontMacros_h

/**
 *  不同尺寸手机真实宽度、高度（以6s为基准）
 */
#define kRealFontSize(a)           (((a)/375.0f) * ([UIScreen mainScreen].bounds.size.width))

//系统字体
#define BOLDSYSTEM_FONT(fontSize) [UIFont boldSystemFontOfSize:kRealFontSize(fontSize)]
#define SYSTEM_FONT(fontSize) [UIFont systemFontOfSize:kRealFontSize(fontSize)]

/**
 *  苹方
 */
#define FontPingFangRegular (([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) ? @"Helvetica" : @"PingFangSC-Regular" )
#define FontPingFangMedium (([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) ? @"Helvetica" : @"PingFangSC-Medium" )
#define PingFangRegularFontSize(fontSize) [UIFont fontWithName:FontPingFangRegular size:(kRealFontSize(fontSize))]
#define PingFangMediumFontSize(fontSize) [UIFont fontWithName:FontPingFangMedium size:(kRealFontSize(fontSize))]

#endif /* FNFontMacros_h */
