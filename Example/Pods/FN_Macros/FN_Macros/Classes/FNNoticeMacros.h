//
//  FNNoticeMacros.h
//  FNYunWei
//
//  Created by qunye zhu on 2018/3/30.
//  Copyright © 2018年 qunye zhu. All rights reserved.
//

#ifndef FNNoticeMacros_h
#define FNNoticeMacros_h

/** 跟新用户数据 */
static NSString *const kRenewUserNotification = @"RenewUserNotification";
/**  用户登录成功  */
static NSString *const kLoginSuccessNotification = @"LoginSuccessNotification";

/** 反馈字段 */
static NSString *const kCanRebackNotification = @"kCanRebackNotification";

/** 存储字段 */
static NSString *const kDeviceTokenValue = @"kdeviceTokenValue";

/** 网络状态改变 */
static NSString *const kReachabilityStatusChange = @"kReachabilityStatusChange";

/** 存储字段 */
static NSString *const kDetailPickerDidSelectIndex = @"kDetailPickerDidSelectIndex";

/** App切换到前台 */
static NSString *const kApplicationDidBecomeActive = @"kApplicationDidBecomeActive";
/** App切换到后台 */
static NSString *const kApplicationWillResignActive = @"kApplicationWillResignActive";

#endif /* FNNoticeMacros_h */
