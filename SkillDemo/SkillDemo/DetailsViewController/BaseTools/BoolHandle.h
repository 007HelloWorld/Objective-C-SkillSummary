//
//  BoolHandle.h
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BoolHandle : NSObject

// 判断是否是纯数字 1
+ (BOOL)isPureInteger:(NSString *)str;

//清除缓存
//+(void)clearCache:(NSString *)path;

//手机号是否有效
+(BOOL)isValidPhone:(NSString *)phoneNumber;

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

//判断手机  是否使用代理了
+ (BOOL)isConnectedToProxy;

@end

NS_ASSUME_NONNULL_END
