//
//  AFTool.h
//  citycustomization
//
//  Created by 浩哥哥 on 2018/8/18.
//  Copyright © 2018年 GDMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


@interface AFTool : NSObject
+ (AFHTTPSessionManager *)manager;
+ (AFHTTPSessionManager *)robManager;
+ (AFHTTPSessionManager *)managerWithType:(NSString *)contentType;
@end
