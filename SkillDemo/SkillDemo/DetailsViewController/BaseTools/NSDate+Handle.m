//
//  NSDate+Handle.m
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import "NSDate+Handle.h"

@implementation NSDate (Handle)

//时间转换（string->date）
+ (NSDate *)stringTodate:(NSString *)datestring dateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *date = [dateFormatter dateFromString:datestring];
    return date;
}

@end
