//
//  UIColor+UIColorHandle.h
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Handle)

//可以设置透明度的 16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
