//
//  DemoUtils.m
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "DemoUtils.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation DemoUtils

//字典转JSON字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//数组转JSON字符串
+ (NSString*)arrayToJson:(NSArray *)array{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
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

/*
//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *)colorWithHexString: (NSString *) stringToConvert{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
*/

//可以设置透明度的 16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (CGSize) getStringSize:(NSString *)string fixHeight:(CGFloat)height useFont:(UIFont *)font{
    CGSize labelSized = CGSizeZero;
    CGRect labelRect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                         attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    
    labelSized = CGSizeMake(labelRect.size.width, labelRect.size.height);
    return labelSized;
}

+ (CGSize) getStringSize:(NSString *)string fixWidth:(CGFloat)width useFont:(UIFont *)font{
    CGSize labelSized = CGSizeZero;
    CGRect labelRect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                         attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    labelSized = CGSizeMake(labelRect.size.width, labelRect.size.height);
    return labelSized;
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

//时间转换（string->date）
+ (NSDate *)stringTodate:(NSString *)datestring dateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *date = [dateFormatter dateFromString:datestring];
    return date;
}

//时间转换（date->string）
+ (NSString *)dateToString:(NSDate *)theDate dateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSString *datestring = [dateFormatter stringFromDate:theDate];
    return datestring;
}

// 判断是否是纯数字 1
+ (BOOL)isPureInteger:(NSString *)str {
    NSCharacterSet *cs=[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filter=[[str componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [str isEqualToString:filter];
}

////清除缓存
//+(void)clearCache:(NSString *)path{
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:path]) {
//        NSArray *childerFiles=[fileManager subpathsAtPath:path];
//        for (NSString *fileName in childerFiles) {
//            //如有需要，加入条件，过滤掉不想删除的文件
//            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
//            [fileManager removeItemAtPath:absolutePath error:nil];
//        }
//    }
//    [[SDImageCache sharedImageCache] cleanDisk];
//}

//手机号是否有效
+(BOOL)isValidPhone:(NSString *)phoneNumber{
    NSString *numRegex = @"^1[3456789]{1}[\\d]{9}";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
    return [numTest evaluateWithObject:phoneNumber];
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

//判断是否是联通号码
+(BOOL)isChinaUnicomMobile:(NSString *)phoneNum {
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CM = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    return [regextestcm evaluateWithObject:phoneNum];
}


//密码是否有效
+(BOOL)isValidPassword:(NSString *)password{
    //特殊符号 -`=\\\[\];',./~!@#$%^&*()_+|{}:"<>?
    NSString *keyRegex = @"[A-Z0-9a-z-`=\\\\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]{6,16}";
    NSPredicate *keyTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", keyRegex];
    return [keyTest evaluateWithObject:password];
}

//密码是否有效(必须是6到18位同时包含大小写字母及数字密码且不包含'^)
+(BOOL)isVerifyPassword:(NSString *)password{
    
    NSString *keyRegex = @"^(?!.*')(?!.*\\^)(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%&*?\\(\\)]).{6,18}$";
    NSPredicate *keyTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", keyRegex];
    return [keyTest evaluateWithObject:password];
}

//验证码是否有效
+(BOOL)isSecurityCode:(NSString*)securitycode{
    NSString *codeRegex=@"[\\d]{6}";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", codeRegex];
    return [codeTest evaluateWithObject:securitycode];
}

//是否为空字符串
+(BOOL)isSpaceOrEmpty:(NSString*)string{
    NSString *regex=@"^\\s*";
    NSPredicate * test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:string];
}

//校验用户名,允许中文，英文，数字且不允许纯数字
+(BOOL)isValidUsername:(NSString*)string{
    NSString *regex = @"(?!\\d+$)[\\da-zA-Z0-9\u4e00-\u9fa5]+";//允许中文，英文，数字且不允许纯数字
    NSPredicate * test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:string];
}

//邮箱
+(BOOL)isValidEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//身份证号
+(BOOL)isValidIDCard:(NSString *)idStr{
    NSString *regexIDCard=@"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    NSPredicate *idCardTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexIDCard];
    return [idCardTest evaluateWithObject:idStr];
}


+(UIImage *)stretchableImageWithImgae:(NSString *)name scaleCapWidth:(CGFloat)scaleCapWidth scaleCapHeight:(CGFloat)scaleCapHeight{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * scaleCapWidth;
    CGFloat h = normal.size.height * scaleCapHeight;
    return [normal stretchableImageWithLeftCapWidth:w topCapHeight:h];
}

+ (CGSize)returnSize:(NSString *)content font:(NSInteger)font{
    CGSize size = [content boundingRectWithSize:CGSizeMake(500, 1000) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
    return size;
}

//长度固定计算高度
+ (CGFloat)returnHeightWithLabel:(UILabel *)label{
    //小数向上取整
    return  ceilf([label.text boundingRectWithSize:CGSizeMake(label.width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size.height);
}

+ (CGFloat)returnHeightWithText:(NSString *)text font:(NSInteger)font width:(CGFloat)width{
    //小数向上取整
    return ceilf([text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.height);
}

+ (CGFloat)returnHeightWithText:(NSString *)text fontName:(NSString *)fontName font:(CGFloat)font width:(CGFloat)width{
    //小数向上取整
    return ceilf([text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:fontName size:font]} context:nil].size.height);
}

//高度固定，计算长度
+ (CGFloat)returnWidthWithLabel:(UILabel *)label{
    //小数向上取整
    return ceilf([label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, CGRectGetHeight(label.frame))
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{NSFontAttributeName:label.font} context:nil].size.width);
}

+ (CGFloat)returnWidthWithText:(NSString *)text font:(NSInteger)font height:(CGFloat)height{
    //小数向上取整
    return  ceilf([text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.width);
}

+ (CGFloat)returnWidthWithText:(NSString *)text fontName:(NSString *)fontName font:(NSInteger)font height:(CGFloat)height{
    //小数向上取整
    return  ceilf([text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:fontName size:font]} context:nil].size.width);
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

+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName{
    NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"EVNCustomSearchBar.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *img_path = [bundle pathForResource:imgName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:img_path];
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

+ (NSDictionary *)getProvinceConfigInfo {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *plistDic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    //    NSLog(@"---%@",plistDic[@"BRegionAPPID"]);
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"ProvinceConfig" ofType:@"plist"];
    NSDictionary *configDic = [NSDictionary dictionaryWithContentsOfFile:configPath];
    NSDictionary *config = configDic[plistDic[@"BRegionAPPID"]];
    //    NSLog(@"config---%@",config);
    return config;
}

//判断手机 是否使用代理了
+ (BOOL)isConnectedToProxy{
    NSDictionary *proxySettings = (__bridge NSDictionary *)CFNetworkCopySystemProxySettings();
    NSArray * proxies = (__bridge NSArray *)CFNetworkCopyProxiesForURL((__bridge CFURLRef)[NSURL URLWithString:@"https://www.apple.com"], (__bridge CFDictionaryRef)proxySettings);
    NSDictionary *settings = [proxies objectAtIndex:0];
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        //没有设置代理
        return NO;
    }else{
        //设置代理了
        return YES;
    }
}

//随机排序 数组  随机键盘
+ (NSArray *)sortedArray:(NSArray *)array{
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    return sortedArray;
}

#pragma 图片的压处理
+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280&&height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280&&height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280&&height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
        
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData * data = UIImageJPEGRepresentation(newImage,0.5f);
    
//    NSLog(@"图片大小KB====%lf",data.length/1024.0);
    
    if (data.length > 300*1024) {
        if (data.length > 1024*1024) {//1M以及以上
            data = UIImageJPEGRepresentation(newImage, 0.35);
        }else if (data.length > 512*1024) {//0.5M-1M
            data = UIImageJPEGRepresentation(newImage, 0.4);
        }else if (data.length > 300*1024) {//0.25M-0.5M
            data = UIImageJPEGRepresentation(newImage, 0.45);
        }
    }
    
    return data;
}

//为空转空串
+ (NSString *)isNullString:(NSString *)string{
    
    if ([string isEqual:[NSNull null]]) {
        return @"";
    }else if (string == nil || string == NULL) {
        return @"";
    }else if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return @"";
    }
    
    return string;
}

@end
