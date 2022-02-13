//
//  NSObject+Handle.h
//  Image
//
//  Created by pjw on 2021/4/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Handle)

#pragma mark - 时间相关操作
///将某个时间Str转化成 时间戳  2021-04-07 15:16:00  ------>  1617779760
- (NSInteger )timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

///将某个时间戳转换成时间 1617779760---------> 2021-04-07 15:16
- (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

///时间字符串转其他格式字符串  2021-04-07 15:16:03   ----->   2021-04-07 15:16:03
-(NSString *)timeString:(NSString *)timeString timeFormatter:(NSString *)timeFormatter toTimeFormatter:(NSString *)toTimeFormatter;

@end

NS_ASSUME_NONNULL_END
