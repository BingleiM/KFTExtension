//
//  KFTPaySDKDateTool.h
//  KFTPaySDK
//
//  Created by 马冰垒 on 2019/7/4.
//  Copyright © 2019 kftpay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KFTDateTool : NSObject

/**
 日期转为字符串
 
 @param date 转化的日期
 @param dateFormat 日期格式
 @return 日期字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/**
 服务器时间戳转为字符串
 
 @param serverTime 服务器时间戳（毫秒）
 @param dateFormat 日期格式
 @return 日期字符串
 */
+ (NSString *)stringFromServerTime:(double)serverTime dateFormat:(NSString *)dateFormat;

/**
 服务器时间转为字符串（刚刚、8分钟前、今天9:00、昨天9:00、2017-08-13 12:30）
 
 @param serverTime 服务器时间戳（毫秒）
 @param date 当前日期
 @return 日期转为字符串
 */
+ (NSString *)formatedStringFromServerTime:(double)serverTime toDate:(NSDate *)date;

/**
 时间字符串转为日期
 
 @param string 时间字符串
 @param dateFormat 日期格式
 @return 日期
 */
+ (NSDate *)dateFromString:(NSString *)string dateFormat:(NSString *)dateFormat;

/**
 服务器时间戳转为日期
 
 @param serverTime 服务器时间戳（毫秒）
 @param dateFormat 日期格式
 @return 日期
 */
+ (NSDate *)dateFromServerTime:(double)serverTime dateFormat:(NSString *)dateFormat;

/**
 日期增加分钟数
 
 @param minute 增加的分钟数
 @param date 目标日期
 @return 日期
 */
+ (NSDate *)dateByAddingMinute:(NSInteger)minute toDate:(NSDate *)date;

/**
 日期增加天数
 
 @param day 增加的天数
 @param date 目标日期
 @return 日期
 */
+ (NSDate *)dateByAddingDay:(NSInteger)day toDate:(NSDate *)date;

/**
 日期增加年数
 
 @param year 增加的年数
 @param date 目标日期
 @return 日期
 */
+ (NSDate *)dateByAddingYear:(NSInteger)year toDate:(NSDate *)date;

/**
 日期增加时间
 
 @param components 自定义追加 components.year components.day 等
 @param date 目标日期
 @return 日期
 */
+ (NSDate *)dateByAddingComponents:(NSDateComponents *)components toDate:(NSDate *)date;

/**
获取某年某月的第一天/最后一天日期

@param date 查询某年某月日期, 传空默认查询当前年月
@return <第一天/最后一天日期数组>
*/
+ (nullable NSArray<NSDate *> *)fetchFirstAndLastDayAtYearMonthDate:(NSDate *)date;

/// 计算两个日期的差值
/// @param unit
/*
* 要比较的时间单位,常用如下,可以同时传：
*    NSCalendarUnitDay : 天
*    NSCalendarUnitYear : 年
*    NSCalendarUnitMonth : 月
*    NSCalendarUnitHour : 时
*    NSCalendarUnitMinute : 分
*    NSCalendarUnitSecond : 秒
*/
/// @param fromDate fromDate
/// @param toDate toDate
+ (NSDateComponents *)components:(NSCalendarUnit)unit
                        fromDate:(NSDate *)fromDate
                          toDate:(NSDate *)toDate;

@end

NS_ASSUME_NONNULL_END
