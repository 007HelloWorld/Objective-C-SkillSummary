//
//  MethodChainingModel.h
//  SkillDemo
//
//  Created by pjw on 2021/4/11.
//  Copyright © 2021 pjw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MethodChainingModel : NSObject

-(MethodChainingModel *(^)(int))run;

-(MethodChainingModel *(^)(int))eat;

@end

NS_ASSUME_NONNULL_END
