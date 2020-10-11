//
//  JsonString.h
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JsonString : NSObject

/**字典转换为字符串*/
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
/**json转换为字典*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
