//
//  CGSizeHandle.m
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import "CGSizeHandle.h"

@implementation CGSizeHandle

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

+ (CGSize)returnSize:(NSString *)content font:(NSInteger)font{
    CGSize size = [content boundingRectWithSize:CGSizeMake(500, 1000) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
    return size;
}


@end
