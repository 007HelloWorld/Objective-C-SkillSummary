//
//  DemoUtils.h
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoUtils : NSObject

//数组转JSON字符串
+ (NSString*)arrayToJson:(NSArray *)array;

//字典转JSON字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//取document路径
+ (NSString *)documentPath;

//16进制颜色(html颜色值)字符串转为UIColor
//+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

//可以设置透明度的 16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

+ (CGSize) getStringSize:(NSString *)string fixHeight:(CGFloat)height useFont:(UIFont *)font;

+ (CGSize) getStringSize:(NSString *)string fixWidth:(CGFloat)width useFont:(UIFont *)font;

//获取当前时间
+ (NSString *)getCurrentTimeWithDateFormat:(NSString *)dateFormat;

//获取当前时间前一月
+ (NSString *)getLastOneMonthWithDateFormat:(NSString *)dateFormat;

//获取当前时间 的 前几个月
+ (NSString *)getLastUnknownMonthWithDateFormat:(NSString *)dateFormat num:(NSInteger )num;

//中文月份转 英文月份
+ (NSString *)englishMonth:(NSString *)dateMonth;
    
//获取当前时间前一天
+ (NSString *)getLastOneDayWithDateFormat:(NSString *)dateFormat;

//获取半年前时间
+ (NSString *)getHalfYearBeforeWithDateFormat:(NSString *)dateFormat;

//时间转换（string->date）
+ (NSDate *)stringTodate:(NSString *)datestring dateFormat:(NSString *)dateFormat;

//时间转换（date->string）
+ (NSString *)dateToString:(NSDate *)theDate dateFormat:(NSString *)dateFormat;

// 判断是否是纯数字 1
+ (BOOL)isPureInteger:(NSString *)str;

//清除缓存
//+(void)clearCache:(NSString *)path;

//手机号是否有效
+(BOOL)isValidPhone:(NSString *)phoneNumber;

//加密电话 号码
+(NSString *)encryptPhone:(NSString *)phoneNumber;

//判断是否是联通号码
+(BOOL)isChinaUnicomMobile:(NSString *)phoneNum;

//密码是否有效
+(BOOL)isValidPassword:(NSString *)password;

//密码是否有效(必须是6到18位同时包含大小写字母及数字密码且不包含'^)
+(BOOL)isVerifyPassword:(NSString *)password;

//验证码是否有效
+(BOOL)isSecurityCode:(NSString*)securitycode;

//是否为空字符串
+(BOOL)isSpaceOrEmpty:(NSString*)string;

//邮箱
+(BOOL)isValidEmail:(NSString *)email;

//身份证号
+(BOOL)isValidIDCard:(NSString *)idStr;

//校验用户名,允许中文，英文，数字且不允许纯数字
+(BOOL)isValidUsername:(NSString*)string;

//获取字体长高
+ (CGSize)returnSize:(NSString *)content font:(NSInteger)font;

//宽度固定,计算高度
+ (CGFloat)returnHeightWithLabel:(UILabel *)label;
+ (CGFloat)returnHeightWithText:(NSString *)text font:(NSInteger)font width:(CGFloat)width;
+ (CGFloat)returnHeightWithText:(NSString *)text fontName:(NSString *)fontName font:(CGFloat)font width:(CGFloat)width;

//高度固定，计算长度
+ (CGFloat)returnWidthWithLabel:(UILabel *)label;
+ (CGFloat)returnWidthWithText:(NSString *)text font:(NSInteger)font height:(CGFloat)height;
+ (CGFloat)returnWidthWithText:(NSString *)text fontName:(NSString *)fontName font:(NSInteger)font height:(CGFloat)height;

//将string竖排
+ (NSString *)verticalStringFrom:(NSString *)sourceStr lineNum:(int)num;

/**
 *  返回一张可以随意拉伸不变形的图片
 *  @param name 图片名字
 *  @param scaleCapWidth 距离左边拉伸的位置(比例)
 *  @param scaleCapHeight 距离右边拉伸的位置(比例)
 */
+(UIImage *)stretchableImageWithImgae:(NSString *)name scaleCapWidth:(CGFloat)scaleCapWidth scaleCapHeight:(CGFloat)scaleCapHeight;

//判断传入的字符串是否为空，为null，若是，则返回””
+ (NSString *)clearNullString:(NSString *)nullString;

+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName;


//检测app版本
+ (NSString *)getAppVersion;

//获得设备型号
+ (NSString *)getCurrentDeviceModel;

//获取省份配置信息 appId, provId..
+ (NSDictionary *)getProvinceConfigInfo;

//判断手机  是否使用代理了
+ (BOOL)isConnectedToProxy;

//随机排序 数组  随机键盘
+ (NSArray *)sortedArray:(NSArray *)array;

//为空转空串
+ (NSString *)isNullString:(NSString *)string;


#pragma 图片的压处理
+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage;



@end

NS_ASSUME_NONNULL_END
