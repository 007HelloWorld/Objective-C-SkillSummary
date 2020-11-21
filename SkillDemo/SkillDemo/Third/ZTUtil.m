//
//  ZTUtil.m
//  ZhiTong
//
//  Created by wangliang on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZTUtil.h"

// 匹配1开头的11个数字
#define REGEX_MOBILE @"^1\\d{10}$"

@implementation ZTUtil

//私有，获取地址编码
+ (NSDictionary *)getAreaCode {
    NSMutableDictionary *areaCodeDict = [[NSMutableDictionary alloc] init];
    [areaCodeDict setObject:@"北京" forKey:@"11"];
    [areaCodeDict setObject:@"天津" forKey:@"12"];
    [areaCodeDict setObject:@"河北" forKey:@"13"];
    [areaCodeDict setObject:@"山西" forKey:@"14"];
    [areaCodeDict setObject:@"内蒙古" forKey:@"15"];
    [areaCodeDict setObject:@"辽宁" forKey:@"21"];
    [areaCodeDict setObject:@"吉林" forKey:@"22"];
    [areaCodeDict setObject:@"黑龙江" forKey:@"23"];
    [areaCodeDict setObject:@"上海" forKey:@"31"];
    [areaCodeDict setObject:@"江苏" forKey:@"32"];
    [areaCodeDict setObject:@"浙江" forKey:@"33"];
    [areaCodeDict setObject:@"安徽" forKey:@"34"];
    [areaCodeDict setObject:@"福建" forKey:@"35"];
    [areaCodeDict setObject:@"江西" forKey:@"36"];
    [areaCodeDict setObject:@"山东" forKey:@"37"];
    [areaCodeDict setObject:@"河南" forKey:@"41"];
    [areaCodeDict setObject:@"湖北" forKey:@"42"];
    [areaCodeDict setObject:@"湖南" forKey:@"43"];
    [areaCodeDict setObject:@"广东" forKey:@"44"];
    [areaCodeDict setObject:@"广西" forKey:@"45"];
    [areaCodeDict setObject:@"海南" forKey:@"46"];
    [areaCodeDict setObject:@"重庆" forKey:@"50"];
    [areaCodeDict setObject:@"四川" forKey:@"51"];
    [areaCodeDict setObject:@"贵州" forKey:@"52"];
    [areaCodeDict setObject:@"云南" forKey:@"53"];
    [areaCodeDict setObject:@"西藏" forKey:@"54"];
    [areaCodeDict setObject:@"陕西" forKey:@"61"];
    [areaCodeDict setObject:@"甘肃" forKey:@"62"];
    [areaCodeDict setObject:@"青海" forKey:@"63"];
    [areaCodeDict setObject:@"宁夏" forKey:@"64"];
    [areaCodeDict setObject:@"新疆" forKey:@"65"];
    [areaCodeDict setObject:@"台湾" forKey:@"71"];
    [areaCodeDict setObject:@"香港" forKey:@"81"];
    [areaCodeDict setObject:@"澳门" forKey:@"82"];
    [areaCodeDict setObject:@"国外" forKey:@"91"];
    return areaCodeDict;
}

//判断是否是空白字符串（含字符串为nil，NULL，NSNull，空格换行几种情况）
+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil) {
        return YES;
    }

    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if (![string isKindOfClass:[NSString class]]) {
        string = [NSString stringWithFormat:@"%@", string];
    }
    
    if ([string isEqualToString:@"NSNull"]) {
        return YES;
    }

    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }

    return NO;
}

//判断单个字符是否为数字
+ (BOOL)isDigit:(NSString *)string {
    
    NSString *regex = @"^\\d$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:string];
    if (isMatch) {
        return YES;
    }
    
    return NO;
}

//判断字符串是否由纯数字构成
+ (BOOL)isPureInt:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//判断字符串是否为数值(含带小数的数字)
+ (BOOL)isValidateNumber:(NSString *)string {
    
    NSString *regex = @"^\\d+(\\.\\d+)?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:string];
    if (isMatch) {
        return YES;
    }
    
    return NO;
}

//判断是否为合法的日期
+ (BOOL)isValidateDate:(NSString *)dateString {

    NSString *regex = @"^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\\s(((0?[0-9])|([1-2][0-3]))\\:([0-5]?[0-9])((\\s)|(\\:([0-5]?[0-9])))))?$";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:dateString];

    if (isMatch) {
        return YES;
    }
    return NO;
}

//ref http://www.tuicool.com/articles/Bv2Avy
//判断是否为合法的身份证号 (验证失败返回错误信息，验证成功返回nil)
+ (BOOL)isValidateIDCard:(NSString *)idCardString {
//    NSString *errorInfo = nil;// 记录错误信息
    NSString *valCodeArr[] = { @"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4",
                               @"3", @"2" };
    NSString *Wi[] = { @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7",
                       @"9", @"10", @"5", @"8", @"4", @"2" };
    NSString *Ai = @"";
    if ([idCardString hasSuffix:@"x"]) {
        idCardString = [idCardString stringByReplacingCharactersInRange:NSMakeRange(idCardString.length-1, 1) withString:@"X"];
    }

    //判断号码的长度是否为 15位或18位
    if (idCardString.length == 15 || idCardString.length == 18) {
//        errorInfo = nil;
    } else {
//        errorInfo = @"身份证号码长度应该为15位或18位。";
        return NO;
    }

    //判断数字是否 除最后一位都为数字
    if (idCardString.length == 18) {
        Ai = [idCardString substringWithRange:NSMakeRange(0, idCardString.length-1)];
    } else if (idCardString.length == 15) {
        Ai = [NSString stringWithFormat:@"%@%@%@", [idCardString substringWithRange:NSMakeRange(0, 6)], @"19", [idCardString substringWithRange:NSMakeRange(6, 9)]];
    }
    if (![ZTUtil isPureInt:Ai]) {
//        errorInfo = @"身份证15位号码都应为数字 ; 18位号码除最后一位外，都应为数字。";
        return NO;
    }

    //判断出生年月是否有效
    NSString *strYear = [Ai substringWithRange:NSMakeRange(6, 4)];// 年份
    NSString *strMonth = [Ai substringWithRange:NSMakeRange(10, 2)];// 月份
    NSString *strDay = [Ai substringWithRange:NSMakeRange(12, 2)];// 月份
    NSString *strDate = [NSString stringWithFormat:@"%@-%@-%@", strYear, strMonth, strDay];
    if (![ZTUtil isValidateDate:strDate]) {
//        errorInfo = @"身份证生日无效。";
        return NO;
    }

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *idCardDate = [dateFormatter dateFromString:strDate];

    NSDate *nowDate = [NSDate date];

    if (([nowDate year] - [strYear intValue]) > 150
        || ([nowDate timeIntervalSince1970] - [idCardDate timeIntervalSince1970]) < 0) {
//        errorInfo = @"身份证生日不在有效范围。";
        return NO;
    }

    if ([strMonth intValue] > 12 || [strMonth intValue] == 0) {
//        errorInfo = @"身份证月份无效";
        return NO;
    }
    if ([strDay intValue] > 31 || [strDay intValue] == 0) {
//        errorInfo = @"身份证日期无效";
        return NO;
    }

    //判断地区码是否有效
    NSDictionary *areaCodeDict = [ZTUtil getAreaCode];
    NSString *areaKey = [Ai substringWithRange:NSMakeRange(0, 2)];
    if ([areaCodeDict objectForKey:areaKey] == nil) {
//        errorInfo = @"身份证地区编码错误。";
        return NO;
    }

    //判断最后一位的值
    int TotalmulAiWi = 0;
    for (int i = 0; i < 17; i++) {
        TotalmulAiWi = TotalmulAiWi + [[NSString stringWithFormat:@"%c", [Ai characterAtIndex:i]] intValue] * [Wi[i] intValue];
    }

    int modValue = TotalmulAiWi % 11;
    NSString *strVerifyCode = valCodeArr[modValue];
    Ai = [NSString stringWithFormat:@"%@%@", Ai, strVerifyCode];

    if (idCardString.length == 18) {
        if (![Ai isEqualToString:idCardString]) {
//            errorInfo = @"身份证无效，不是合法的身份证号码";
            return NO;
        }
    } else {
        return YES;
    }

    return YES;
}

//判断是否为正确的手机号
+ (BOOL)isValidateMobile:(NSString *)mobileString {

    NSString *regex = REGEX_MOBILE;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobileString];

    if (isMatch) {
        return YES;
    }

    return NO;
}

//判断是否为合法的姓名
+ (BOOL)isValidateName:(NSString *)nameString {

    NSString *regex = @"^[\u4E00-\u9FA5]{2,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    BOOL isMatch = [pred evaluateWithObject:nameString];
    if (isMatch) {
        return YES;
    }
    return NO;
}

//判断是否包含emoji表情字符
//ref http://www.unicode.org/Public/emoji/3.0//emoji-data.txt
+ (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;

    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex:0];

                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex:1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;

                                    if ( 0x1F004 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F0CF == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F170 <= codepoint && codepoint <= 0x1F171 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F17E == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F17F == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F18E == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F191 <= codepoint && codepoint <= 0x1F19A ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F1E6 <= codepoint && codepoint <= 0x1F1FF ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F201 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F201 <= codepoint && codepoint <= 0x1F202 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F21A == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F22F == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F232 <= codepoint && codepoint <= 0x1F236 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F232 <= codepoint && codepoint <= 0x1F23A ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F238 <= codepoint && codepoint <= 0x1F23A ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F250 <= codepoint && codepoint <= 0x1F251 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F300 <= codepoint && codepoint <= 0x1F320 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F321 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F324 <= codepoint && codepoint <= 0x1F32C ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F32D <= codepoint && codepoint <= 0x1F32F ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F330 <= codepoint && codepoint <= 0x1F335 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F336 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F337 <= codepoint && codepoint <= 0x1F37C ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F37D == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F37E <= codepoint && codepoint <= 0x1F37F ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F380 <= codepoint && codepoint <= 0x1F393 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F385 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F396 <= codepoint && codepoint <= 0x1F397 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F399 <= codepoint && codepoint <= 0x1F39B ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F39E <= codepoint && codepoint <= 0x1F39F ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3A0 <= codepoint && codepoint <= 0x1F3C4 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3C3 <= codepoint && codepoint <= 0x1F3C4 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3C5 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3C6 <= codepoint && codepoint <= 0x1F3CA ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3CA == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3CB == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3CB <= codepoint && codepoint <= 0x1F3CE ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3CF <= codepoint && codepoint <= 0x1F3D3 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3D4 <= codepoint && codepoint <= 0x1F3DF ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3E0 <= codepoint && codepoint <= 0x1F3F0 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3F3 <= codepoint && codepoint <= 0x1F3F5 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3F4 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3F7 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3F8 <= codepoint && codepoint <= 0x1F3FF ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F3FB <= codepoint && codepoint <= 0x1F3FF ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F400 <= codepoint && codepoint <= 0x1F43E ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F43F == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F440 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F441 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F442 <= codepoint && codepoint <= 0x1F443 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F442 <= codepoint && codepoint <= 0x1F4F7 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F446 <= codepoint && codepoint <= 0x1F450 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F466 <= codepoint && codepoint <= 0x1F469 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F46E == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F470 <= codepoint && codepoint <= 0x1F478 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F47C == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F481 <= codepoint && codepoint <= 0x1F483 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F485 <= codepoint && codepoint <= 0x1F487 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F4AA == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F4F8 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F4F9 <= codepoint && codepoint <= 0x1F4FC ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F4FD == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F4FF == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F500 <= codepoint && codepoint <= 0x1F53D ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F549 <= codepoint && codepoint <= 0x1F54A ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F54B <= codepoint && codepoint <= 0x1F54E ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F550 <= codepoint && codepoint <= 0x1F567 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F56F <= codepoint && codepoint <= 0x1F570 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F573 <= codepoint && codepoint <= 0x1F579 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F575 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F57A == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F587 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F58A <= codepoint && codepoint <= 0x1F58D ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F590 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F595 <= codepoint && codepoint <= 0x1F596 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5A4 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5A5 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5A8 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5B1 <= codepoint && codepoint <= 0x1F5B2 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5BC == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5C2 <= codepoint && codepoint <= 0x1F5C4 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5D1 <= codepoint && codepoint <= 0x1F5D3 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5DC <= codepoint && codepoint <= 0x1F5DE ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5E1 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5E3 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5E8 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5EF == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5F3 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5FA == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F5FB <= codepoint && codepoint <= 0x1F5FF ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F600 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F601 <= codepoint && codepoint <= 0x1F610 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F611 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F612 <= codepoint && codepoint <= 0x1F614 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F615 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F616 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F617 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F618 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F619 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F61A == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F61B == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F61C <= codepoint && codepoint <= 0x1F61E ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F61F == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F620 <= codepoint && codepoint <= 0x1F625 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F626 <= codepoint && codepoint <= 0x1F627 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F628 <= codepoint && codepoint <= 0x1F62B ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F62C == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F62D == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F62E <= codepoint && codepoint <= 0x1F62F ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F630 <= codepoint && codepoint <= 0x1F633 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F634 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F635 <= codepoint && codepoint <= 0x1F640 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F641 <= codepoint && codepoint <= 0x1F642 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F643 <= codepoint && codepoint <= 0x1F644 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F645 <= codepoint && codepoint <= 0x1F647 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F645 <= codepoint && codepoint <= 0x1F64F ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F64B <= codepoint && codepoint <= 0x1F64F ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F680 <= codepoint && codepoint <= 0x1F6C5 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F6A3 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F6B4 <= codepoint && codepoint <= 0x1F6B6 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F6C0 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F6CB <= codepoint && codepoint <= 0x1F6CF ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F6CC == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F6D0 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F6D1 <= codepoint && codepoint <= 0x1F6D2 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F6E0 <= codepoint && codepoint <= 0x1F6E5 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F6E9 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F6EB <= codepoint && codepoint <= 0x1F6EC ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F6F0 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F6F3 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F6F4 <= codepoint && codepoint <= 0x1F6F6 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F910 <= codepoint && codepoint <= 0x1F918 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F918 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F919 <= codepoint && codepoint <= 0x1F91E ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F920 <= codepoint && codepoint <= 0x1F927 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F926 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F930 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F933 <= codepoint && codepoint <= 0x1F939 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F933 <= codepoint && codepoint <= 0x1F93A ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F93C <= codepoint && codepoint <= 0x1F93E ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F940 <= codepoint && codepoint <= 0x1F945 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F947 <= codepoint && codepoint <= 0x1F94B ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F950 <= codepoint && codepoint <= 0x1F95E ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F980 <= codepoint && codepoint <= 0x1F984 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x1F985 <= codepoint && codepoint <= 0x1F991 ) {
                                        ;
                                    }
                                    else if ( 0x1F9C0 == codepoint ) {
                                        returnValue = YES;
                                    }
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if ( 0x00A9 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x00AE == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x203C == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2049 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2122 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2139 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2194 <= high && high <= 0x2199 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x21A9 <= high && high <= 0x21AA ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x231A <= high && high <= 0x231B ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2328 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x23CF == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x23E9 <= high && high <= 0x23EC ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x23E9 <= high && high <= 0x23F3 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x23F0 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x23F3 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x23F8 <= high && high <= 0x23FA ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x24C2 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x25AA <= high && high <= 0x25AB ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x25B6 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x25C0 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x25FB <= high && high <= 0x25FE ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x25FD <= high && high <= 0x25FE ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2600 <= high && high <= 0x2604 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x260E == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2611 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2614 <= high && high <= 0x2615 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2618 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x261D == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2620 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2622 <= high && high <= 0x2623 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2626 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x262A == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x262E <= high && high <= 0x262F ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2638 <= high && high <= 0x263A ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2648 <= high && high <= 0x2653 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2660 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2663 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2665 <= high && high <= 0x2666 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2668 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x267B == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x267F == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2692 <= high && high <= 0x2694 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2693 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2696 <= high && high <= 0x2697 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x2699 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x269B <= high && high <= 0x269C ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26A0 <= high && high <= 0x26A1 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26A1 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26AA <= high && high <= 0x26AB ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26B0 <= high && high <= 0x26B1 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26BD <= high && high <= 0x26BE ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26C4 <= high && high <= 0x26C5 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26C8 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26CE == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26CF == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26D1 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26D3 <= high && high <= 0x26D4 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26D4 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26E9 <= high && high <= 0x26EA ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26EA == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26F0 <= high && high <= 0x26F5 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26F2 <= high && high <= 0x26F3 ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26F5 == high ) {
                                        returnValue = YES;
                                    }
                                    else if ( 0x26F7 <= high && high <= 0x26FA ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x26F9 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x26FA == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x26FD == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2702 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2705 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2708 <= high && high <= 0x2709 ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x270A <= high && high <= 0x270B ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x270C <= high && high <= 0x270D ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x270F == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2712 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2714 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2716 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x271D == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2721 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2728 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2733 <= high && high <= 0x2734 ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2744 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2747 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x274C == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x274E == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2753 <= high && high <= 0x2755 ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2757 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2763 <= high && high <= 0x2764 ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2795 <= high && high <= 0x2797 ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x27A1 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x27B0 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x27BF == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2934 <= high && high <= 0x2935 ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2B05 <= high && high <= 0x2B07 ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2B1B <= high && high <= 0x2B1C ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2B50 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x2B55 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x3030 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x303D == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x3297 == high ) { 
                                        returnValue = YES;
                                    }
                                    else if ( 0x3299 == high ) { 
                                        returnValue = YES;
                                    }
                                }
    }];

    return returnValue;
}


//判断是否包含特殊字符
+(BOOL)isContainSpecial:(NSString *)string{
    //***需要过滤的特殊字符：~%-=,."'?\\￥£¥•#:;&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [string rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~%-=,.\"'?\\￥£¥•#:;&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€!？！@#￥%……&*（）——+{}【】；：“‘，。、？……"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    
    return YES;
}

//判断是否全为数字+英文的字符串
+ (BOOL)isDigitAndAlpha:(NSString *)string {
    
    NSString *regex = @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    
    if (isMatch) {
        return YES;
    }
    return NO;
}

//判断是否为固定电话
+ (BOOL)isTelePhoneNum:(NSString *)telePhoneNum
{
    NSString *regex = @"(^0[0-9]{10,11}$)|(^[4][0][0][0-9]{7}$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:telePhoneNum];
    if (isMatch) {
        return YES;
    }
    
    return NO;
}

//判断是否为合法的车牌号
+ (BOOL)isValidatePlateNumber:(NSString *)plateNumberString {
    NSString *regex = @"^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z,0-9]{5}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:plateNumberString];
    if(isMatch) {
        return YES;
    }
    return NO;
}

//判断字符串转换为数字是否等于0
+ (BOOL)isStringEqualToZeroNumber:(NSString *)string {
    double value = [string doubleValue];
    
    return (value > -0.000001 && value < 0.000001);
}

//验证密码单个字符格式
+ (BOOL)isValidateSinglePasswordCharacter:(NSString *)string {
    
    //匹配 A-Za-z0-9 还有 ~!@#$%&*_-+
    NSString *regex = @"^[A-Za-z0-9~\\!@#\\$%&\\*_\\-\\+]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    
    if (isMatch) {
        return YES;
    }
    return NO;
}

//验证密码格式
+ (BOOL)isValidatePassword:(NSString *)string {
    
    NSString *regex = @"^[A-Za-z0-9~\\!@#\\$%&\\*_\\-\\+]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    
    if (isMatch) {
        return YES;
    }
    return NO;
}

//验证邀请码格式
+ (BOOL)isValidateInviteCode:(NSString *)string {
    
    NSString *regex = @"^\\d{11}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    
    if (isMatch) {
        return YES;
    }
    return NO;
}

//验证手机验证码格式
+ (BOOL)isValidateVerifyCode:(NSString *)string {
    
    NSString *regex = @"^\\d{6}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    
    if (isMatch) {
        return YES;
    }
    
    return NO;
}
//验证是否为正确的号码  1-12 位数字
+ (BOOL)isValidatePhoneCallNumber:(NSString *)string {
    
    NSString *regex = @"^\\d{1,12}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    
    if (isMatch) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)canMakeTelephoneCall {
    
    NSString *deviceType = [UIDevice currentDevice].model;
    if([[deviceType lowercaseString] rangeOfString:@"ipod"].length > 0 ||
       [[deviceType lowercaseString] rangeOfString:@"ipad"].length > 0) {
        return NO;
    }
    
#ifdef DEBUG
    NSString *deviceName = [UIDevice currentDevice].name;
    if([[deviceName lowercaseString] rangeOfString:@"simulator"].length > 0) {
        return NO;
    }
#endif
    
    return YES;
}

//将中文(如'三百二十一') 转化成 数字(321)
+ (NSString *)convertChineseToNumber:(NSString *)chineseString {
    
    NSDictionary *chineseNumberDict = @{@"零":@(0),@"一":@(1),@"二":@(2),@"两":@(2),@"三":@(3),@"四":@(4),
                                        @"五":@(5),@"六":@(6),@"七":@(7),@"八":@(8),@"九":@(9),
                                        @"十":@(10),@"百":@(100),@"千":@(1000),@"万":@(10000),@"亿":@(100000000)};
    
    if (chineseString.length == 0) {
        return nil;
    }
    
    NSString *resultString = nil;
    if (chineseString.length > 0) {
        long total = 0;
        int r = 1;
        for (int i=(int)(chineseString.length-1); i>=0; i--) {
            NSString *key = [chineseString substringWithRange:NSMakeRange(i, 1)];
            
            int val = [chineseNumberDict[key] intValue];
            if (val >= 10 && 0 == i) {
                if (val > r) {
                    r = val;
                    total += val;
                }
                else {
                    r *= val;
                }
            }
            else if (val >= 10) {
                if (val > r) {
                    r = val;
                }
                else {
                    r = r * val;
                }
            }
            else {
                total = total +  r * val;
            }
        }
        
        resultString = [NSString stringWithFormat:@"%ld", total];
    }
    
    return resultString;
}

+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString *string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+ (BOOL)isValidateDict:(id)obj {
    
    return (obj && [obj isKindOfClass:[NSDictionary class]]);
}

+ (BOOL)isValidateArray:(id)obj {
    return (obj && [obj isKindOfClass:[NSArray class]]);
}

+ (NSString *)convertToPinYin:(NSString *)chinese {
    
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    return [pinyin uppercaseString];
}

+ (NSString *)removeduplicationAddressFormateWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area {
    NSMutableString *formateString = [[NSMutableString alloc] init];
    NSString *currentProvince = [self isBlankString:province] ? @"" : province;
    NSString *currentCity = [self isBlankString:city] ? @"" : city;
    NSString *currentZone = [self isBlankString:area] ? @"" : area;
    [formateString appendString:currentProvince];
    if (![currentProvince isEqualToString:currentCity]) {
        [formateString appendString:currentCity];
    }
    if (![currentCity isEqualToString:currentZone]) {
        [formateString appendString:currentZone];
    }
    return formateString;
}
+ (NSString *)addressFormateWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area {
    NSMutableString *formateString = [[NSMutableString alloc] init];
    NSString *currentProvince = [self isBlankString:province] ? @"" : province;
    NSString *currentCity = [self isBlankString:city] ? @"" : city;
    NSString *currentZone = [self isBlankString:area] ? @"" : area;
    [formateString appendString:[NSString stringWithFormat:@"%@%@%@",currentProvince,currentCity,currentZone]];
    return formateString;
}
@end
