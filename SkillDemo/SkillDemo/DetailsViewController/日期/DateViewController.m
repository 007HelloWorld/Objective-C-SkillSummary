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
    
}



@end
