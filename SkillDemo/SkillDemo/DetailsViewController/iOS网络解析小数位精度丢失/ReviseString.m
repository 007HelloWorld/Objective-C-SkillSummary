//
//  ReviseString.m
//  Image
//
//  Created by pjw on 2021/9/1.
//

#import "ReviseString.h"

@implementation ReviseString

-(NSString *)reviseString:(NSString *)string{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [string doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

@end
