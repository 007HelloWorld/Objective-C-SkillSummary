//
//  MethodChainingModel.m
//  SkillDemo
//
//  Created by pjw on 2021/4/11.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "MethodChainingModel.h"

@implementation MethodChainingModel


-(MethodChainingModel *(^)(int))run{
    return  ^(int m){
        NSLog(@"链式编程思想          跑了%d米",m);
        return self;
    };
}

-(MethodChainingModel *(^)(int))eat{
    return  ^(int m){
        NSLog(@"链式编程思想          吃了%d顿",m);
        return self;
    };
}

@end
