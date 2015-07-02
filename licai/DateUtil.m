//
//  DateUtil.m
//  yidao
//
//  Created by 钟惠雄 on 14-1-9.
//  Copyright (c) 2014年 钟惠雄. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+ (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd hh:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];

    return destDate;
}

+(NSString *)formatDate:(NSDate *) date{
    //获得日历对象
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //通过日历对象获得日期组件对象NSDateComponents
    NSUInteger units = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *components = [calender components:units fromDate:date];
    //格式化字符串
    NSString *msg = [NSString stringWithFormat:@"%d/%d/%d %d:%d", [components year], [components month], [components day], [components hour], [components minute]];
    return msg;
}


+(NSDateComponents *)getDateComponents:(NSDate*) date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    return comps;
}

//@"YYYY-MM-DD"
+(NSString*)dateToStringByFormat:(NSDate *)date format:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
    
}

// next date of given date
+(NSDate *)nextDate:(NSDate *)date
{
    return [[NSDate alloc] initWithTimeInterval:24*3600 sinceDate:date];
}

// previous date of given date
+(NSDate *)previousDate:(NSDate *)date
{
    return [[NSDate alloc] initWithTimeInterval:-24*3600 sinceDate:date];
    
}

+(BOOL)isToday:(NSDate*)date
{
    // Get Today's YYYY-MM-DD
    NSDateComponents *today_comps = [self getDateComponents:[NSDate date]];
    
    // Given Date's YYYY-MM-DD
    NSDateComponents *select_comps =[self getDateComponents:date];
    
    // if it's today, return TODAY
    if ( [today_comps year] == [select_comps year] &&
        [today_comps month] == [select_comps month] &&
        [today_comps day] == [select_comps day]){
        return YES;
    }
    else {
        return NO;
    }
    
}

+(BOOL)isThisMonth:(NSDate*)date {
    // Get Today's YYYY-MM-DD
    NSDateComponents *today_comps = [self getDateComponents:[NSDate date]];
    
    // Given Date's YYYY-MM-DD
    NSDateComponents *select_comps =[self getDateComponents:date];
    // if it's today, return TODAY
    if ( [today_comps year] == [select_comps year] &&
        [today_comps month] == [select_comps month]){
        return YES;
    }
    else {
        return NO;
    }
}

+(BOOL)isThisQuarter:(NSDate*)date{
     NSDateComponents *today_comps = [self getDateComponents:[NSDate date]];
    // Given Date's YYYY-MM-DD
    NSDateComponents *select_comps =[self getDateComponents:date];
    // if it's today, return TODAY
    if ( [today_comps year] == [select_comps year]){
        int tgrader=(int)[today_comps month]/3;
        int sgrader=(int)[select_comps month]/3;
        if(tgrader==sgrader)
        return YES;
        else return NO;
    }
    else {
        return NO;
    }
}
+(NSArray *) getWeekDayList:(NSDate*)date
{
    NSDate *startDate= date;
   
    NSMutableArray *weekDayList=[NSMutableArray array];
    for (int i=0; i<7; i++) {
        [weekDayList addObject:[startDate dateAfterDay:i]];
    }
    return weekDayList;
}
+(NSArray *) getMonthDayList:(NSDate*)date
{
    
    
    NSCalendar *c = [NSCalendar currentCalendar];
    
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                    
                           inUnit:NSMonthCalendarUnit
                    
                          forDate:date];
    
    int dayNum =  days.length;
    
    NSDate *datebegin=[date beginningOfMonth];
    NSMutableArray *monthDayList=[NSMutableArray array];
    for (int i=0; i<7; i++) {
        [monthDayList addObject:[datebegin dateAfterDay:i*4]];
    }
    
    if(dayNum==28){
        [monthDayList addObject:[datebegin dateAfterDay:27]];
    }
    if(dayNum==29){
        [monthDayList addObject:[datebegin dateAfterDay:28]];
    }
    
    if(dayNum==30){
        [monthDayList addObject:[datebegin dateAfterDay:28]];
        [monthDayList addObject:[datebegin dateAfterDay:29]];
    }
    
    if(dayNum==31){
        [monthDayList addObject:[datebegin dateAfterDay:28]];
        [monthDayList addObject:[datebegin dateAfterDay:30]];
    }
   
    
    return monthDayList;
}
+(NSArray *) getQuarterList:(NSDate*)date
{
    int grader=(int)[date month]/3;
    int year=[date year];
    NSMutableArray *monthList=[NSMutableArray array];
    for (int i=0; i<3; i++) {
        [monthList addObject:[self dateFromString:[NSString stringWithFormat:@"%d-%d-01 00:00:00",year,i+1*grader+4]]];
    }
    return monthList;
}

+(NSArray *) nextQuarterList:(NSDate*)date
{
    int year=[date year];
    int month = [date month];
    NSMutableArray *monthList=[NSMutableArray array];
    for (int i=0; i<3; i++) {
      
        [monthList addObject:[self dateFromString:[NSString stringWithFormat:@"%d-%d-01 00:00:00",year,month]]];
        month = month+1;
        if(month==12)
        {
            year = year +1;
            month = 1;
        }
//
//        if(month==1)
//        {
//            year = year -1;
//            month = 12;
//        }
        
        
        
    }
    return monthList;
}
+(NSArray *) preQuarterList:(NSDate*)date
{
  
   // int grader=(int)[date month]/3;
    int year=[date year];
    int month = [date month];
      NSLog(@"preQuarterList%d",month);
    NSMutableArray *monthList=[NSMutableArray array];
    for (int i=0; i<3; i++) {
        [monthList addObject:[self dateFromString:[NSString stringWithFormat:@"%d-%d-01 00:00:00",year,month]]];
        if(month==1)
        {
           year = year -1;
            month = 13;
        }
         month = month -1;
        
//        if(month==12)
//        {
//            year = year +1;
//            month = 1;
//        }
        
        
        
    }
    return monthList;
}


// previous date of given date
+(NSDate *)previousWeek:(NSDate *)date
{
    return [[NSDate alloc] initWithTimeInterval:-168*3600 sinceDate:date];
    
}

+(NSDate *)nextHour:(NSDate *)date hour:(int) hour;
{
    return [[NSDate alloc] initWithTimeInterval:hour *3600 sinceDate:date];
}


+(NSString *)getBBsDay:(NSString *)dateStr
{
  
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:dateStr];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    NSLog(@"fromdate=%@",fromDate);
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSLog(@"enddate=%@",localeDate);
    NSDateComponents *components = [gregorian components:unitFlags fromDate:fromDate toDate:localeDate options:0];
    NSInteger months = [components month];
    NSInteger days = [components day];//年[components year]
    NSLog(@"month=%d",months);
    NSLog(@"days=%d",days);
    if (months==0&&days==0) {
        dateStr=[[dateStr substringFromIndex:11]substringToIndex:5];
        return [NSString stringWithFormat:@"今天 %@",dateStr];//今天 11:23
    }else if(months==0&&days==1){
        dateStr=[[dateStr substringFromIndex:11]substringToIndex:5];
        return [NSString stringWithFormat:@"昨天 %@",dateStr];//昨天 11:23
    }else{
        dateStr=[dateStr substringToIndex:10];
        return dateStr;
    }

}

+(long)betweenTime:(NSDate *)fromdate
{
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    NSLog(@"fromdate=%@",fromDate);
    //获取当前时间
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSLog(@"enddate=%@",localeDate);
    
    
    double intervalTime = [fromDate timeIntervalSinceReferenceDate] - [localeDate timeIntervalSinceReferenceDate];
    
    long lTime = (long)intervalTime;
    NSInteger iSeconds = lTime % 60;
    NSInteger iMinutes = (lTime / 60) % 60;
    NSInteger iHours = (lTime / 3600);
    NSInteger iDays = lTime/60/60/24;
//    NSInteger iMonth = lTime/60/60/24/12;
//    NSInteger iYears = lTime/60/60/24/384;
    
   // NSLog(@"相差M年d月 或者 d日d时d分d秒", iYears,iMonth,iDays,iHours,iMinutes,iSeconds);
    
    return lTime;
}



@end
