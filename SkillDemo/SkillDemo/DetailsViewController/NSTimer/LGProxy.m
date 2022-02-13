//
//  LGProxy.m
//  SkillDemo
//
//  Created by pjw on 2021/3/27.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "LGProxy.h"
#import <objc/runtime.h>

@implementation LGProxy

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [self.target methodSignatureForSelector:sel];
}

-(void)forwardInvocation:(NSInvocation *)invocation{
    [invocation invokeWithTarget:self.target];
}

@end
