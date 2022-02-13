//
//  CGSizeHandle.h
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGSizeHandle : NSObject

+ (CGSize) getStringSize:(NSString *)string fixHeight:(CGFloat)height useFont:(UIFont *)font;

+ (CGSize) getStringSize:(NSString *)string fixWidth:(CGFloat)width useFont:(UIFont *)font;

//获取字体长高
+ (CGSize)returnSize:(NSString *)content font:(NSInteger)font;



@end

NS_ASSUME_NONNULL_END
