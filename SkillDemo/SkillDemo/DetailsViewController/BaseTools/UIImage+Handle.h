//
//  UIImage+Handle.h
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Handle)


+(UIImage *)stretchableImageWithImgae:(NSString *)name scaleCapWidth:(CGFloat)scaleCapWidth scaleCapHeight:(CGFloat)scaleCapHeight;

+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName;

@end

NS_ASSUME_NONNULL_END
