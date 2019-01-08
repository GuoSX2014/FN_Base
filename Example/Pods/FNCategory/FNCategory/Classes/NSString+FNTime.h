//
//  NSString+FNTime.h
//  FNYunYing
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FNTime)
/**
 *  获取当前日期字符串
 *
 *  @param format 格式化字符串
 */
+ (NSString *)getNowDateStringWithDateFormat:(NSString *)format;

/**
 *  获取当前的年/月
 *
 *  @param type 1:年 2:月
 */
+ (NSInteger)getNowYearOrMonth:(int)type;

/**
 *  获取当前的年/月
 *
 *  @param regStr 注册时间
 */
+ (NSInteger)getMonthWithRegDate:(NSString *)regStr;

/*
 * 时间转换 分钟、小时、天前
 */
+ (NSString *)intervalSinceNow:(NSString *)theDate;
@end
