//
//  GCDViewController.m
//  SkillDemo
//
//  Created by pjw on 2021/3/10.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "GCDViewController.h"
#import "GCDTools.h"

@interface GCDViewController ()
{
    dispatch_queue_t _queue;
}
@property(nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArr = [NSMutableArray array];
    
    _queue = dispatch_queue_create("pjw", DISPATCH_QUEUE_CONCURRENT);
    /*
        GCD全程是Grand Central Dispatch
        纯C语言，提供了非常多强大的函数
     
        GCD的优势
        GCD是苹果公司为多核的并行运算提出的解决方案
        GCD会自动利用更多的CPU内核(比如双核。四核)
        GCD会自动管理线程的生命周期(创建线程，调度线程，销毁线程)
        程序员只需要告诉GCD想要执行生命任务，不需要编写任何线程管理代码
     
        GCD的两个核心
        任务和队列
     
        GCD使用的两个步骤
        创建任务：确定要做的事情
        将任务添加到队列中
            GCD会自动将队列中的任务取出，放到对应的线程中执行
            任务的取出遵循队列的FIFO原则：先进先出，后进后出
     
        GCD的队列分为2大类
        并发队列
            可以让多个任务并发(同时)执行(自动开启多个线程同时执行任务)
            并发功能只有在异步函数下才有效
     
        串行队列
            让任务一个接着一个地执行(一个任务执行完毕后，再执行下一个任务)
            
        同步串行队列  不开启线程，同步执行(在当前线程执行)，任务是按顺序执行
        异步串行队列  开启一个线程，顺序执行
     
        异步并行队列  开启多个线程，异步执行
        同步并行队列  不开启线程，顺序执行
     
        主队列，异步
        不开启线程，同步执行
        主队列特点：如果主线程正在执行代码暂时不调度任务，等主线程执行结束后在执行任务
        主队列又叫全局串行队列
     
        主队列，同步
        程序执行不出来(死锁)
        死锁的原因，当线程执行到下面这段代码的时候
        主队列：如果主线程正在执行代码，就不调度任务
        同步执行：如果第一个任务任务没有执行，就继续等待第一个任务执行完成，再执行下一个任务此时互相等待，程序无法往下执行(死锁)
        
     
        死锁的根本原因就是，先执行完主线程上的代码，才会执行主队列中的任务
     
        dispatch_get_global_queue(0, 0);                第一个0是优先级，服务质量           第二个0是以后会用
     
     
        GCD的其他操作        延迟操作            一次性执行           调度组
     
        
        barrier     阻塞      多线程中操作线程不安全的类，要小心
        after延迟
        once一次性执行，线程安全          单例保证一个程序中只有一份单例对象(工具类)
        调度组     让多个异步任务都完成之后做一件事情
     
     
        barrier 阻塞
        主要用于在多个异步操作完成之后，统一对非线程安全的对象进行更新
        适合于大规模的I/O操作
        当访问数据库或文件的时候，更新数据的时候不能喝其他更新或读取的操作在同一时间执行，可以使用调度组不过有点复杂可以
        dispatch_barrier_async解决
     
    */
    

    [self demo0];//dispatch_barrier_async的使用方法
    
//    [self demo1];//延迟执行
//
//    [self demo2];//一次性执行
//
//    [self demo3];//单例
    
//    [self demo4];//调度组
}

-(void)demo0{
    for (int i = 0;i< 100 ; i++) {
        [self  demo:i];
    }
}

-(void)demo:(int)index{
    
    dispatch_async(_queue, ^{
        NSLog(@"-------------正在下载  %d",index);
        dispatch_barrier_async(_queue, ^{
            NSLog(@"下载完成 ");
            [self.dataArr addObject:@"1"];
        });
    });
}

-(void)demo1{
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
        NSLog(@"    2秒后执行这个方法   -   %f  ",end - start);
    });
}

-(void)demo2{
    //一次性执行的原理，判断静态的全局变量的值，默认是0，如果执行完成后，设置为-1
    //once内部会判断变量的值，如果是0才会执行
    for (int i = 0; i < 100; i++) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSLog(@"   外部循环了100次，你看我执行了多少次     ");
        });
    }
}

-(void)demo3{
    //这种使用GCD执行的一次性方法，比使用互斥锁的效率更高，原因在于，GCD只需要判断静态变量是否为0，为0就执行里面方法，为-1就不执行
    //而加锁及互斥锁，需要等待解锁时间
    //可以使用CFAbsoluteTime方法，查看两种方法循环创建所需要的耗时时间
    
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 100; i++) {
        [[GCDTools shareGCDTools] say];
    }
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSLog(@"    2秒后执行这个方法   -   %f  ",end - start);
}

-(void)demo4{
    /*
        调度组
        有时候需要在多个异步任务都执行完成之后继续做某些事件，比如下载歌曲，等所有的歌曲都下载完毕之后，转到主线程提示用户
     
        调度组的原理是
        dispatch_group_enter(group);
        一个网络请求
        dispatch_group_leave(group);
N    */
    
    dispatch_group_t group = dispatch_group_create();//创建组
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);//队列             异步的方法
    dispatch_queue_t queue = dispatch_queue_create("pjw", DISPATCH_QUEUE_SERIAL);//队列       按顺序执行
    for (int i = 0; i < 4; i++) {
        dispatch_group_async(group, queue, ^{
            NSLog(@"下载第%d首歌曲",i);
        });
    }
    dispatch_group_notify(group, queue, ^{
        NSLog(@"下载完成");
    });
}

@end
