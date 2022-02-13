//
//  DateViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/9/26.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "DateViewController.h"

@interface DateViewController ()

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //获取当前时间
    NSDate * date = [NSDate new];
    NSLog(@"获取当前时间  %@",date);
    
    //将时间转换成指定格式时间
    //1.先创建一个日期格式对象，这个对象可以将1个日期输出为指定的格式
    NSDateFormatter * formatter = [NSDateFormatter new];
    /*
        yyyy代表年份
        MM代表月份
        dd天
        HH时，24小时制
        hh时，12小时制
        mm分钟
        ss秒
    */
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString * str = [formatter stringFromDate:date];
    NSLog(@"将时间转换成指定格式时间    %@",str);
    
    //将时间字符串转成NSDate
    NSString * strDate = @"2011年12月12号 12点12分12秒";
    NSDateFormatter * strFormat = [NSDateFormatter new];
    strFormat.dateFormat = @"yyyy年MM月dd号 HH点mm分ss秒";
    NSDate * DateStr = [strFormat dateFromString:strDate];
    NSLog(@"将时间字符串转成NSDate  %@",DateStr);
    
    
    //从现在开始过了多长时间以后
    NSDate * d1 = [NSDate dateWithTimeIntervalSinceNow:10];
    NSLog(@"从现在开始过了多长时间以后   %@",d1);
    
    //两个时间之差
    double sj = [d1 timeIntervalSinceDate:DateStr];
    NSLog(@"两个时间之差  %f",sj);
    
    
    //获取时间中指定的部分
    NSDate * yearDate = [NSDate date];
    NSDateFormatter * yearFormat = [NSDateFormatter new];
    yearFormat.dateFormat = @"yyyy";
    NSString * yearStr = [yearFormat stringFromDate:yearDate];
    int year = yearStr.intValue;
    NSLog(@"获取时间中指定的部分  %d",year);
    
    
    //1.先创建一个日历对象，日历对象的作用可以从日期对象中取到日期中的各个部分
    NSCalendar * calendar = [NSCalendar currentCalendar];
    //2.让日历对象从日期对象中取出日期中的各个部分
    NSDateComponents * com = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:yearDate];
    NSLog(@"%lu -------%lu-----------%lu---------%lu",com.year,com.month,com.day,com.weekday);
    
    NSString * arr = [self mondayTime];//获取周一时间
    NSLog(@"获取周一时间      %@",arr);
    NSString * str10 = [self getMonthBegin:@"2021年02月18日"];//根据传入的时间，获取本月第一天时间
    NSLog(@"根据传入的时间，获取本月第一天时间     %@",str10);

    NSArray * timearr = [self latelyEightTime];//获取当前时间的周一到周末的时间
    NSLog(@"获取当前时间的周一到周末的时间     %@",timearr);
    
    
    NSString * str11 = [self getMonthBeginAndEndWith:@"2021年02月18日"];//获取月初月末时间
    NSLog(@"根据传入的时间，获取月初月末时间     %@",str11);
}

- (NSString *)getMonthBegin:(NSString *)dateStr{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    if (ok) {
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString * strStateTime = [myDateFormatter stringFromDate:beginDate];
    NSString *s = [NSString stringWithFormat:@"%@",strStateTime];
    return s;
}




//获取本周七天日期
-(NSString *)mondayTime{

    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
     // 计算当前日期和本周的星期一和星期天相差天数
    long first,last;
    if (weekDay == 1){
        first = -6;
        last = 0;
    }
    else{
        first = [calendar firstWeekday] - weekDay + 1;
        last = 8 - weekDay;
    }
       NSDateComponents *baseDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
    //获取周一日期
    [baseDayComp setDay:day + first];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:baseDayComp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateStr = [dateFormatter stringFromDate:firstDayOfWeek];
    NSString *strTime = [NSString stringWithFormat:@"%@",dateStr];
    return strTime;
}




//获取本周七天日期
-(NSMutableArray *)latelyEightTime{
    NSMutableArray *weekArr = [[NSMutableArray alloc] init];
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
     // 计算当前日期和本周的星期一和星期天相差天数
    long first,last;
    if (weekDay == 1){
        first = -6;
        last = 0;
    }
    else{
        first = [calendar firstWeekday] - weekDay + 1;
        last = 8 - weekDay;
    }
       NSDateComponents *baseDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
    //获取周一日期
    [baseDayComp setDay:day + first];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:baseDayComp];
    //计算从周一开始的七天日期
    for (int i = 0; i < 7; i ++) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = i * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeInterval:secondsPerDay sinceDate:firstDayOfWeek];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSString *strTime = [NSString stringWithFormat:@"%@",dateStr];
        NSLog(@"%@",strTime);
        [weekArr addObject:strTime];
    }
    return weekArr;
}

//转换英文为中文
-(NSString *)theWeek:(NSString *)theWeek{
    NSString *Str;
    if(theWeek){
        if([theWeek isEqualToString:@"Monday"]){
            Str = @"星期一";
        }else if([theWeek isEqualToString:@"Tuesday"]){
            Str = @"星期二";
        }else if([theWeek isEqualToString:@"Wednesday"]){
            Str = @"星期三";
        }else if([theWeek isEqualToString:@"Thursday"]){
            Str = @"星期四";
        }else if([theWeek isEqualToString:@"Friday"]){
            Str = @"星期五";
        }else if([theWeek isEqualToString:@"Saturday"]){
            Str = @"星期六";
        }else if([theWeek isEqualToString:@"Sunday"]){
            Str = @"星期日";
        }
    }
    return Str;
}

//获取月初月末时间
- (NSString *)getMonthBeginAndEndWith:(NSString *)dateStr{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString * strStateTime = [myDateFormatter stringFromDate:beginDate];
    NSString * strEndTime = [myDateFormatter stringFromDate:endDate];
    NSString *s = [NSString stringWithFormat:@"%@-%@",strStateTime,strEndTime];
    
    return s;
}

@end
