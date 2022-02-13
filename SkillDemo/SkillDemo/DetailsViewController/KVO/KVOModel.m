//
//  KVOModel.m
//  SkillDemo
//
//  Created by pjw on 2021/4/11.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "KVOModel.h"



@implementation KVOModel

//模式调整
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    if ([key isEqualToString:@"age"]) {
        return NO;
    }
    return YES;
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        _dog = [KVODog new];
    }
    return self;
}

//如果想要监听里面所有值的更改
+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key{
    NSSet * keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString:@"dog"]) {
        keyPaths = [[NSSet alloc]initWithObjects:@"_dog.age",@"_dog.level", nil];
    }
    return keyPaths;
}


@end
