//
//  ResidentThread.m
//  SkillDemo
//
//  Created by pjw on 2020/10/6.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "ResidentThread.h"

@implementation ResidentThread
+(NSThread *)shareThread {
    
    static NSThread *shareThread = nil;

    static dispatch_once_t oncePredicate;

    dispatch_once(&oncePredicate, ^{

      shareThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadTest) object:nil];

      [shareThread setName:@"threadTest"];
      
      [shareThread start];
    });

    return shareThread;
}

+(void)threadTest
{
    @autoreleasepool {

      NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
      
      [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
      
      [runLoop run];
    }
}
@end
