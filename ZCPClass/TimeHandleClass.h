//
//  TimeHandleClass.h
//  shanglv51
//
//  Created by iosyf－03 on 2017/9/20.
//  Copyright © 2017年 shanglv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeHandleClass : NSObject
/**
 获取当前日期
 
 @param showHHmmss 是否需要时分秒
 @return YYYY-MM-dd OR XXXX-XX-XX HH-mm-dd
 */
+ (NSString *)nowDateWithType:(BOOL)showHHmmss;
/**
 计算两日期的差值
 
 @param startTime 起始时间
 @param endTime 结束时间
 @return 返回差值天数
 */
+ (NSInteger)dateTimeDifferenceDayWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
/**
 计算当前日期到指定日期的秒数

 @param endTime 指定时间
 @return 相差秒数
 */
+ (NSInteger)dateTimeDifferenceDayWithEndTime:(NSString *)endTime;
/**
 获取星期
 
 @param date 时间戳 YYYY-MM-dd
 @param type 需要的星期格式 YES:周几 NO:星期几
 @return 周三 Or 星期三
 */
+ (NSString *)currentWeek:(NSString *)date type:(BOOL)type;
/**
 String转NSDate
 
 @param string YYYY-MM-dd
 @return NSDate
 */
+ (NSDate *)stringToDate:(NSString *)string;
/**
 Date转String
 
 @param date NSDate
 @return yyyy-MM-dd
 */
+ (NSString *)dateToString:(NSDate *)date;
/**
 此月共有几天
 
 @param dateString YYYY-MM-dd
 @return 天数
 */
+ (NSInteger)totaldaysInMonth:(NSString *)dateString;
/**
 计算年龄
 
 @param aBirthDay 生日:yyyy-MM-dd
 @return 年龄
 */
+ (NSInteger)birthDateToAge:(NSString *)aBirthDay;
/**
 计算X天后的日期
 
 @param nowDateString yyyy-MM-dd
 @param aDay 多少天后
 @return yyyy-MM-dd
 */
+ (NSString *)distanceDate:(NSString *)nowDateString aDay:(NSInteger)aDay;
/**
 身份证中获取出生日期
 
 @param numberStr 身份证号
 @return 生日yyyy-MM-dd
 */
+ (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;
/**
 日期转化为mm月dd日的格式
 
 @param dateString 时间戳
 @return mm月dd日
 */
+ (NSString *)stringWithDateString:(NSString *)dateString;
/**
 处理后台返回时间格式(去掉T)
 
 @param timeString 后台返回时间
 @return 去掉t后的时间
 */
+ (NSString *)strintWithTimeString:(NSString *)timeString;
/**
 计算当前时间是否在某个时间段内
 
 @param startTime 起始时间
 @param endTime 结束时间
 @return 是否在这个时间段内
 */
+ (BOOL)currentDateIsBetweenZeroAndSixWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
/**
 分钟-小时：分钟
 
 @param min 传入分钟
 @param dateType 显示格式:h/小时
 @return 结果
 */
+ (NSString *)dateChangeWithMin:(NSString *)min dateType:(NSString *)dateType;
/**
 分钟-分：秒
 
 @param totalSeconds 分钟数
 @return ms
 */
+ (NSString *)minToMinAndScond:(NSInteger)totalSeconds;


/**
 秒转为天时分秒格式

 @param totalSeconds 总共秒数
 @return 天时分秒
 */
+ (NSString *)timeWithDayHourMinSec:(NSInteger)totalSeconds;


/**
 当前时间戳

 @return return value description
 */
+ (NSString *)timestamp;
@end
