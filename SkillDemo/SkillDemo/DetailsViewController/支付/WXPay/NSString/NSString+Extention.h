//
//  NSString+Extention.h
//  ZhiTong
//
//  Created by fuk on 15/11/24.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extention)

- (NSString *)roundingValue;//add by fukai 两位小数取整进一

- (NSString *)roundingValueWithAccuracy:(int)accuracy;//add by fukai 四舍五入

- (NSString *)md5;

//判断两个字符串转换为浮点数时是否相等
- (BOOL)isNumberValueEqualToString:(NSString *)string;

@end
