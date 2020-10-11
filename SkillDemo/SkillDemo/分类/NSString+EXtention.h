//
//  NSString+EXtention.h
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (EXtention)

-(NSMutableAttributedString *)getPriceAttributeOfString:(NSString *)string onRange:(NSRange)pointRange WithColor:(UIColor *)targetColor withTextFont:(CGFloat)fontSize;

- (NSMutableAttributedString *)addImageToString:(NSString *)targetStringName WithImageName:(NSString *)imageName imageFrame:(CGRect)imageFrme toIndex:(NSInteger)index;


///此方法暂未封装，仅供 我的 -- 星级使用
- (NSMutableAttributedString *)addImageArrays:(NSArray *)imagesArray withImageFrame:(UIView *)targetView ToTargetString:(NSString *)targetString inIndex:(NSInteger)index;

//md5加密
+ (NSString *) md5:(NSString *) str;


///字符串转换为时间戳
+ (NSString *)getTimeString:(NSString *)timeString format:(NSString *)format;

+ (BOOL)isBlankString:(NSString *)string;

//为空转空串
+ (NSString *)isNullString:(NSString *)string;

//移除后面的0
+(NSString *)removeZero:(double )dataDouble;

//显示千分位
+(NSString *)thousandsString:(NSString *)String;


/**
 *  检测对象是否为空
 *
 *  @return
 */
extern BOOL isNull(id value);

@end

NS_ASSUME_NONNULL_END
