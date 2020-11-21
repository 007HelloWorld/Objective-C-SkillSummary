//
//  ZTUtil.h
//  ZhiTong
//
//  Created by wangliang on 16/4/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTUtil : NSObject

//判断是否是空白字符串（含字符串为nil，NULL，NSNull，空格换行几种情况）
+ (BOOL)isBlankString:(NSString *)string;

//判断是否为合法的身份证号
+ (BOOL)isValidateIDCard:(NSString *)idCardString;

//判断是否为合法的日期
+ (BOOL)isValidateDate:(NSString *)dateString;

//判断单个字符是否为数字
+ (BOOL)isDigit:(NSString *)string;

//判断字符串是否由纯数字构成
+ (BOOL)isPureInt:(NSString *)string;

//判断字符串是否为数值(含带小数的数字)
+ (BOOL)isValidateNumber:(NSString *)string;

//判断是否为正确的手机号
+ (BOOL)isValidateMobile:(NSString *)mobileString;

//判断是否为合法的姓名
+ (BOOL)isValidateName:(NSString *)nameString;

//判断是否包含emoji表情字符
+ (BOOL)isContainsEmoji:(NSString *)string;

//判断是否包含特殊字符
+(BOOL)isContainSpecial:(NSString *)string;

//判断是否全为数字+英文的字符串
+ (BOOL)isDigitAndAlpha:(NSString *)string;

//判断是否为固定电话
+ (BOOL)isTelePhoneNum:(NSString *)telePhoneNum;

//判断是否为合法的车牌号
+ (BOOL)isValidatePlateNumber:(NSString *)plateNumberString;

//判断字符串转换为数字是否等于0
+ (BOOL)isStringEqualToZeroNumber:(NSString *)string;

//验证密码单个字符格式
+ (BOOL)isValidateSinglePasswordCharacter:(NSString *)string;

//验证密码格式
+ (BOOL)isValidatePassword:(NSString *)string;

//验证邀请码格式
+ (BOOL)isValidateInviteCode:(NSString *)string;

//验证手机验证码格式
+ (BOOL)isValidateVerifyCode:(NSString *)string;

//验证是否为正确的号码  1-12 位数字
+ (BOOL)isValidatePhoneCallNumber:(NSString *)string;

//将中文(如'三百二十一') 转化成 数字(321)
+ (NSString *)convertChineseToNumber:(NSString *)chineseString;

//验证字符串是否为合法数字
+ (BOOL)validateNumber:(NSString*)number;

//判断对象是否为字典
+ (BOOL)isValidateDict:(id)obj;

//判断对象是否为数组
+ (BOOL)isValidateArray:(id)obj;

//汉字转化成拼音
+ (NSString *)convertToPinYin:(NSString *)chinese;

//拼接省市区 去除重复的区域名称
+ (NSString *)removeduplicationAddressFormateWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area;
//通过拼接省市区 不去除重复的省市
+ (NSString *)addressFormateWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area;
@end
