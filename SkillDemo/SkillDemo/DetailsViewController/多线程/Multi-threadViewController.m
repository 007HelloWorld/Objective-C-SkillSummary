//
//  Multi-threadViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/9/6.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "Multi-threadViewController.h"
#import "ResidentThread.h"


@interface Multi_threadViewController ()

@property(nonatomic,assign)NSInteger ticketSurplusCount;
@property(nonatomic,strong)NSLock * lock;

@end

@implementation Multi_threadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
//     串行队列的创建方法
//    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
//
//    // 并发队列的创建方法
//    dispatch_queue_t queue1 = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
//
//    // 主队列的获取方法
//    dispatch_queue_t queue2 = dispatch_get_main_queue();
//
//    // 全局并发队列的获取方法
//    dispatch_queue_t queue3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    // 同步执行任务创建方法
//    dispatch_sync(queue1, ^{
//        // 这里放同步执行任务代码
//        NSLog(@"这里放同步执行任务代码");
//
//    });
//    // 异步执行任务创建方法
//    dispatch_async(queue3, ^{
//        // 这里放异步执行任务代码
//        NSLog(@"这里放异步执行任务代码");
//    });
    
    
    
    //下载多张图片，最后汇总成一张图片
    
    
    
    
    //线程依赖
//    [self addDependency];
    
    //卖票,线程安全
//    [self initTicketStatusSave];
//    [self saleTicketSafe];
    
    //等所有线程执行完毕后，在执行最后的汇总任务
//    [self groupNotify];
    
    
 
//    [self addDependency1];

//    [self adada];
    
    //常驻线程
    [self performSelector:@selector(test) onThread:[ResidentThread shareThread] withObject:nil waitUntilDone:NO];

}

-(void)test{
    NSLog(@"常驻线程可以使用");
}

/**
 * 操作依赖
 * 使用方法：addDependency:
 */
- (void)addDependency {

    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 2.创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 3.添加依赖
    [op2 addDependency:op1]; // 让op2 依赖于 op1，则先执行op1，在执行op2

    // 4.添加操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
}


/**
 * 线程安全：使用 NSLock 加锁
 * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 */

- (void)initTicketStatusSave {
    NSLog(@"currentThread---%@",[NSThread currentThread]); // 打印当前线程

    self.ticketSurplusCount = 50;

    self.lock = [[NSLock alloc] init];  // 初始化 NSLock 对象

    // 1.创建 queue1,queue1 代表北京火车票售卖窗口
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    queue1.maxConcurrentOperationCount = 1;

    // 2.创建 queue2,queue2 代表上海火车票售卖窗口
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    queue2.maxConcurrentOperationCount = 1;

    // 3.创建卖票操作 op1
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [self saleTicketSafe];
    }];

    // 4.创建卖票操作 op2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [self saleTicketSafe];
    }];

    // 5.添加操作，开始卖票
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
}

/**
 * 售卖火车票(线程安全)
 */
- (void)saleTicketSafe {
    while (1) {

        // 加锁
        [self.lock lock];

        if (self.ticketSurplusCount > 0) {
            //如果还有票，继续售卖
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数:%ld 窗口:%@", (long)self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        }

        // 解锁
        [self.lock unlock];

        if (self.ticketSurplusCount <= 0) {
            NSLog(@"所有火车票均已售完");
            break;
        }
    }
}

-(void)groupNotify{

    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
      NSLog(@"任务1正在执行");
      sleep(2);
      NSLog(@"任务1执行完成");
    });
    dispatch_group_async(group, queue, ^{
      NSLog(@"任务2正在执行");
      sleep(4);
      NSLog(@"任务2执行完成");
    });
    dispatch_group_notify(group, queue, ^{
      NSLog(@"任务1，任务2都执行完成");
    });

    NSLog(@"是否阻塞主线程"); // 不会
}

//A,B,C是同步执行的任务
-(void)addDependency1{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 创建3个操作
    NSOperation *a = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operationA---");
        
    }];
    NSOperation *b = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operationB---");
        
    }];
    NSOperation *c = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operationC---");
        
    }];
    // 添加依赖
    [c addDependency:b];
    [c addDependency:a];
    // 执行操作
    [queue addOperation:a];
    [queue addOperation:b];
    [queue addOperation:c];

}

//先执行abc，在执行de
-(void)adada{
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"任务A");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务B");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务C");
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"阻塞自定义并发队列");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务D");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务E");
    });
}


@end
