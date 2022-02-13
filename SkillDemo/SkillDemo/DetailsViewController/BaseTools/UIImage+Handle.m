//
//  UIImage+Handle.m
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import "UIImage+Handle.h"

@implementation UIImage (Handle)

+(UIImage *)stretchableImageWithImgae:(NSString *)name scaleCapWidth:(CGFloat)scaleCapWidth scaleCapHeight:(CGFloat)scaleCapHeight{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * scaleCapWidth;
    CGFloat h = normal.size.height * scaleCapHeight;
    return [normal stretchableImageWithLeftCapWidth:w topCapHeight:h];
}

+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName{
    NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"EVNCustomSearchBar.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *img_path = [bundle pathForResource:imgName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:img_path];
}

@end
