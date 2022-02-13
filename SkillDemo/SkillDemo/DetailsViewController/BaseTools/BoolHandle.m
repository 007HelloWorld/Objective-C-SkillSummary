//
//  BoolHandle.m
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import "BoolHandle.h"

@implementation BoolHandle

// 判断是否是纯数字 1
+ (BOOL)isPureInteger:(NSString *)str {
    NSCharacterSet *cs=[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filter=[[str componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [str isEqualToString:filter];
}

//手机号是否有效
+(BOOL)isValidPhone:(NSString *)phoneNumber{
    NSString *numRegex = @"^1[3456789]{1}[\\d]{9}";
    NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
    return [numTest evaluateWithObject:phoneNumber];
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

//校验用户名,允许中文，英文，数字且不允许纯数字
+(BOOL)isValidUsername:(NSString*)string{
    NSString *regex = @"(?!\\d+$)[\\da-zA-Z0-9\u4e00-\u9fa5]+";//允许中文，英文，数字且不允许纯数字
    NSPredicate * test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:string];
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




@end
