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
@property(nonatomic,strong)UIImageView * downImageV;




@end

@implementation Multi_threadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //普通的操作
//    [self normalOperations];
    
    
    
    //下载多张图片，最后汇总成一张图片
//    self.downImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//
//    [self DownLoadImage:^(UIImage *image1, UIImage *image2, UIImage *image3) {
//         //合并
//         UIGraphicsBeginImageContextWithOptions(CGSizeMake(375, 450), NO, 0.0);
//         [image1 drawInRect:CGRectMake(0, 100, 100, 50)];
//         [image2 drawInRect:CGRectMake(0, 150, 100, 50)];
//         [image3 drawInRect:CGRectMake(0, 200, 100, 50)];
//        //给ImageView赋值
//         self.downImageV.image = UIGraphicsGetImageFromCurrentImageContext();
//         //关闭上下文
//         UIGraphicsEndImageContext();
//
//    }];
//    [self.view addSubview:self.downImageV];

    
    
    //线程依赖
//    [self addDependency];
    
    
    
    //卖票系统,线程安全
//    [self initTicketStatusSave];
//    [self saleTicketSafe];
    
    
    
    
    //等所有线程执行完毕后，在执行最后的汇总任务
//    [self groupNotify];
    
    
    //先执行abc，在执行de
//    [self adada];
    
    //常驻线程
//    [self performSelector:@selector(test) onThread:[ResidentThread shareThread] withObject:nil waitUntilDone:NO];

    //NSOperationQueue的事务性，顺序行，依赖关系
    //顺序行
    [self addDependenceInCustom];                                                                                             
    
    //
}

- (void)addDependenceInCustom
{
    //NSOperationQueue 对于添加到队列中的操作，首先进入准备就绪的状态（就绪状态取决于操作之间的依赖关系），然后进入就绪状态的操作的开始执行顺序（非结束执行顺序）由操作之间相对的优先级决定（优先级是操作对象自身的属性）。
    

    NSLog(@"创建添加任务%@",[NSThread currentThread]);
    NSOperationQueue *customQueue = [[NSOperationQueue alloc]init];
    customQueue.maxConcurrentOperationCount = 1;
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"1"];
    
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"2"];
    
    NSInvocationOperation *op3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"3"];
    
    NSInvocationOperation *op4 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(task:) object:@"4"];
    
    //isReady属性如果为YES的时候，该任务处于就绪状态，就等待系统调度执行。如果任务有依赖关系的话，该任务的isReady属性需要在其所属的依赖任务执行完成后，才为YES。
    //默认情况下，操作的queuePriority(队列优先级)为0 NSOperationQueuePriorityNormal 正常优先级。
    //都处于就绪状态下的操作，才开始按照优先级顺序来执行。 优先级高的是说系统调度的概率会大一些，但是也不能确保完全会按照优先级来，如果要设置操作的执行顺序，最有效也最安全的做法还是设置依赖关系。
//    [op1 addDependency:op2];
//    [op2 addDependency:op3];
    /*注意:两个任务不能相互依赖，如果相互依赖，则会出现死锁，都执行不了
     [op1 addDependency:op2];
     [op2 addDependency:op1];
     这种相互依赖是错误的。
     */
    op4.queuePriority = NSOperationQueuePriorityVeryHigh;
//    op2.queuePriority = NSOperationQueuePriorityHigh;
//    op3.queuePriority = NSOperationQueuePriorityLow;
    [customQueue addOperation:op1];
    [customQueue addOperation:op2];
    [customQueue addOperation:op3];
    [customQueue addOperation:op4];
}

-(void)task:(NSInvocationOperation *)open{
    NSLog(@"%@",open);
}


-(void)DownLoadImage:(void(^)(UIImage *image1,UIImage *image2,UIImage *image3))downLoadSuccess{

     __weak typeof(self) weakSelf = self;
    // 创建分组
    dispatch_group_t  group = dispatch_group_create();
    // 创建队列
    dispatch_queue_t  queue = dispatch_queue_create("downLoadImage", DISPATCH_QUEUE_CONCURRENT);

    // 往分组中添加任务1
    // 请求依次执行  与 dispatch_group_leave 配对使用
    dispatch_group_enter(group);
    __block UIImage *image1 = nil;
    dispatch_group_async(group, queue, ^{
         NSLog(@"第1张图片开始下载");
       //处理耗时的操作
        image1 = [weakSelf imageWithUrl:@"https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2534506313,1688529724&fm=26&gp=0.jpg"];
        dispatch_group_leave(group);
        NSLog(@"第1张图片下载完成");
        
    });

    // 往分组中添加任务2
    // 请求依次执行  与 dispatch_group_leave 配对使用
    dispatch_group_enter(group);
    __block UIImage *image2 = nil;
    dispatch_group_async(group, queue, ^{
         NSLog(@"第2张图片开始下载");
        //处理耗时的操作
        image2 = [weakSelf imageWithUrl:@"http://img.redocn.com/200906/2/321782_124390997641aY.jpg"];
        dispatch_group_leave(group);
        NSLog(@"第2张图片下载完成");
        
    });

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);// A,B同时执行, 执行完才会执行下面的
    // 往分组中添加任务3
    // 请求依次执行  与 dispatch_group_leave 配对使用
    dispatch_group_enter(group);
     __block UIImage *image3 = nil;
    dispatch_group_async(group, queue, ^{
         NSLog(@"第3张图片开始下载");
        //处理耗时的操作
        image3 = [weakSelf imageWithUrl:@"https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3892521478,1695688217&fm=26&gp=0.jpg"];
        
        NSLog(@"第3张图片下载完成");
        dispatch_group_leave(group);
        
    });

    // 分组中任务完成后通知该block执行
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            // 通知主线程刷新UI
            downLoadSuccess(image1,image2,image3);
        });
    });
}

- (UIImage *) imageWithUrl :(NSString *) urlStr{
      NSURL *url = [NSURL URLWithString:urlStr];
      NSData *data = [NSData dataWithContentsOfURL:url];
      return [UIImage imageWithData:data];
}

-(void)normalOperations{
    // 串行队列的创建方法
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);

    // 并发队列的创建方法
    dispatch_queue_t queue1 = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);

    // 主队列的获取方法
    dispatch_queue_t queue2 = dispatch_get_main_queue();

    // 全局并发队列的获取方法
    dispatch_queue_t queue3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    // 同步执行任务创建方法
    dispatch_sync(queue1, ^{
        // 这里放同步执行任务代码
        NSLog(@"这里放同步执行任务代码");

    });
    // 异步执行任务创建方法
    dispatch_async(queue3, ^{
        // 这里放异步执行任务代码
        NSLog(@"这里放异步执行任务代码");
    });

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
