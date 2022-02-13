//
//  CUCFStringMacrocDefine.h
//  CatPaw
//
//  Created by lk on 2017/6/19.
//  Copyright © 2017年 lk. All rights reserved.
//

/**
 *  文件描述
 *
 *  这个工具宏封装了大部分字符串常用的便捷方法
 */

#import "CUCFStringUitil.h"

/**
 *  字符串是否为空
 */
#define CUCFStringIsNull(string) [CUCFStringUitil stringIsNull:string]

/**
 *  字符串是否全为空格
 */
#define CUCFStringIsAllWhiteSpace(string) [CUCFStringUitil stringIsAllWhiteSpace:string]

/**
 *  字符串转NSInteger
 */
#define CUCFStringToInt(string) [CUCFStringUitil stringToInt:string]

/**
 *  字符串转CGFloat
 */
#define CUCFStringToFloat(string) [CUCFStringUitil stringToFloat:string]

/**
 *  字符串转double
 */
#define CUCFStringToDouble(string) [CUCFStringUitil stringToDouble:string]

/**
 *  字符串转Bool
 */
#define CUCFStringToBool(string) [CUCFStringUitil stringToBool:string]

/**
 *  int转字符串
 */
#define CUCFStringFromInt(int) [CUCFStringUitil intToString:int]

/**
 *  float转字符串
 */
#define CUCFStringFromFloat(float) [CUCFStringUitil floatToString:float]

/**
 *  double转字符串
 */
#define CUCFStringFromDouble(double) [CUCFStringUitil doubleToString:double]

/**
 *  bool转字符串
 */
#define CUCFStringFromBool(bool) [CUCFStringUitil boolToString:bool]

/**
 *  字符串是否合法邮箱
 */
#define CUCFStringIsEmail(string) [CUCFStringUitil stringIsValidateEmailAddress:string]

/**
 *  字符串是否合法手机号码
 */
#define CUCFStringIsMobilePhone(string) [CUCFStringUitil stringISValidateMobilePhone:string]

/**
 *  字符串是否合法url
 */
#define CUCFStringIsUrl(string) [CUCFStringUitil stringIsValidateUrl:string]

/**
 *  字符串是否合法座机
 */
#define CUCFStringIsPhone(string) [CUCFStringUitil stringIsValidatePhone:string]

/**
 *  字符串是否合法邮政编码
 */
#define CUCFStringIsMailCode(string) [CUCFStringUitil stringIsValidateMailCode:string]

/**
 *  字符串是否合法身份证号
 */
#define CUCFStringIsPersonCardNumber(string) [CUCFStringUitil stringISValidatePersonCardNumber:string]

/**
 *  字符串是否合法车牌号
 */
#define CUCFStringIsCarNumber(string) [CUCFStringUitil stringISValidateCarNumber:string]

/**
 *  字符串是否只有中文字符
 */
#define CUCFStringChineseOnly(string) [CUCFStringUitil stringIsAllChineseWord:string]

/**
 *  字符串是否只有英文字符
 */
#define CUCFStringCharNumOnly(string) [CUCFStringUitil stringJustHasNumberAndCharacter:string]

/**
 *  字符串是否只包含字符，中文，数字
 */
#define CUCFStringCharNumChineseOnly(string) [CUCFStringUitil stringChineseNumberCharacterOnly:string]

/**
 *  字符串是否纯数字
 */
#define CUCFStringNumOnly(string) [CUCFStringUitil stringJustHasNumber:string]

//^(?=([0-9]{1,10}$|[0-9]{1,4}\.))(0|[1-9][0-9]*)(\.[0-9]{1,2})?$ 验证位数 四位 有效 数字+ 2位小数
#define CUCFStringIsFourNumberWithSecond(string) [CUCFStringUitil stringIsFourNumberWithSecond:string]

/**
 字符串是否只包含数字 字母
 */
#define CUCFStringNumOnlyAndEn(string) [CUCFStringUitil stringIsOnlyNumberAndEnCode:string]

/**
 *  从文件中读取出字符串
 */
#define CUCFStringFromFile(path) [CUCFStringUitil stringFromFile:path]

/**
 *  从归档路径读取出字符串
 */
#define CUCFStringUnArchieve(path) [CUCFStringUitil unarchieveFromPath:path]

/**
 *  获取一个当前时间戳字符串
 */
#define CUCFStringCurrentTimeStamp [CUCFStringUitil currentTimeStampString]

/**
 *  将字符串转为MD5字符串
 */
#define CUCFStringToMD5(string) [CUCFStringUitil MD5:string]

/**
 *  返回去除字符串首的空格的字符串
 */
#define CUCFStringClearLeadingWhiteSpace(string) [CUCFStringUitil stringByTrimingLeadingWhiteSpace:string]

/**
 *  返回去除字符串结尾的空格的字符串
 */
#define CUCFStringClearTailingWhiteSpace(string) [CUCFStringUitil stringByTrimingTailingWhiteSpace:string]

/**
 *  返回去除字符串中所有的空格的字符串
 */
#define CUCFStringClearAllWhiteSpace(string) [CUCFStringUitil stringByTrimingWhiteSpace:string]

/**
 *  Url编码对象,通常是字符串,返回编码后的字符串
 */
#define CUCFStringEncodeString(string) [CUCFStringUitil urlEncode:string]

/**
 *  Url解码
 */
#define CUCFStringDecodeString(string) [CUCFStringUitil urlDecode:string]

/**
 *  Url编码一个字典,键值对用@链接,返回编码后的字符串
 */
#define CUCFStringEncodeDict(aDict) [CUCFStringUitil encodeStringFromDict:aDict]

/**
 *  返回字符串范围
 */
#define CUCFStringRange(string) [CUCFStringUitil stringRange:string]

/**
 *  根据字典返回json字符串 失败就是nil
 */
#define CUCFJSONStringFromNSDict(dict) [CUCFStringUitil jsonStringFromNSDictionary:dict]

/**
 *  根据json字符串返回字典 失败就是nil
 */
#define CUCFDictionaryFromJSONString(string) [CUCFStringUitil dictionaryFromJSONString:string]

/**
 *  根据json字符串返回array 失败就是nil
 */
#define CUCFJSONStringFromNSArray(array) [CUCFStringUitil jsonStringFromNSArray:array]

/**
 *  根据array返回json字符串 失败就是nil
 */
#define CUCFArrayFromJSONString(string) [CUCFStringUitil arrayFromJSONString:string]

/**
 *  Unicode转UTF-8 中文表情 ✌️
 */
#define CUCFReplaceUnicodeString(string) [CUCFStringUitil replaceUnicode:string]

/**
 *  是否包含emoji标签
 *  @return YES 包含 NO 不包含
 */
#define CUCFStringIsContainEmoji(string) [CUCFStringUitil stringIsContainEmoji:string]

/**
 *  获取 MAC 地址
 *  @return YES 包含 NO 不包含
 */
#define CUCFStringGetMacAddress [CUCFStringUitil getMacAddress]

/**
 *  字符串去除小数点
 */
#define CUCFStringFilterDecimalPoint(string) [CUCFStringUitil filterDecimalPoint:string]
