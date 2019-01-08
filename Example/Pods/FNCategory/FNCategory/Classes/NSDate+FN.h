//
//  NSDate+FN.h
//  FNYunYing
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (FN)

/**
 本地时间

 @return 本地时间字符串 YYYY-MM-dd
 */
+ (NSString *)localeDate;

/**
 date转字符串

 @param date date
 @return NSString格式yyyy-MM-dd
 */
+ (NSString *)stringFromDate:(NSDate *)date;

/*
 *  x分前 x小时前 x天前
 */
+ (NSString *)returnNomalTimeWith: (NSString *) latestr;



/**
 获取几天前

 @param date 需要修改的时间
 @param day 几天前
 @return 转换完的日期
 */
+ (NSDate *)getLaterDateFromDate:(NSDate *)date day:(NSInteger)day;

/**
 获取几月前

 @param date 需要修改的时间
 @param month 月
 @param day 日
 @return 转换完的日期
 */
+ (NSDate *)getLaterDateFromDate:(NSDate *)date month:(NSInteger)month day:(NSInteger)day;

/**
 获取几年前

 @param date 需要修改的时间
 @param year 年
 @param month 月
 @param day 日
 @return 转换完的日期
 */
+ (NSDate *)getLaterDateFromDate:(NSDate *)date withYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;


- (NSString *) stringWithFormat:(NSString *)format;
+ (NSDate *) dateFromString:(NSString *)string
                 withFormat:(NSString *)format;
+ (NSDate *)dateFromUtcStr:(NSString *)string
                withFormat:(NSString *)format;

- (NSString *)defaultStringDescription;
- (NSString *)ymdStringDescription;
- (NSString *)ymStringDescription;
- (NSTimeInterval) timeDifferenceBetween: (NSDate *)date;


- (NSString *)getUTCFormateLocalDate:(NSString *)localDate;
- (NSString *)utcStringWithFormat:(NSString *)format;

// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithSecondsFromNow: (NSInteger) dSeconds;
+ (NSDate *) dateWithSecondsBeforeNow: (NSInteger) dSeconds;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isThisYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;
- (BOOL) isBeforeDays:(NSInteger)days; //判断当前时间是否是几天之前

// Adjusting dates
- (NSDate *) dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *) dataByAddingMonths: (NSInteger) dMonths;
- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateAtStartOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;


// Decomposing dates
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

- (NSInteger)secondsWithTime;
- (NSString *)timeSp;
+ (NSString *)currentTimeStamp;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;
@end
