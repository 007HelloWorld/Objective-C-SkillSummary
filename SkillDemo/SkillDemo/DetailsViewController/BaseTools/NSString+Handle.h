//
//  NSString+BaseNSStringHandle.h
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Handle)

//数据转换类
///数组转json字符串
+ (NSString*)arrayToJsonString:(NSArray *)array;

///字典转JSON字符串
+ (NSString*)dictionaryToJsonString:(NSDictionary *)dic;


//获取资源类
///取document路径
+ (NSString *)documentPath;


//时间获取类
///获取当前时间
+ (NSString *)getCurrentTimeWithDateFormat:(NSString *)dateFormat;

///获取当前时间前一月
+ (NSString *)getLastOneMonthWithDateFormat:(NSString *)dateFormat;

///获取当前时间 的 前几个月
+ (NSString *)getLastUnknownMonthWithDateFormat:(NSString *)dateFormat num:(NSInteger )num;

///中文月份转 英文月份
+ (NSString *)englishMonth:(NSString *)dateMonth;
    
///获取当前时间前一天
+ (NSString *)getLastOneDayWithDateFormat:(NSString *)dateFormat;

//获取半年前时间
+ (NSString *)getHalfYearBeforeWithDateFormat:(NSString *)dateFormat;

///时间转换（date->string）
+ (NSString *)dateToString:(NSDate *)theDate dateFormat:(NSString *)dateFormat;

///将时间转换成时间戳
+ (NSString *)timeStringToDateString:(NSString *)timeString formatTime:(NSString *)formatTime;

///时间字符串转其他格式字符串  2021-04-07 15:16:03   ----->   2021-04-07 15:16:03
+(NSString *)timeString:(NSString *)timeString timeFormatter:(NSString *)timeFormatter toTimeFormatter:(NSString *)toTimeFormatter;

//加密电话 号码
+(NSString *)encryptPhone:(NSString *)phoneNumber;

//将string竖排
+ (NSString *)verticalStringFrom:(NSString *)sourceStr lineNum:(int)num;

//判断传入的字符串是否为空，为null，若是，则返回””
+ (NSString *)clearNullString:(NSString *)nullString;

//检测app版本
+ (NSString *)getAppVersion;

//获得设备型号
+ (NSString *)getCurrentDeviceModel;



//方法验证类


@end

NS_ASSUME_NONNULL_END
