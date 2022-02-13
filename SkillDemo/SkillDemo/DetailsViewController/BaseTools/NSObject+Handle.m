//
//  NSObject+Handle.m
//  Image
//
//  Created by pjw on 2021/4/7.
//

#import "NSObject+Handle.h"

@implementation NSObject (Handle)


- (NSInteger )timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
//    NSInteger str = [self timeSwitchTimestamp:@"2021-04-07 15:16:00" andFormatter:@"YYYY-MM-dd HH:mm:ss"];
//    NSLog(@"      11111111      %ld",(long)str);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];  //（@"YYYY-MM-dd hh:mm:ss"）----------注意>hh为12小时制,HH为24小时制
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime];
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}

- (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
//    NSString * str1 = [self timestampSwitchTime:str andFormatter:@"YYYY-MM-dd HH:mm"];
//    NSLog(@"      2222222      %@",str1);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    if ([format isEqual:@"HH:mm:ss"] && confromTimespStr.length<8) {
        confromTimespStr = @"00:00:00";
    }
    if ([format isEqual:@"YYYY-MM-dd HH:mm:ss"] && confromTimespStr.length<18) {
        confromTimespStr = @"2000-01-01 00:00:00"; //默认返回
    }
    return confromTimespStr;
}


+(NSString *)timeString:(NSString *)timeString timeFormatter:(NSString *)timeFormatter toTimeFormatter:(NSString *)toTimeFormatter{
    // 实例化NSDateFormatter
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter1 setDateFormat:timeFormatter];
    // 要转换的日期字符串
    NSString *dateString1 = timeString;
    // NSDate形式的日期
    NSDate *date =[formatter1 dateFromString:dateString1];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:toTimeFormatter];
    NSString *dateString2 = [formatter2 stringFromDate:date ];
    return dateString2;
}




@end
