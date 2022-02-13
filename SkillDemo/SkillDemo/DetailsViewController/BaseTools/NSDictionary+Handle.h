//
//  NSDictionary+Handle.h
//  Image
//
//  Created by pjw on 2021/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Handle)

///json转换为字典
+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString;


@end

NS_ASSUME_NONNULL_END
