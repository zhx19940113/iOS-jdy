//
//  DateUtil.h
//  yidao
//
//  Created by 钟惠雄 on 14-1-9.
//  Copyright (c) 2014年 钟惠雄. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Helper.h"
#import "NSDate+Category.h"
@interface DateUtil : NSObject

//格式化字符串yyyy-mm-dd hh-mm-ss
+(NSString *)formatDate:(NSDate *) date;
//获得格式为yyyy-mm-dd的NSDateComponents对象
+(NSDateComponents *)getDateComponents:(NSDate*) date;
//格式化日期字符串——@"YYYY-MM-DD"
+(NSString*)dateToStringByFormat:(NSDate *)date format:(NSString*)format;
//返回nex day
+(NSDate *)nextDate:(NSDate *)date;
//返回prev day
+(NSDate *)previousDate:(NSDate *)date;
//是否是今天
+(BOOL)isToday:(NSDate*)date;
//是否这个月
+(BOOL)isThisMonth:(NSDate*)date;
//是否这个季度
+(BOOL)isThisQuarter:(NSDate*)date;
//获取一周的时间列表
+(NSArray *) getWeekDayList:(NSDate*)date;


//获取一月的时间
+(NSArray *) getMonthDayList:(NSDate*)date;
+(NSDate *)dateFromString:(NSString *)dateString;
+(NSArray *) getQuarterList:(NSDate*)date;
+(NSArray *) nextQuarterList:(NSDate*)date;
+(NSArray *) preQuarterList:(NSDate*)date;

//返回prev Week
+(NSDate *)previousWeek:(NSDate *)date;
//返回下N个小时
+(NSDate *)nextHour:(NSDate *)date hour:(int) hour;
+(NSString *)getBBsDay:(NSString *)dateStr;
//时间差
+(long)betweenTime:(NSDate *)fromdate;
@end