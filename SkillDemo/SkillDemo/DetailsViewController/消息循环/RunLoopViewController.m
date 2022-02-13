//
//  RunLoopViewController.m
//  SkillDemo
//
//  Created by pjw on 2021/3/9.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController ()

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    /*
        1、什么是消息循环
        Runloop就是消息循环，每一个线程内部都有一个消息循环
        只有主线程的消息循环默认开启，子线程的消息循环默认不开启
     
        2、消息循环的目的
        保证程序不退出
        负责处理输入事件
        如果没有事件发生，会让程序进入休眠状态
     
        3、消息循环-输入源
        Runloop接受输入事件来自两种不同的来源：输入源和定时源
     
        [NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode;
        NSDefaultRunLoopMode                    默认模式，即页面不发生滚动的时候
        NSRunLoopCommonModes                    页面发生滚动和不发生滚动时候的模式
        UITrackingRunLoopMode                   页面发生滚动模式的时候
     
     
        4、子线程的消息循环
        主线程的消息循环默认开启，子线程的消息循环不会开启
        启动子线程的消息循环
        [[NSRunLoop currentRunLoop] run];
     
        线程池的实现原理，开启线程后永不销毁，当需要让子线程执行新的方法，使用performSelector让指定的方法在指定的子线程上运行
     
    */
    
    
    //开启一个子线程
    NSThread * thread = [[NSThread alloc]initWithTarget:self selector:@selector(demo) object:nil];
    [thread start];
     
    //往子线程的消息循环中添加输入源       这行代码会崩溃，因为没有在子线程中开启消息循环
    [self performSelector:@selector(demo1) onThread:thread withObject:nil waitUntilDone:YES];
    
}

-(void)demo{
    //开启子线程的消息循环，如果开启，消息循环一直运行
    //当消息循环中没有添加输入事件，消息循环会立即结束
    NSLog(@"     demo   ");
//    [[NSRunLoop currentRunLoop] run];                   //在thread的这个子线程中不加这句话，performSelector这行代码会崩溃
    NSLog(@"     111111   ");
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];  //2秒种后消息循环结束
}

-(void)demo1{
    NSLog(@"     demo1   ");
    NSLog(@"     222222   ");
}



@end
