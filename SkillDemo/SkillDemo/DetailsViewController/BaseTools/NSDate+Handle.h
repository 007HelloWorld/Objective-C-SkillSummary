//
//  NSDate+Handle.h
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Handle)

//时间转换（string->date）
+ (NSDate *)stringTodate:(NSString *)datestring dateFormat:(NSString *)dateFormat;


@end

NS_ASSUME_NONNULL_END
