//
//  NSString+BaseNSStringHandle.m
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import "NSString+Handle.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation NSString (Handle)

//数组转JSON字符串
+ (NSString*)arrayToJsonString:(NSArray *)array{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


//字典转JSON字符串
+ (NSString*)dictionaryToJsonString:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



//取document路径
+ (NSString *)documentPath{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0){
        return [paths objectAtIndex:0];
    }
    return nil;
}



//获取当前时间
+ (NSString *)getCurrentTimeWithDateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateString;
}



//获取当前时间前一月
+ (NSString *)getLastOneMonthWithDateFormat:(NSString *)dateFormat{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM"];
    [formatter setDateFormat:dateFormat];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
//    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:-1];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
//    NSLog(@"date str = %@", dateStr);
    return dateStr;
}

//获取当前时间 的 前几个月
+ (NSString *)getLastUnknownMonthWithDateFormat:(NSString *)dateFormat num:(NSInteger )num{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM"];
    [formatter setDateFormat:dateFormat];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
//    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:num];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
//    NSLog(@"date str = %@", dateStr);
    return dateStr;
}

//中文月份转 英文月份
+ (NSString *)englishMonth:(NSString *)dateMonth{
    
    if([dateMonth isEqualToString:@"01"]){
        return @"Jan";
        
    }else if([dateMonth isEqualToString:@"02"]){
        return @"Feb";
        
    }else if([dateMonth isEqualToString:@"03"]){
        return @"Mar";
        
    }else if([dateMonth isEqualToString:@"04"]){
        return @"Apr";
        
    }else if([dateMonth isEqualToString:@"05"]){
        return @"May";
        
    }else if([dateMonth isEqualToString:@"06"]){
        return @"June";
        
    }else if([dateMonth isEqualToString:@"07"]){
        return @"July";
        
    }else if([dateMonth isEqualToString:@"08"]){
        return @"Aug";
        
    }else if([dateMonth isEqualToString:@"09"]){
        return @"Sept";
        
    }else if([dateMonth isEqualToString:@"10"]){
        return @"Oct";
        
    }else if([dateMonth isEqualToString:@"11"]){
        return @"Nov";
        
    }else if([dateMonth isEqualToString:@"12"]){
        return @"Dec";
    }
    return @"";
}

//获取当前时间前一天
+ (NSString *)getLastOneDayWithDateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSDate * date = [NSDate date];//当前时间
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];
    NSString *currentDateString = [dateFormatter stringFromDate:lastDay];
    return currentDateString;
}

//获取半年前时间
+ (NSString *)getHalfYearBeforeWithDateFormat:(NSString *)dateFormat{
    //得到当前的时间
    NSDate * mydate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:-6];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    return beforDate;
}

//时间转换（date->string）
+ (NSString *)dateToString:(NSDate *)theDate dateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSString *datestring = [dateFormatter stringFromDate:theDate];
    return datestring;
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

///将时间转换成时间戳
+ (NSString *)timeStringToDateString:(NSString *)timeString formatTime:(NSString *)formatTime{
    
    NSDateFormatter * formatter= [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatTime];
    NSDate * dateTodo = [formatter dateFromString:timeString];
    NSString * timeSp = [NSString stringWithFormat:@"%ld", (long)[dateTodo timeIntervalSince1970]];
    return timeSp;
}

//加密电话 号码
+(NSString *)encryptPhone:(NSString *)phoneNumber{
    
    // 判断是否为空串
    if ([phoneNumber isEqual:[NSNull null]]) {
        return @"";
    }else if ([phoneNumber isKindOfClass:[NSNull class]]){
        return @"";
    }else if (phoneNumber == nil){
        return @"";
    }else if ([phoneNumber isEqualToString:@""]){
        return @"";
    }
    
    NSString *phoneString = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (phoneString.length >= 6) {
        for (int i=0; i<phoneString.length; i++) {
            unichar ch = [phoneString characterAtIndex:i];
            if (0x4E00 <= ch && ch <= 0x9FA5) {
                NSLog(@"文本里面有汉字");
                NSLog(@"phoneNumber----%@",phoneNumber);
                return phoneNumber;
            }
        }
        NSString *telString = [phoneString stringByReplacingCharactersInRange:NSMakeRange((phoneString.length-4)/2, 4) withString:@"****"];
        return telString;
    }
    return phoneNumber;
    
    
    /*
     
     BOOL isPureBOOL = [self isPureInteger:phoneString];
     if (isPureBOOL == YES) {//纯数字
     
     //判断是否 手机号码
     BOOL isValidBOOL = [self isValidPhone:phoneString];
     if (isValidBOOL == YES) {
     NSString *telString = [phoneString stringByReplacingCharactersInRange:NSMakeRange(phoneString.length - 7, 7) withString:@"XXXXXXX"];
     return telString;
     }else{
     if ([phoneString isEqual:@""]) {
     return phoneString;
     }else{
     if (phoneString.length >= 7 && phoneString.length < 14) {
     NSString *telString = [phoneString stringByReplacingCharactersInRange:NSMakeRange(phoneString.length - 4, 4) withString:@"XXXX"];
     return telString;
     }else{
     return phoneString;
     }
     }
     }
     
     }else{
     return phoneNumber;
     }
     
     */
}

+ (NSString *)verticalStringFrom:(NSString *)sourceStr lineNum:(int)num{
    NSMutableString * str = [[NSMutableString alloc] initWithString:sourceStr];
    NSInteger count = str.length;
    for (int i = 1; i < count+count/3; i ++) {
        if (i %(num+1) == 0) {
            [str insertString:@"\n" atIndex:i-1];
        }
    }
    return str;
}


+ (NSString *)clearNullString:(NSString *)nullString{
    if (nullString==nil || [nullString isEqual:[NSNull null]]){
        return @"";
    }
    return nullString;
}

+ (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

//获得设备型号
+ (NSString *)getCurrentDeviceModel{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    
    //simulator
    if ([platform isEqualToString:@"i386"])          return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])        return @"Simulator";
    
    //AirPods
    if ([platform isEqualToString:@"AirPods1,1"])    return @"AirPods";
    
    //Apple TV
    if ([platform isEqualToString:@"AppleTV2,1"])    return @"Apple TV (2nd generation)";
    if ([platform isEqualToString:@"AppleTV3,1"])    return @"Apple TV (3rd generation)";
    if ([platform isEqualToString:@"AppleTV3,2"])    return @"Apple TV (3rd generation)";
    if ([platform isEqualToString:@"AppleTV5,3"])    return @"Apple TV (4th generation)";
    if ([platform isEqualToString:@"AppleTV6,2"])    return @"Apple TV 4K";
    
    //Apple Watch
    if ([platform isEqualToString:@"Watch1,1"])    return @"Apple Watch (1st generation)";
    if ([platform isEqualToString:@"Watch1,2"])    return @"Apple Watch (1st generation)";
    if ([platform isEqualToString:@"Watch2,6"])    return @"Apple Watch Series 1";
    if ([platform isEqualToString:@"Watch2,7"])    return @"Apple Watch Series 1";
    if ([platform isEqualToString:@"Watch2,3"])    return @"Apple Watch Series 2";
    if ([platform isEqualToString:@"Watch2,4"])    return @"Apple Watch Series 2";
    if ([platform isEqualToString:@"Watch3,1"])    return @"Apple Watch Series 3";
    if ([platform isEqualToString:@"Watch3,2"])    return @"Apple Watch Series 3";
    if ([platform isEqualToString:@"Watch3,3"])    return @"Apple Watch Series 3";
    if ([platform isEqualToString:@"Watch3,4"])    return @"Apple Watch Series 3";
    
    //HomePod
    if ([platform isEqualToString:@"AudioAccessory1,1"])    return @"HomePod";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])    return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])    return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])    return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])    return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])    return @"iPad 2";
    if ([platform isEqualToString:@"iPad3,1"])    return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,2"])    return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,3"])    return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,4"])    return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad3,5"])    return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad3,6"])    return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad4,1"])    return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])    return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])    return @"iPad Air";
    if ([platform isEqualToString:@"iPad5,3"])    return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])    return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,7"])    return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,8"])    return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,3"])    return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,4"])    return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,11"])    return @"iPad (5th generation)";
    if ([platform isEqualToString:@"iPad6,12"])    return @"iPad (5th generation)";
    if ([platform isEqualToString:@"iPad7,1"])    return @"iPad Pro (12.9-inch, 2nd generation)";
    if ([platform isEqualToString:@"iPad7,2"])    return @"iPad Pro (12.9-inch, 2nd generation)";
    if ([platform isEqualToString:@"iPad7,3"])    return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,4"])    return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,5"])    return @"iPad (6th generation)";
    if ([platform isEqualToString:@"iPad7,6"])    return @"iPad (6th generation)";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])    return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,6"])    return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,7"])    return @"iPad mini";
    if ([platform isEqualToString:@"iPad4,4"])    return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"])    return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"])    return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"])    return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"])    return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"])    return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,1"])    return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,2"])    return @"iPad mini 4";
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"])     return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])     return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])     return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])     return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])     return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])     return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])     return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])     return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"])     return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])     return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"])     return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])     return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])     return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])     return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])     return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])     return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])     return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])     return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"])     return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])     return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"])     return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])    return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"])    return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"])    return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"])    return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"])    return @"iPhone XS Max";
    
    //iPod touch
    if ([platform isEqualToString:@"iPod1,1"])    return @"iPod touch";
    if ([platform isEqualToString:@"iPod2,1"])    return @"iPod touch (2nd generation)";
    if ([platform isEqualToString:@"iPod3,1"])    return @"iPod touch (3rd generation)";
    if ([platform isEqualToString:@"iPod4,1"])    return @"iPod touch (4th generation)";
    if ([platform isEqualToString:@"iPod5,1"])    return @"iPod touch (5th generation)";
    if ([platform isEqualToString:@"iPod7,1"])    return @"iPod touch (6th generation)";
    
    return platform;
}




@end
