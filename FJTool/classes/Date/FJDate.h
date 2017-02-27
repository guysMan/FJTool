//
//  FJDate.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DFWeek)
{
    DFWeek_Unknown,
    DFWeek_Sunday,
    DFWeek_Monday,
    DFWeek_Tuesday,
    DFWeek_Wednesday,
    DFWeek_Thursday,
    DFWeek_Friday,
    DFWeek_Saturday
};

typedef NS_ENUM(NSInteger, DFNoon)
{
    DFNoon_Unknown,
    DFNoon_Morning,
    DFNoon_Afternoon
};

@interface FJDate : NSObject

// 秒（now，by format）
+(long long)formattedTimeDigital:(NSString*)format;

// seconds(offset days)
+(long long)formattedTimeDigitalOffsetDays:(int)days format:(NSString*)format;

// seconds(offset seconds)
+(long long)formattedTimeDigitalOffsetMinutes:(int)minutes format:(NSString*)format;

// 毫秒（now）
+(long long)timestampMillisecNow;

// 秒（now）
+(long long)timestampSecNow;

// 天数（this year）
+(int)totalDaysOfThisYear;

// 年（this year）
+(int)thisYear;

// 月（this month）
+(int)thisMonth;

// 月（of this year）
+ (NSString*)thisMonth_Year;

// 天（of this year）
+(int)dayOfThisYear;

// 天（of this month）
+(int)dayOfThisMonth;

// 天（of this week）
+(DFWeek)dayOfThisWeek;

// 天（of week, timestamp seconds）
+(DFWeek)dayOfWeek:(long long)timestampSec;

// 小时（24）
+(int)hourOfToday24HH;

// 小时（12）
+(int)hourOfToday12hh;

// minute(of day)
+(int)minuteOfToday;

// second(of day)
+(int)secondOfToday;

// AM/PM
+(DFNoon)meridiem:(long long)timestampSec;

// formatted date string(return string)
+(NSString*)stringOfDate:(NSDate*)date format:(NSString*)format;

// formatted date string(return date)
+(NSDate*)dateOfString:(NSString*)date format:(NSString*)format;

// date(HH mm ss today)
+(NSDate*)dateOfTodayWithHH:(int)hour mm:(int)minute ss:(int)second;

// date(HH mm ss yesterday)
+(NSDate*)dateOfYesterdayWithHH:(int)hour mm:(int)minute ss:(int)second;

// date(YYYY MM DD HH mm ss)
+(NSDate*)dateWithYYYY:(int)year MM:(int)month DD:(int)day HH:(int)hour mm:(int)minute ss:(int)second;

// date string array
// stepType:1 - Day,2 - Hour,3 - Minute,4 - Second
+(NSArray*)getArrayDateStringWithBegin:(NSString*)begin end:(NSString*)end format:(NSString*)format stepType:(int)stepType stepValue:(int)stepValue;

// 日期显示（now）
+(NSString*)formattedTimeNow:(NSString*)format;

// 日期显示（timestamp second, format）
+(NSString*)formattedTime:(long long)timestampSec format:(NSString*)format;

// 日期显示（timestamp second, in/out format）
+(NSString*)formattedTime:(NSString*)formattedDate informat:(NSString*)informat toformat:(NSString*)toformat;

// 日期显示（默认）
+(NSString*)formattedTimeSecondsDefault:(long long)timestampSec;

// 是否date是N天以前
+(BOOL)ifDatePassed:(NSDate*)date by:(int)days;

@end
