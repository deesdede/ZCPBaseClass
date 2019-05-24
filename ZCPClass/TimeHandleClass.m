//
//  TimeHandleClass.m
//  shanglv51
//
//  Created by iosyf－03 on 2017/9/20.
//  Copyright © 2017年 shanglv. All rights reserved.
//

#import "TimeHandleClass.h"

@implementation TimeHandleClass

#pragma mark -- 获取当前日期

/**
 获取当前日期

 @param showHHmmss 是否需要时分秒
 @return YYYY-MM-dd OR XXXX-XX-XX HH-mm-dd
 */
+ (NSString *)nowDateWithType:(BOOL)showHHmmss {
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (showHHmmss) {
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }else {
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    }
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    return dateString;
}

#pragma mark -- 计算两日期的差值
/**
 计算两日期的差值

 @param startTime 起始时间
 @param endTime 结束时间
 @return 返回差值天数
 */
+ (NSInteger)dateTimeDifferenceDayWithStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd";
    // 当前时间字符串格式
    NSDate *nowDate = [dateFomatter dateFromString:[startTime substringToIndex:10]];
    // 截止时间data格式
    NSDate *expireDate = [dateFomatter dateFromString:[endTime substringToIndex:10]];
    
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:NSCalendarUnitDay fromDate:nowDate toDate:expireDate options:0];
    
    return dateCom.day;
}

/**
 计算当前日期到指定日期的秒数
 
 @param endTime 指定时间
 @return 相差秒数
 */
+ (NSInteger)dateTimeDifferenceDayWithEndTime:(NSString *)endTime {
    
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 当前时间字符串格式
    NSDate *nowDate = [dateFomatter dateFromString:[self nowDateWithType:YES]];
    // 截止时间data格式
    NSDate *expireDate = [dateFomatter dateFromString:endTime];
    
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:NSCalendarUnitSecond fromDate:nowDate toDate:expireDate options:0];
    
    return dateCom.second;
}

#pragma mark -- 获取星期
/**
 获取星期

 @param date 时间戳 YYYY-MM-dd
 @param type 需要的星期格式 YES:周几 NO:星期几
 @return 周三 Or 星期三
 */
+ (NSString *)currentWeek:(NSString *)date type:(BOOL)type {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitWeekday;
    comps = [calendar components:unitFlags fromDate:[self stringToDate:date]];
    
    NSString *week = @"";
    if (type) {
        switch (comps.weekday) {
            case 1:week = @"周日";break;
            case 2:week = @"周一";break;
            case 3:week = @"周二";break;
            case 4:week = @"周三";break;
            case 5:week = @"周四";break;
            case 6:week = @"周五";break;
            case 7:week = @"周六";break;
            default:break;
        }
    }else {
        switch (comps.weekday) {
            case 1:week = @"星期天";break;
            case 2:week = @"星期一";break;
            case 3:week = @"星期二";break;
            case 4:week = @"星期三";break;
            case 5:week = @"星期四";break;
            case 6:week = @"星期五";break;
            case 7:week = @"星期六";break;
            default:break;
        }
    }
    
    return week;
}
#pragma mark -- String转NSDate
/**
 String转NSDate

 @param string YYYY-MM-dd
 @return NSDate
 */
+ (NSDate *)stringToDate:(NSString *)string {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:string];
    
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    
    return destinationDateNow;
}
#pragma mark -- Date转String
/**
 Date转String

 @param date NSDate
 @return yyyy-MM-dd
 */
+ (NSString *)dateToString:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    return strDate;
}
#pragma mark -- 此月共有几天
/**
 此月共有几天

 @param dateString YYYY-MM-dd
 @return 天数
 */
+ (NSInteger)totaldaysInMonth:(NSString *)dateString {
    
    NSDate *date = [self stringToDate:dateString];
    //返回某个特定时间(date)其对应的小的时间单元(smaller)在大的时间单元(larger)中的范围
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

/**
 计算年龄

 @param aBirthDay 生日:yyyy-MM-dd
 @return 年龄
 */
+ (NSInteger)birthDateToAge:(NSString *)aBirthDay {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    
    NSDate *nowDate = [NSDate date];
    
    NSString *birth = aBirthDay;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:birth];
    
    //用来得到详细的时差
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *date = [calendar components:unitFlags fromDate:birthDay toDate:nowDate options:0];
    
    return [date year];
}

#pragma mark -- 计算X天后的日期
/**
 计算X天后的日期

 @param nowDateString yyyy-MM-dd
 @param aDay 多少天后
 @return yyyy-MM-dd
 */
+ (NSString *)distanceDate:(NSString *)nowDateString aDay:(NSInteger)aDay {
    
    NSDate *date = [self stringToDate:nowDateString];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    comp.day = aDay;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:date options:0];
    
    return [self dateToString:newDate];
}
#pragma mark -- 身份证中获取出生日期
/**
 身份证中获取出生日期

 @param numberStr 身份证号
 @return 生日yyyy-MM-dd
 */
+ (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr {
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<14)
        return result;
    
    //**截取前14位
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 13)];
    
    //**检测前14位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)
        return result;
    
    year = [numberStr substringWithRange:NSMakeRange(6, 4)];
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    return result;
}

#pragma mark -- 日期转化为MM月dd日的格式
/**
 日期转化为mm月dd日的格式
 
 @param dateString 时间戳
 @return mm月dd日
 */
+ (NSString *)stringWithDateString:(NSString *)dateString {
    
    return  [NSString stringWithFormat:@"%@月%@日",[dateString substringWithRange:NSMakeRange(5, 2)],[dateString substringWithRange:NSMakeRange(8, 2)]];
}
#pragma mark -- 处理后台返回时间格式
/**
 处理后台返回时间格式(去掉T)

 @param timeString 后台返回时间
 @return 去掉t后的时间
 */
+ (NSString *)strintWithTimeString:(NSString *)timeString {
    NSString *stringOne = [timeString substringWithRange:NSMakeRange(0, 10)];
    NSString *stringTwo = [timeString substringWithRange:NSMakeRange(11, 8)];
    return [NSString stringWithFormat:@"%@ %@",stringOne,stringTwo];
}

#pragma mark -- 计算当前时间是否在某个时间段内

/**
 计算当前时间是否在某个时间段内

 @param startTime 起始时间
 @param endTime 结束时间
 @return 是否在这个时间段内
 */
+ (BOOL)currentDateIsBetweenZeroAndSixWithStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    NSString *zero = [NSString stringWithFormat:@"%@ %@", [self currentDateWithReverse:NO], startTime];
    NSString *six  = [NSString stringWithFormat:@"%@ %@", [self currentDateWithReverse:NO], endTime];
    
    if ([self compareOneDay:[self stringToDateMinAndSecond:dateString] withAnotherDay:[self stringToDateMinAndSecond:zero]] == 1 && [self compareOneDay:[self stringToDateMinAndSecond:dateString] withAnotherDay:[self stringToDateMinAndSecond:six]] == -1) {
        //不在时间段
        return YES;
    }
    return NO;
}

#pragma mark -- 分钟转化成小时分钟
/**
 分钟-小时：分钟

 @param min 传入分钟
 @param dateType 显示格式:h/小时
 @return 结果
 */
+ (NSString *)dateChangeWithMin:(NSString *)min dateType:(NSString *)dateType {
    
    NSInteger second = [min integerValue] * 60;
    NSInteger minutes = (second / 60) % 60;
    NSInteger hours = second / 3600;
    
    if ([dateType isEqualToString:@"时分"]) {
        return [NSString stringWithFormat:@"%ld时%ld分",(long)hours, (long)minutes];
    }else if ([dateType isEqualToString:@"hmin"]) {
        return [NSString stringWithFormat:@"%ldh%ldmin",(long)hours, (long)minutes];
    }else {
        
        NSString *hoursStr = @"";
        NSString *minutesStr = @"";
        if ([[NSString stringWithFormat:@"%ld", (long)minutes] length] == 1) {
            minutesStr = [NSString stringWithFormat:@"0%ld", (long)minutes];
        }else {
            minutesStr = [NSString stringWithFormat:@"%ld", (long)minutes];
        }
        if ([[NSString stringWithFormat:@"%ld", (long)hours] length] == 1) {
            hoursStr = [NSString stringWithFormat:@"0%ld", (long)hours];
        }else {
            hoursStr = [NSString stringWithFormat:@"%ld", (long)hours];
        }
        
        return [NSString stringWithFormat:@"%@:%@", hoursStr, minutesStr];
    }
}

#pragma mark -- 分钟转化成分秒
/**
 分钟-分：秒

 @param totalSeconds 分钟数
 @return ms
 */
+ (NSString *)minToMinAndScond:(NSInteger)totalSeconds {
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    
    NSString *secondString = @"";
    if (seconds < 10) {
        secondString = [NSString stringWithFormat:@"0%d", seconds];
    }else {
        secondString = [NSString stringWithFormat:@"%d", seconds];
    }
    
    NSString *minuteString = @"";
    if (minutes < 10) {
        minuteString = [NSString stringWithFormat:@"0%d", minutes];
    }else {
        minuteString = [NSString stringWithFormat:@"%d", minutes];
    }
    
    return [NSString stringWithFormat:@"%@%@", minuteString, secondString];
}

/* 获取当前日期 */
+ (NSString *)currentDateWithReverse:(BOOL)isReverse {
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (isReverse) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    return dateString;
}

+ (NSDate *)stringToDateMinAndSecond:(NSString *)string {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:string];
    
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    
    return destinationDateNow;
}

/* 比较两个时间 */
+ (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //date1在后
        return 1;
    }
    else if (result == NSOrderedAscending) {
        //date1在前
        return -1;
    }
    
    //两时间一样
    return 0;
}

+ (NSString *)timeWithDayHourMinSec:(NSInteger)totalSeconds {
    
    NSInteger day = totalSeconds / (3600 * 24);
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = totalSeconds / 3600 - (day * 24);
    
    return [NSString stringWithFormat:@"%ld天%02ld时%02ld分%02ld秒", (long)day, (long)hours, (long)minutes, (long)seconds];
}

+ (NSString *)timestamp {
    
    NSString *recordTime = [NSString stringWithFormat:@"%ld",(long)[[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] integerValue]];

    return recordTime;
}

@end
