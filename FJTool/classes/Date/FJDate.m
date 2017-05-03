//
//  FJDate.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJDate.h"

@implementation FJDate

// 秒（now，by format）
+(long long)formattedTimeDigital:(NSString*)format
{
    NSString *currentTimeStr = [FJDate formattedTimeNow:format];
    long long currentTime = [currentTimeStr longLongValue];
    return currentTime;
}

// seconds(offset days)
+(long long)formattedTimeDigitalOffsetDays:(int)days format:(NSString*)format
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval currentInterval = [currentDate timeIntervalSince1970];
    currentInterval += 24*60*60 * days;
    currentDate = [NSDate dateWithTimeIntervalSince1970:currentInterval];
    NSString *currentDateStr = [FJDate stringOfDate:currentDate format:format];
    long long ret = [currentDateStr longLongValue];
    return ret;
}

// seconds(offset minutes)
+(long long)formattedTimeDigitalOffsetMinutes:(int)minutes format:(NSString*)format
{
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval currentInterval = [currentDate timeIntervalSince1970];
    currentInterval += 60 * minutes;
    currentDate = [NSDate dateWithTimeIntervalSince1970:currentInterval];
    NSString *currentDateStr = [FJDate stringOfDate:currentDate format:format];
    long long ret = [currentDateStr longLongValue];
    return ret;
}

// 毫秒（now）
+(long long)timestampMillisecNow
{
    NSDate *dateNow = [NSDate date];
    long long now = (long long)([dateNow timeIntervalSince1970] * 1000);
    return now;
}

// 秒（now）
+(long long)timestampSecNow
{
    NSDate *dateNow = [NSDate date];
    long long now = (long long)[dateNow timeIntervalSince1970];
    return now;
}

// 天数（this year）
+(int)totalDaysOfThisYear
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *comps =[calender components:(NSCalendarUnitYear |
                                                   NSCalendarUnitMonth |
                                                   NSCalendarUnitDay |
                                                   NSCalendarUnitWeekOfYear )
                                         fromDate:[NSDate date]];
    int count = 0;
    for (int i = 1; i <= 12; i++) {
        [comps setMonth:i];
        NSRange range = [calender rangeOfUnit:NSCalendarUnitDay
                                       inUnit:NSCalendarUnitMonth
                                      forDate:[calender dateFromComponents:comps]];
        count += range.length;
    }
    return count;
}

// 年（this year）
+(int)thisYear
{
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate];
    // Get necessary date components
    
    return (int)[components year];
}

// 月（this month）
+(int)thisMonth
{
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate];
    // Get necessary date components
    
    return (int)[components month];
}

// 月（of this year）
+ (NSString*)thisMonth_Year {
    int y = [self thisYear];
    int mon = [self thisMonth];
    return [NSString stringWithFormat:@"%d-%d",y,mon];
}

// 天（of this year）
+(int)dayOfThisYear
{
    
    int currentYear = [FJDate thisYear];
    
    NSDate *currentDate = [NSDate date];
    
    NSDate *dateOfFirstDay = [FJDate dateWithYYYY:currentYear MM:1 DD:1 HH:0 mm:0 ss:0];
    NSTimeInterval difference = [currentDate timeIntervalSince1970] - [dateOfFirstDay timeIntervalSince1970];
    int day = difference / (24*60*60);
    return day+1;
}

// 天（of this month）
+(int)dayOfThisMonth
{
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate]; // Get necessary date components
    
    return (int)[components day];
}

// 天（of this week）
+(DFWeek)dayOfThisWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    NSDateComponents *weekComp = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekDayEnum = [weekComp weekday];
    DFWeek weekDay = DFWeek_Unknown;
    switch (weekDayEnum) {
        case 1:
            // sunday
            weekDay = DFWeek_Sunday;
            break;
        case 2:
            // monday
            weekDay = DFWeek_Monday;
            break;
        case 3:
            // tuesday
            weekDay = DFWeek_Tuesday;
            break;
        case 4:
            // wendesday
            weekDay = DFWeek_Wednesday;
            break;
        case 5:
            // thurthday
            weekDay = DFWeek_Thursday;
            break;
        case 6:
            // friday
            weekDay = DFWeek_Friday;
            break;
        case 7:
            // saturday
            weekDay = DFWeek_Saturday;
            break;
        default:
            break;
    }
    return weekDay;
}

// 天（of week, timestamp seconds）
+(DFWeek)dayOfWeek:(long long)timestampSec
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestampSec];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekComp = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekDayEnum = [weekComp weekday];
    int weekDays = DFWeek_Unknown;
    switch (weekDayEnum) {
        case 1:
            // sunday
            weekDays = DFWeek_Sunday;
            break;
        case 2:
            // monday
            weekDays = DFWeek_Monday;
            break;
        case 3:
            // tuesday
            weekDays = DFWeek_Tuesday;
            break;
        case 4:
            // wendesday
            weekDays = DFWeek_Wednesday;
            break;
        case 5:
            // thurthday
            weekDays = DFWeek_Thursday;
            break;
        case 6:
            // friday
            weekDays = DFWeek_Friday;
            break;
        case 7:
            // saturday
            weekDays = DFWeek_Saturday;
            break;
        default:
            break;
    }
    return weekDays;
}

// 小时（24）
+(int)hourOfToday24HH
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"HH"];
    
    NSString *hour = [dateFormatter stringFromDate:currentDate];
    return [hour intValue];
}

// 小时（12）
+(int)hourOfToday12hh
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"hh"];
    
    NSString *hour = [dateFormatter stringFromDate:currentDate];
    return [hour intValue];
}

// minute(of day)
+(int)minuteOfToday
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"mm"];
    
    NSString *minute = [dateFormatter stringFromDate:currentDate];
    return [minute intValue];
}

// second(of day)
+(int)secondOfToday
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"ss"];
    
    NSString *second = [dateFormatter stringFromDate:currentDate];
    return [second intValue];
}

// AM/PM
+(DFNoon)meridiem:(long long)timestampSec
{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:timestampSec];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"HH"];
    
    NSString *hour = [dateFormatter stringFromDate:currentDate];
    int hr = [hour intValue];
    
    if (hr < 12) {
        return DFNoon_Morning;
    }else if (hr < 24) {
        return DFNoon_Afternoon;
    }else{
        return DFNoon_Unknown;
    }
}

// formatted date string(return string)
+(NSString*)stringOfDate:(NSDate*)date format:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

// formatted date string(return date)
+(NSDate*)dateOfString:(NSString*)date format:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:date];
}

// date(HH mm ss today)
+(NSDate*)dateOfTodayWithHH:(int)hour mm:(int)minute ss:(int)second
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:[[NSDate alloc] init]];
    [components setHour:-[components hour]+hour];
    [components setMinute:-[components minute]+minute];
    [components setSecond:-[components second]+second];
    NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0];
    return today;
}

// date(HH mm ss yesterday)
+(NSDate*)dateOfYesterdayWithHH:(int)hour mm:(int)minute ss:(int)second
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:[[NSDate alloc] init]];
    [components setHour:-[components hour]+hour];
    [components setMinute:-[components minute]+minute];
    [components setSecond:-[components second]+second];
    NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0];
    
    // Yesterday
    [components setHour:-24];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *yesterday = [cal dateByAddingComponents:components toDate: today options:0];
    return yesterday;
}

// date(YYYY MM DD HH mm ss)
+(NSDate*)dateWithYYYY:(int)year MM:(int)month DD:(int)day HH:(int)hour mm:(int)minute ss:(int)second
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [cal components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond  ) fromDate:[[NSDate alloc] init]];
    [components setHour:-[components hour]+hour];
    [components setMinute:-[components minute]+minute];
    [components setSecond:-[components second]+second];
    NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    NSString *currentStr = [dateFormatter stringFromDate:today];
    
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSMutableString *newDateStr = [[NSMutableString alloc] init];
    [newDateStr appendString:[NSString stringWithFormat:@"%d/%d/%d %@",year,month,day,currentStr]];
    return [dateFormatter dateFromString:newDateStr];
}

// date string array
// stepType:1 - Day,2 - Hour,3 - Minute,4 - Second
+(NSArray*)getArrayDateStringWithBegin:(NSString*)begin end:(NSString*)end format:(NSString*)format stepType:(int)stepType stepValue:(int)stepValue
{
    NSDate *beginDate = [FJDate dateOfString:begin format:format];
    NSDate *endDate = [FJDate dateOfString:end format:format];
    
    NSTimeInterval step = 0;
    NSTimeInterval beginInterval = [beginDate timeIntervalSince1970];
    NSTimeInterval endInterval = [endDate timeIntervalSince1970];
    
    NSMutableArray *arr = nil;
    if (stepType == 1) {
        // day
        step = (24*60*60)*stepValue;
    }else if (stepType == 2) {
        // hour
        step = (60*60)*stepValue;
    }else if (stepType == 3) {
        step = 60 *stepValue;
    }else if (stepType == 4){
        step = stepValue;
    }
    if (step == 0) {
        return nil;
    }else{
        arr = [[NSMutableArray alloc] init];
    }
    
    NSDate *date = nil;
    NSString *dateStr = nil;
    for(;beginInterval <= endInterval; beginInterval+=step)
    {
        date = [NSDate dateWithTimeIntervalSince1970:beginInterval];
        dateStr = [FJDate stringOfDate:date format:format];
        [arr addObject:dateStr];
    }
    return arr;
}

// 日期显示（now）
+(NSString*)formattedTimeNow:(NSString*)format
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:currentDate];
}

// 日期显示（timestamp second, format）
+(NSString*)formattedTime:(long long)timestampSec format:(NSString*)format
{
    NSDate *ndate = [NSDate dateWithTimeIntervalSince1970:timestampSec];
    NSString *dateStr = [FJDate stringOfDate:ndate format:format];
    return dateStr;
}

// 日期显示（timestamp second, in/out format）
+(NSString*)formattedTime:(NSString*)formattedDate informat:(NSString*)informat toformat:(NSString*)toformat
{
    NSDate *ndate = [FJDate dateOfString:formattedDate format:informat];
    NSString *dateStr = [FJDate stringOfDate:ndate format:toformat];
    return dateStr;
}

// 日期显示（默认）
+(NSString*)formattedTimeSecondsDefault:(long long)timestampSec
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestampSec];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    // Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    [dateFormatter setDateFormat:@"MM"];
    NSString *mon = [dateFormatter stringFromDate:date];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *other = [dateFormatter stringFromDate:date];
    
    if ([mon isEqualToString:@"01"]) {
        mon = @"Jan";
    }else if ([mon isEqualToString:@"02"]) {
        mon = @"Feb";
    }else if ([mon isEqualToString:@"03"]) {
        mon = @"Mar";
    }else if ([mon isEqualToString:@"04"]) {
        mon = @"Apr";
    }else if ([mon isEqualToString:@"05"]) {
        mon = @"May";
    }else if ([mon isEqualToString:@"06"]) {
        mon = @"Jun";
    }else if ([mon isEqualToString:@"07"]) {
        mon = @"Jul";
    }else if ([mon isEqualToString:@"08"]) {
        mon = @"Aug";
    }else if ([mon isEqualToString:@"09"]) {
        mon = @"Sep";
    }else if ([mon isEqualToString:@"10"]) {
        mon = @"Oct";
    }else if ([mon isEqualToString:@"11"]) {
        mon = @"Nov";
    }else if ([mon isEqualToString:@"12"]) {
        mon = @"Dec";
    }else{
        mon = nil;
    }
    
    return other;
}

// 是否date是N天以前
+(BOOL)ifDatePassed:(NSDate*)date by:(int)days {
    
    NSDate * now =   [NSDate date];
    // one day = 60 * 60 * 24 (seconds)
    // date passed by N days
    int seconds = 60 * 60 * 24 * days;
    NSDate * dateAfterDays = [NSDate dateWithTimeInterval:seconds sinceDate:date];
    
    if ([dateAfterDays timeIntervalSinceDate:now] < 0.0f) {
        // date是N天以前
        return YES;
    }
    
    // date不是N天以前
    return NO;
}

// 微信显示时间戳的方式
+ (NSString*)wechatStyle:(long long)timestampSec {
    
    long long now = [FJDate timestampSecNow];
    NSTimeInterval result = now - timestampSec;
    
    int day;
    int hour;
    int minute;
    NSString *postTime = [FJDate formattedTime:timestampSec format:@"yyyy-MM-dd HH:mm"];
    
    day = result / 86400;
    if ( day >= 7 ) {
        // 2015-08-25 18:00
        postTime = [FJDate formattedTime:timestampSec format:@"yyyy-MM-dd HH:mm"];
    }else if ( day >= 2){
        // 大于48小时 小于7天
        postTime = [NSString stringWithFormat:@"%d天前",(int)day];
    }else if ( day >= 1){
        // 昨天
        postTime =@"昨天";
    }else {
        // 今天
        hour = (result - ((int)day * 86400))/ 3600;
        if (hour>=1) {// 一小时前
            postTime = [NSString stringWithFormat:@"%d小时前",(int)hour];
        }else {// 一小时以内
            minute = (result - ((int)day*86400) - ((int)hour*3600))/60;
            postTime = [NSString stringWithFormat:@"%d分钟前",(int)minute];
        }
    }
    return postTime;
}

@end
