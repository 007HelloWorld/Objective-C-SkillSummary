//
//  NSOperationVC.m
//  SkillDemo
//
//  Created by pjw on 2021/3/13.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "NSOperationVC.h"

@interface NSOperationVC ()
@property(nonatomic,strong)NSOperationQueue * queue;
@property(nonatomic,strong)NSOperationQueue * queue1;

@end

@implementation NSOperationVC

-(NSOperationQueue *)queue1{
    if (!_queue1) {
        _queue1 = [NSOperationQueue new];
    }
    return _queue1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.queue = [NSOperationQueue new];
    self.queue.maxConcurrentOperationCount = 2;
    /*
        NSOperation介绍
        NSOperation的作用
        1、是OC语言中基于GCD的面向对象的封装
        2、使用起来比GCD更加简单(面向对象)
        3、提供了一些用GCD不好实现的功能
        4、苹果推荐使用，使用NSOperation不用关心线程以及线程的生命周期
     
        使用步骤
        NSOperation和NSOperationQueue实现多线程的具体步骤
        1、先将需要执行的操作封装到一个NSOperation对象中
        2、然后将NSOperation对象添加到NSOperationQueue中
        系统会自动将NSOperationQueue中的NSOperation取出来
        将取出的NSOperation封装的操作放到一条新线程中执行
        
        建立NSInvocationOperation对象
        NSInvocationOperation * a = [NSInvocationOperation alloc]initWithTarget:(nonnull id) selector:(nonnull SEL) object:(nullable id);
     
        调用start方法开始执行操作
        start
        一旦执行操作，就会调用target的sel方法
     
        注意
        默认情况下，调用了start方法后并不会开启一条新线程去执行操作，而是在当前线程同步执行操作
        只有将NSOperation放到一个NSOperationQueue中，才会异步执行操作
     
        NSOperation     VS      GCD
        GCD
        GCD是iOS4.0推出的，主要针对多核cpu做了优化，是C语言的技术
        GCD是将任务(blcok)添加到队列(串行/并行/全局/主队列)，并且以同步/异步的方法执行任务的函数
        GCD提供了一些NSOperation不具备的功能
        1、一次性执行
        2、延迟执行
        3、调度组
     
     
        NSOperation
        NSOperation是iOS2.0推出的，iOS4之后重写了NSOperation
        NSOperation将操作(异步的任务)添加到队列(并发队列)，就会执行指定操作的函数
        NSOperation里提供的方法的操作
        1、最大并发数
        2、队列的暂停/继续
        3、取消所有的操作
        4、指定操作之间的依赖关系(GCD可以用同步实现)
     
        
        最大并发数
        什么是最大并发数
        同时执行的任务数
        比如，同时开3个线程执行3个任务，并发数就是3
     
        最大并发数执行的过程
        1、把操作添加都队列中
        2、去线程池中获取空闲的线程，如果没有就创建线程
        3、把操作交给线程池中取出的线程执行
        4、执行完成后，把线程再放回线程池中
        5、重复2,3,4知道所有的操作都执行完成

        操作依赖
        NSOperation之间可以设置依赖来保证执行顺序
        比如一定要让操作A执行完后，才能执行操作B，可以这么写
        [operationB addDependency:operationA];          操作B依赖于操作A，不能互相依赖
     
     
    */
    
    /*     NSInvocationOperation     */
//    [self demo];//基本创建方法
//
//    [self demo1];//将操作添加到队列中
    
    /*     NSBlockOperation     */
//    [self demo2];
//
//    [self demo3];
//
//    [self demo4];
    
//    [self demo5];
    
    /*     线程间通信     */
//    [self demo6];

//    [self demo7];
    
    [self demo8];//队列依赖
}

-(void)demo{
    NSInvocationOperation * op = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(demoEvent) object:nil];
    NSLog(@"%d",op.isFinished);
    [op start];//start方法更新操作的状态，调用main方法，不开启新线程
    NSLog(@"%d",op.isFinished);
}

-(void)demo1{
    
    NSInvocationOperation * op = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(demoEvent) object:nil];//创建操作
    NSOperationQueue * queue = [[NSOperationQueue alloc]init];//队列
    [queue addOperation:op];//将操作添加到队列中，开启新的线程
    
}

-(void)demoEvent{
    NSLog(@" hello    %@",[NSThread currentThread]);
}

-(void)demo2{
    NSBlockOperation * op = [NSBlockOperation blockOperationWithBlock:^{        //创建操作
        NSLog(@"hello %@",[NSThread currentThread]);
    }];
    [op start];     //更新op的状态，执行main方法      不会开新的线程
}

-(void)demo3{
    NSOperationQueue * queue = [NSOperationQueue new];
    NSBlockOperation * op = [NSBlockOperation blockOperationWithBlock:^{        //创建操作
        NSLog(@"hello %@",[NSThread currentThread]);
    }];
    [queue addOperation:op];     //将操作添加到队列中
}

-(void)demo4{
    
    //并发队列，异步执行
    for (int i = 0; i < 10; i++) {
        [self.queue addOperationWithBlock:^{
            NSLog(@"hello %@",[NSThread currentThread]);
        }];
    }
}

-(void)demo5{
    NSBlockOperation * op = [NSBlockOperation blockOperationWithBlock:^{        //创建操作
        NSLog(@"hello %@",[NSThread currentThread]);
    }];
    
    //操作完成之后执行
    [op setCompletionBlock:^{
        NSLog(@"end %@",[NSThread currentThread]);
    }];
    
    [self.queue addOperation:op];
}

-(void)demo6{
    [self.queue addOperationWithBlock:^{
        //异步下载图片
        NSLog(@"异步下载图片");
        
        //线程间通信，回到主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"更新UI");
        }];
    }];
}

-(void)demo7{
    
    for (int i = 0; i < 1000; i++) {
        [self.queue addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"正在执行任务  %d",i);
        }];
    }
    
    
    for (int i = 0; i < 3; i++) {
        UIButton * saveBtn = [UIButton new];
        saveBtn.frame = CGRectMake(100, 100 + 100 * i, 100, 60);
        saveBtn.tag = 100 + i;
        saveBtn.backgroundColor = [UIColor orangeColor];
        saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(saveEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:saveBtn];
        
        if (i == 0) {
            [saveBtn setTitle:@"取消" forState:UIControlStateNormal];
        }else if (i == 1){
            [saveBtn setTitle:@"暂停" forState:UIControlStateNormal];
        }else if(i == 2){
            [saveBtn setTitle:@"继续" forState:UIControlStateNormal];
        }
    }
}

-(void)saveEvent:(UIButton *)sender{
    if(sender.tag == 100){//取消      会取消所有操作
        [self.queue cancelAllOperations];
        NSLog(@"取消");
    }else if (sender.tag == 101){//暂停       当前正在执行的操作，会执行完毕，后续的操作会暂停
        self.queue.suspended = YES;
        NSLog(@"暂停");
    }else if (sender.tag == 102){//继续
        self.queue.suspended = NO;
        NSLog(@"继续");
    }
}

-(void)demo8{
    NSBlockOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载");
    }];
    NSBlockOperation * op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"解压");
    }];
    NSBlockOperation * op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"升级完成");
    }];
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    [self.queue1 addOperations:@[op1,op2] waitUntilFinished:NO];
    [[NSOperationQueue mainQueue] addOperation:op3];
    
}




@end
