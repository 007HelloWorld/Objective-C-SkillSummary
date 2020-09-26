//
//  NSArray+PJW.m
//  SkillDemo
//
//  Created by pjw on 2020/9/26.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "NSArray+PJW.h"
#import <objc/message.h>

@implementation NSArray (PJW)

//+(void)load{
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method method1 = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
//        Method method2 = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(pjw_objectAtIndex:));
//        method_exchangeImplementations(method1, method2);
//    });
//}

//-(id)pjw_objectAtIndex:(NSUInteger)index{
//    if (index > self.count -1) {
//        NSLog(@"干哈呢 越界了");
//        return  nil;
//    }
//    return [self pjw_objectAtIndex:index];
//}

@end
