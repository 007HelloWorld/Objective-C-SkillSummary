//
//  CGFloatHandle.m
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import "CGFloatHandle.h"
#import "UIView+Extention.h"

@implementation CGFloatHandle


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

@end
