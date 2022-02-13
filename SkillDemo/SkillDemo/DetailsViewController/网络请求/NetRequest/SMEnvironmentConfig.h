//
//  SMEnvironmentConfig.h
//  SMProject
//
//  Created by lk on 2019/3/15.
//  Copyright © 2019 浩哥哥. All rights reserved.
//

#import <Foundation/Foundation.h>

//生产
static NSString *const JPUSH_APPKEY = @"d205157afdbb491ec203700e";

typedef enum : NSUInteger {
    SMEnvironmentConfigTypeOnline,//生产环境
    SMEnvironmentConfigTypeUat,// uat环境
    SMEnvironmentConfigTypeBluetooth,//蓝牙环境
} SMEnvironmentConfigType;

@interface SMEnvironmentConfig : NSObject

+ (void)setHostConfig:(SMEnvironmentConfigType)environmentConfigType;

@end

