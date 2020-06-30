//
//  KFTPaySDKDateTool.m
//  KFTPaySDK
//
//  Created by 马冰垒 on 2019/7/4.
//  Copyright © 2019 kftpay. All rights reserved.
//

#import "KFTDateTool.h"

static NSString * const kDefaultDateFormatter = @"yyyy-MM-dd HH:mm:ss";
static NSDateFormatter * dateFormatter = nil;

@implementation KFTDateTool

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
}

+ (NSString *)stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    dateFormatter.dateFormat = dateFormat;
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFromServerTime:(double)serverTime dateFormat:(NSString *)dateFormat {
    NSString *date = [self stringFromServerTime:serverTime dateFormat:dateFormat];
    return [self dateFromString:date dateFormat:dateFormat];
}

+ (NSString *)formatedStringFromServerTime:(double)serverTime toDate:(NSDate *)date
{
    if (!date) {
        date = [NSDate date];
    }
    NSDate *fromDate = [KFTDateTool dateFromServerTime:serverTime dateFormat:kDefaultDateFormatter];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *fromComponents = [calendar components:unitFlag fromDate:fromDate];
    NSDateComponents *toComponents = [calendar components:unitFlag fromDate:date];
    
    NSString *yearString = [KFTDateTool stringFromServerTime:serverTime dateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *yesterdayString = [KFTDateTool stringFromServerTime:serverTime dateFormat:@"昨天 HH:mm"];
    NSString *todayString = [KFTDateTool stringFromServerTime:serverTime dateFormat:@"今天 HH:mm"];
    NSString *minuteString = [KFTDateTool stringFromServerTime:serverTime dateFormat:@"mm 分钟前"];
    NSString *justNowString = @"刚刚";
    
    if (toComponents.year - fromComponents.year > 0) {
        return yearString;
    }
    
    if (toComponents.month - fromComponents.month > 0) {
        return yearString;
    }
    
    if (toComponents.day - fromComponents.day > 1) {
        return yearString;
    }
    if (toComponents.day - fromComponents.day == 1) {
        return yesterdayString;
    }
    if (toComponents.hour - fromComponents.hour > 0) {
        return todayString;
    }
    if (toComponents.minute - fromComponents.minute < 60 && toComponents.minute - fromComponents.minute > 0) {
        return minuteString;
    }
    if (toComponents.second - fromComponents.second < 60) {
        return justNowString;
    }
    return yearString;
}

+ (NSDate *)dateFromString:(NSString *)string dateFormat:(NSString *)dateFormat {
    dateFormatter.dateFormat = dateFormat;
    return [dateFormatter dateFromString:string];
}

+ (NSString *)stringFromServerTime:(double)serverTime dateFormat:(NSString *)dateFormat {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:serverTime/1000];
    if (dateFormat) {
        [dateFormatter setDateFormat:dateFormat];
    } else {
        [dateFormatter setDateFormat:kDefaultDateFormatter];
    }
    NSString *timeString = [dateFormatter stringFromDate:date];
    return timeString;
}

+ (NSDate *)dateByAddingDay:(NSInteger)day toDate:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = day;
    NSDate *resultDdate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
    return resultDdate;
}

+ (NSDate *)dateByAddingYear:(NSInteger)year toDate:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = year;
    NSDate *resultDdate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
    return resultDdate;
}

+ (NSArray<NSDate *> *)fetchFirstAndLastDayAtYearMonthDate:(NSDate *)date {
    NSDate *newDate= date ?: [NSDate date];
    double interval = 0;
    NSDate *firstDayDate = nil;
    NSDate *lastDayDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];

    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDayDate interval:&interval forDate:newDate];
    
    if (OK) {
        lastDayDate = [firstDayDate dateByAddingTimeInterval:interval - 1];
    } else {
        return @[];
    }
    return @[firstDayDate, lastDayDate];
}

@end
