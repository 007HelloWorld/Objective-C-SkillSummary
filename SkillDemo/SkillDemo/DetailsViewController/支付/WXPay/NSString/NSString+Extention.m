
//
//  NSString+Extention.m
//  ZhiTong
//
//  Created by fuk on 15/11/24.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)

//两位小数取整进一  add by fukai
- (NSString *)roundingValue{
    
    CGFloat value = [self floatValue]*100;
    
    value = ceilf(value)/(CGFloat)100.00f;
    
    NSString * result = [NSString stringWithFormat:@"%.2f",value];
    
    return result;
}

#pragma mark -- Accuracy

/**
 四舍五入
 @param accuracy 精度
 @return NSString *
 */
-(NSString *)roundingValueWithAccuracy:(int)accuracy {
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:accuracy raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithString:self];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

#pragma mark -- MD5

/**
 make MD5 String
 
 @return NSString *
 */
- (NSString *) md5
{
    const char *cStr = [self UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}

//判断两个字符串转换为浮点数时是否相等
- (BOOL)isNumberValueEqualToString:(NSString *)string
{
    double selfNumberValue = [self doubleValue];
    double strngNumberValue = [string doubleValue];
    
    double diff = (selfNumberValue - strngNumberValue);
    
    return (diff > -0.000001 && diff < 0.000001);
}

@end
