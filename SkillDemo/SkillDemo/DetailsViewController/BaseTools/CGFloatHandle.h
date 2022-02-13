//
//  CGFloatHandle.h
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGFloatHandle : NSObject

//宽度固定,计算高度
+ (CGFloat)returnHeightWithLabel:(UILabel *)label;

+ (CGFloat)returnHeightWithText:(NSString *)text font:(NSInteger)font width:(CGFloat)width;

+ (CGFloat)returnHeightWithText:(NSString *)text fontName:(NSString *)fontName font:(CGFloat)font width:(CGFloat)width;

//高度固定，计算长度
+ (CGFloat)returnWidthWithLabel:(UILabel *)label;

+ (CGFloat)returnWidthWithText:(NSString *)text font:(NSInteger)font height:(CGFloat)height;

+ (CGFloat)returnWidthWithText:(NSString *)text fontName:(NSString *)fontName font:(NSInteger)font height:(CGFloat)height;


@end

NS_ASSUME_NONNULL_END
