//
//  ResidentThread.h
//  SkillDemo
//
//  Created by pjw on 2020/10/6.
//  Copyright © 2020 pjw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResidentThread : NSObject
+(NSThread *)shareThread;

@end

NS_ASSUME_NONNULL_END
