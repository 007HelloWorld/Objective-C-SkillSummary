//
//  NSData+Handle.h
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Handle)

+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage;

@end

NS_ASSUME_NONNULL_END
