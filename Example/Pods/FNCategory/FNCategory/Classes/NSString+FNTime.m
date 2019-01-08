//
//  NSString+FNTime.m
//  FNYunYing
//
//  Created by 毕杰涛 on 2018/4/13.
//  Copyright © 2018年 毕杰涛. All rights reserved.
//

#import "NSString+FNTime.h"

@implementation NSString (FNTime)

+ (NSString *)getNowDateStringWithDateFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:[NSDate date]];
}


+ (NSString *)intervalSinceNow:(NSString *)theDate
{
    
    //计算上报时间差
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    //设置一个字符串的时间
    NSMutableString *datestring = [NSMutableString stringWithFormat:@"%@",theDate];
    //注意 如果20141202052740必须是数字，如果是UNIX时间，不需要下面的插入字符串。
    //    [datestring insertString:@"-" atIndex:4];
    //    [datestring insertString:@"-" atIndex:7];
    //    [datestring insertString:@" " atIndex:10];
    //    [datestring insertString:@":" atIndex:13];
    //    [datestring insertString:@":" atIndex:16];
    NSLog(@"datestring==%@",datestring);
    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [dm setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate * newdate = [dm dateFromString:datestring];
    long dd = (long)[datenow timeIntervalSince1970] - [newdate timeIntervalSince1970];
    NSString *timeString=@"";
    if (dd/3600<1) {
        timeString = [NSString stringWithFormat:@"%ld", dd/60];
        timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
        if (dd/60<2) {
            timeString = [NSString stringWithFormat:@"刚刚"];
        }
    }
    if (dd/3600>=1&&dd/86400<1)
    {
        timeString = [NSString stringWithFormat:@"%ld", dd/3600];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (dd/86400 >= 1 && dd/86400 <= 3) {
        // 如果大于24小时就显示几天前:最多显示2天前
        timeString = [NSString stringWithFormat:@"%ld", dd/86400];
        timeString = [NSString stringWithFormat:@"%@天前", timeString];
    } else {
        // 如果大于24小时就显示具体的日期
        if (theDate.length > 12) {
            timeString = [theDate substringToIndex:10];
        } else {
            timeString = theDate;
        }
    }
    NSLog(@"=====%@",timeString);
    
    return timeString;
}

+ (NSInteger)getNowYearOrMonth:(int)type
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *component = [calendar components:unitFlags fromDate:[NSDate date]];
    if (type == 1)
        return component.year;
    else if (type == 2)
        return component.month;
    return 0;
}


+ (NSString *)replaceOldStr:(NSString *)stringToBeChanged withStr:(NSString *)stringToBeChangedWith withString:(NSString *)oldStr{
    
    NSString *newStr = [oldStr stringByReplacingOccurrencesOfString:stringToBeChanged withString:stringToBeChangedWith];
    return newStr;
}

+ (NSInteger)getMonthWithRegDate:(NSString *)regStr{
    
    NSString *regDateStr = regStr;
    if ([regStr rangeOfString:@"/"].location !=  NSNotFound) {
        regDateStr = [self replaceOldStr:@"/" withStr:@"-" withString:regStr];
        
    }
    else if ([regStr rangeOfString:@"年"].location != NSNotFound){
        regDateStr = [self replaceOldStr:@"年" withStr:@"-" withString:regStr];
        regDateStr = [self replaceOldStr:@"月" withStr:@"" withString:regDateStr];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *todayDate = [NSDate date];
    NSString *nowDate=[dateFormatter stringFromDate:todayDate];
    
    NSInteger nowYear = [[nowDate componentsSeparatedByString:@"-"].firstObject integerValue];
    NSInteger nowMonth = [[nowDate componentsSeparatedByString:@"-"].lastObject integerValue];
    
    NSArray *array = [regDateStr componentsSeparatedByString:@"-"];
    NSInteger regYear = 0;
    NSInteger regMonth = 0;
    NSInteger months = 0;
    if (array.count >= 2) {
        regYear = [[array firstObject] integerValue];
        regMonth = [[array objectAtIndex:1] integerValue];
        months = (nowYear - regYear) * 12;
        months += ((nowMonth - regMonth));
    }else{
        return 0;
    }
    
    return months;
    
}
@end
