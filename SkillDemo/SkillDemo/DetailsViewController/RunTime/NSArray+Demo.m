//
//  NSArray+Demo.m
//  SkillDemo
//
//  Created by pjw on 2020/9/6.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "NSArray+Demo.h"
#import <objc/message.h>

@implementation NSArray (Demo)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [self exchangeMethodWithClass:objc_getClass("__NSArray0") orginSelector:@selector(objectAtIndex:) customSelector:@selector(emptyObjectIndex:)];
            [self exchangeMethodWithClass:objc_getClass("__NSSingleObjectArrayI") orginSelector:@selector(objectAtIndex:) customSelector:@selector(singleArrObjectIndex:)];
            [self exchangeMethodWithClass:objc_getClass("__NSArrayI") orginSelector:@selector(objectAtIndex:) customSelector:@selector(arrObjectIndex:)];
            [self exchangeMethodWithClass:objc_getClass("__NSArrayM") orginSelector:@selector(objectAtIndex:) customSelector:@selector(mutableObjectIndex:)];
            [self exchangeMethodWithClass:objc_getClass("__NSArrayM") orginSelector:@selector(insertObject:atIndex:) customSelector:@selector(mutableInsertObject:atIndex:)];
        }
    });
}

+ (void)exchangeMethodWithClass:(Class)class orginSelector:(SEL)orginS customSelector:(SEL)customS{
    Method orginMethod = class_getInstanceMethod(class, orginS);
    Method customMethod = class_getInstanceMethod(class, customS);
    method_exchangeImplementations(orginMethod, customMethod);
}

- (id)emptyObjectIndex:(NSInteger)index{
    return nil;
}

- (id)singleArrObjectIndex:(NSInteger)index{
    @autoreleasepool {
        if (index >= self.count || index < 0) {
            return nil;
        }
        return [self singleArrObjectIndex:index];
    }
}

- (id)arrObjectIndex:(NSInteger)index{
    @autoreleasepool {
        if (index >= self.count || index < 0) {
            return nil;
        }
        return [self arrObjectIndex:index];
    }
}

- (id)mutableObjectIndex:(NSInteger)index{
    @autoreleasepool {
        if (index >= self.count || index < 0) {
            return nil;
        }
        return [self mutableObjectIndex:index];
    }
}

- (void)mutableInsertObject:(id)object atIndex:(NSUInteger)index{
    @autoreleasepool {
        if (object) {
            [self mutableInsertObject:object atIndex:index];
        }
    }
}

- (id)myObjectAtIndex:(NSUInteger)index{
    @autoreleasepool {
        if (index < self.count) {
            return [self myObjectAtIndex:index];
        } else {
            return nil;
        }
    }
}

@end
