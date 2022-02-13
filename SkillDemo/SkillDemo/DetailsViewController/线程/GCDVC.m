//
//  GCDVC.m
//  SkillDemo
//
//  Created by pjw on 2021/2/28.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "GCDVC.h"

@interface GCDVC ()

@property(nonatomic,assign)int ticketsCount;
@property(nonatomic,strong)NSString * name;


@end

@implementation GCDVC


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSThread * thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(maipiao) object:nil];
    [thread1 start];
    
    NSThread * thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(maipiao) object:nil];
    [thread2 start];
    
    NSThread * thread3 = [[NSThread alloc]initWithTarget:self selector:@selector(maipiao) object:nil];
    [thread3 start];
    
    NSThread * thread4 = [[NSThread alloc]initWithTarget:self selector:@selector(maipiao) object:nil];
    [thread4 start];
}

-(void)setName{
    NSMutableString * str = [NSMutableString string];
    [str appendString:@"hello"];
    self.name = str;
    
    [str appendString:@"zs"];
    NSLog(@"%@",self.name);
    
//    将name的属性修饰符改成strong和copy试试效果
//    copy就是将可变的复制一份，变成不可变的
//    strong是将内存地址指向了self.name
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.ticketsCount = 10;
   
    [self setName];
    
    /*
     GCD简介
     全程是Grand Central Dispatch
     纯C语言，提供了非常多强大的函数

     GCD优势
     GCD是苹果公司为了多核的并行运算提出的解决方案
     GCD会自动利用更多的CPU内核
     GCD会自动管理线程的生命周期(创建线程、调度任务、销毁线程)
     程序员只需要告诉GCD想要执行生命任务，不需要编写任何线程管理代码

     主要是将任务添加到队列中，并且制定执行任务的函数
     
     异步线程dispatch_async
     不用等待当前语句执行完毕，就可以执行下一条语句
     会开始线程执行block的任务
     异步是多线程的代名词
     
     同步dispatch_sync
     必须等待当前语句执行完毕，才会执行下一条语句
     不会开启线程
     
     FIFO:
     first in first out             先进来先调度
     
     同步函数串行队列
     不会开启线程，在当前线程执行任务
     任务串行执行，任务一个接着一个
     会产生堵塞
     
     
     同步函数并发队列
     不会开启线程，在当前线程执行任务
     任务一个接一个
     
     
     异步函数串行队列
     开启一条新线程
     任务一个接一个
     
     
     异步函数并发队列
     开启线程，在当前线程执行任务
     任务异步执行，没有顺序，cpu调度有关
     
     
     同步：
     1个人执行多个任务，也是依次执行，1个人同一时间执行1个任务
     
     异步：
     多个人可以同时执行多个任务
     
     
     进程、线程
     进程：
     进程是指在系统中正在运行的一个应用程序
     每个进程之间是独立的，每个进程均运行在其专用的且受保护的内存空间内
     
     线程：
     1个进程有多个线程组成(1个进程至少有1个线程)
     线程是进程的基本执行单元，一个进程的所有任务都在线程中执行
     
     
     多线程可以解决程序阻塞问题
     多线程可以提高程序的执行效率
     
     
     多线程的优缺点
     优点：
     能适当提高程序的执行效率（cpu，内存）
     能适当提高资源的利用率
     线程上的任务执行完成后，线程会自定销毁
     
     缺点：
     开启线程需要占用一定的内存空间，默认情况下，每一个线程都占512kb
     如果开启大量的线程，会占用大量的内存空间，降低程序的性能
     线程越多，cpu在调用线程上的开销就约大
     线程设计更加复杂，比如线程间的通信，多线程的数据共享
     
     
     
     主线程
     一个程序运行后，默认会开启1个线程，称为主线程或UI线程
     主线程一般用来刷新UI界面，处理UI事件（比如点击，滚动，拖拽等事件）
     主线程使用注意
     别将耗时的操作放到主线程中
     耗时操作会卡住主线程，严重影响UI的流畅性，给用户一种卡的坏体验
     
     
     iOS中多线程的技术方案
     pthread        C语言        程序员自己管理线程生命周期
     NSThread       OC语言       程序员自己管理线程生命周期
     GCD            C语言        自动管理
     NSOperation    OC语言       自动管理
     
     什么叫生命周期
     一个线程的由创建，到被调用，在到销毁的过程
     
     NSThread演示
     1、方式1
     NSThread * thread = [[NSThread alloc]initWithTarget:self selector:@selector(demo:) object:nil];
     [thread start];
     2、方式2
     [NSThread detachNewThreadSelector:@selector(demo:) toTarget:self withObject:nil];
     3、方式3
     [self performSelectorInBackground:@selector(demo:) withObject:nil];
     4、参数
     
     什么是队列
     
    
     __block的作用
     
     
     block + 多线程    +   加锁(八大锁)
    
      1、循环的速度是非常非常快的
      2、操作内存的栈空间，速度非常快
      3、操作内存的堆空间，速度有点慢
      4、I/O操作，速度非常慢input output
      5、循环非常消耗cpu资源
    
    
    
    
     多线程执行原理
     a.(单核CPU)同一时间，cpu只能处理1个线程，只有一个线程在执行
     b.多线程同时执行；是CPU快速的在多个线程之间的切换
     c.cpu调度线程的时间足够快，就造成了多线程的同时执行
     d.如果线程数非常多，cpu会在n个线程之间切换，消耗大量的cpu资源
     e.每个线程被调度的次数会降低，线程的执行效率降低
     
     
     线程的状态
     将线程对象放到可调度线程池中
     
     
     线程名称：
     设置线程名称可以当线程执行的方法内部出现异常的时候记录异常和当前线程
     
     线程优先级
     内部调度算法在决定该运行哪个线程时，会把线程的优先级作为考量因素，较高优先级的线程会比较低优先级的线程具有更多的运行机会。较高优先级不保证你的线程具体执行的时间，
     只有相比较低优先级的线程，它更有可能被调度器选择执行而已。
     
     
     多线程访问共享资源的问题
     共享资源
     1块资源可能会被多个线程共享，也就是多个线程可能会访问同一块资源
     比如多个线程访问同一个个对象。同一个变量，同一个文件
     当多个线程访问同一块资源时，很容易引发数据错乱和数据安全问题
     
     
     互斥锁是为了线程同步
     互斥锁线程同步
     锁需要锁的代码
     
     互斥锁
     能有效防止因多线程抢夺资源造成的数据安全问题
     
     专业术语：线程同步
     线程同步的意思是：多条线程按顺序地执行任务
     互斥锁就是使用了线程同步技术
     
     互斥锁原理：
     每一个对象内部都有一个锁(变量),当有线程要进入synchronized到代码块中会先检查对象的锁是打开还是关闭，默认锁是打开状态(1)，如果是线程执行到代码块内部会
     先上锁(0)。如果锁被关闭，再有线程要执行代码块就先等待，直到锁打开才可以进入。
     
     线程执行到synchronized
     1、检查锁状态，如果是开锁状态(1)转到(2)    如果上锁(0)转到(5)
     2、上锁(0)
     3、执行代码块
     4、执行完毕  开锁(1)
     5、线程等待(就绪状态)
     
     加锁后线程执行的效率比不加锁的时候要低，因为线程等待锁，但是锁保证了多个线程同时操作全部变量的安全性
     
     原子属性
     属性中的修饰符
     nonatomic非原子属性
     atomic原子属性(线程安全)，针对多线程设计的，默认值，保证同一时间只有一个线程能够写入(但是同一个时间多个线程都可以取值)
     atomic本身就有一把锁(自旋锁)             单写多读：单个线程写入，多个线程可以读取
     
     nonatomic和atomic对比
     atomic：线程安全，需要消耗大量的资源
     nonatomic：非线程安全，适合内存小的移动设备
     
     iOS开发的建议
     所有属性都声明为nonatomic
     尽量避免多线程抢夺同一块资源
     尽量将加锁，资源抢夺的业务逻辑交给服务器端处理，减小移动客户端的压力
     
     
     互斥锁和自旋锁
     互斥锁
     如果发现其他线程正在执行锁定代码，线程会进入休眠(就绪状态)，等其它线程时间片到打开锁后，线程会被唤醒(执行)
     
     自旋锁
     如果发现有其它线程正在锁定代码，线程会用死循环的方式，一直等待锁定的代码执行完成，自旋锁更适合执行不耗时的代码
     
     线程间通信
     [self performSelectorOnMainThread:@selector(uploadUI:) withObject:img waitUntilDone:YES];
     waitUntilDone值是YES会等待方法执行完毕才会执行后续代码
     

     weak和strong
     什么时候用strong和weak
     oc对象用strong
     连线的UI控件为什么用weak
     
     自动释放池
     iOS开发中的内存管理
     在iOS开发中，并没有JAVA和C#中的垃圾回收机制
     在MRC中对象谁申请，谁释放
     使用ARC。只是在编译时，编译器会根据代码结构自动添加了retain、release和autoreless
     
     自动释放池
     标记为autorelease的对象，会被添加到最近一次创建的自动释放池中
     当自动释放池被销毁或耗尽时，会向自动释放池中的所有对象发送release消息
     
     自动释放池是什么时候创建的？又是什么时候销毁的？
     每一次主线程的消息循环开始的时候会先创建自动释放池
     消息循环结束前，会释放自动释放池
     自动释放池被销毁或耗尽时会向池中所有对象发送release消息，释放所有autorelease的对象
     使用NSThread做多线程开发时，需要在线程调度方法中手动添加自动释放池
     
     
     互斥锁和自旋锁的区别
     1、互斥锁就是当一个线程在运行时，另外一个线程等待，当第一个线程完成时，告诉下一个线程把锁打开了，你来吧
     2、自旋锁就是一直问，锁开了没，锁开了没
     自旋锁适合锁住不耗时的操作
     互斥锁可以锁住任意代码
     
     什么时候使用自动释放池
     循环内部创建大量的临时对象，在循环内部创建自动释放池
     创建子线程的时候，在线程刚刚开始的位置，创建自动释放池
     
     */
    
//    [self textDemo];//异步并发队列
//
//    [self textDemo1];//产生死锁了
//
//    [self textDemo2];//美团面试题
//
//    [self textDemo3];//模拟耗时操作
//
//    [self textDemo4];//模拟耗时操作
//
//    [self textDemo5];//将耗时操作放到后天
    
    //通过这个方法，可以给线程传递消息
//    NSThread * thread = [[NSThread alloc]initWithTarget:self selector:@selector(demo:) object:@"pjw"];
//    [thread start];
    
    
    ///同步串行队列
    [self 同步串行队列];
    
    
    ///异步串行队列
    [self 异步串行队列];
    
    ///异步并行队列
    [self 异步并行队列];
    
    ///同步并行队列
    [self 同步并行队列];
    
    ///barrier
    [self barrier];
    
    ///队列组
    [self 队列组];
    
    ///NSOperation设置依赖
    [self NSOperation设置依赖];
    
    ///NSOperation设置最大并发数
    [self NSOperation设置最大并发数];
    
    ///NSOperation设置队列的暂停/继续/取消
    [self NSOperation设置队列的暂停继续取消];
}

-(void)demo:(NSString *)name{
    NSLog(@"%@",name);
}


//异步并发队列
-(void)textDemo{
    dispatch_queue_t queue = dispatch_queue_create("pjw", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"textDemo    1");
    dispatch_async(queue, ^{
        NSLog(@"textDemo    2");
        dispatch_async(queue, ^{
            NSLog(@"textDemo    3");
        });
        NSLog(@"textDemo    4");
    });
    NSLog(@"textDemo    5");
    
    //执行顺序      1   5   2   4   3
    
}


//串行并发队列            产生死锁了
-(void)textDemo1{
//    dispatch_queue_t queue = dispatch_queue_create("pjw", DISPATCH_QUEUE_SERIAL);
//    NSLog(@"textDemo1   1");
//    dispatch_async(queue, ^{
//        NSLog(@"textDemo1   2");
//        dispatch_sync(queue, ^{
//            NSLog(@"textDemo1   3");
//        });
//        NSLog(@"textDemo1   4");
//    });
//    NSLog(@"textDemo1   5");
//
//    //执行顺序      1   5   2   死锁
    
    /*
        2先进来。就先除去，FIFO
        2下面是块任务，属于同步函数，同步函数属于护犊子类型，自己的任务没有走完，不会继续往下执行
        所以4就会等待块任务的执行
        这个时候又往队列中添加任务3，是自己的犊子，开始护犊子，我要执行完毕，就必须把3带走
        在串行队列中，是2   块任务     4     3，3晚于4任务，3要等待4任务执行完成，4要等待整个块任务完成，块任务要等待3完成
     
     
     */
}

//美团面试题
-(void)textDemo2{
    
    __block int a = 0;  //将栈区拷贝到堆区
    while (a < 5) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            a ++;
        });
    }
    NSLog(@"a = %d",a);
    
    //NSLog         IO流，就在打印的时候，线程10执行完毕，将a值更新
    //LLVM优化
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"出来  a = %d",a);
    });
    
    //同步并发队列，最后输出的值，遵循FIFO，最新新去的，最新出来
}


-(void)textDemo3{
    dispatch_queue_t queue = dispatch_queue_create("2.28", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"textDemo3   1");
    });
    dispatch_async(queue, ^{
        NSLog(@"textDemo3   2");
    });
    dispatch_sync(queue, ^{
        NSLog(@"textDemo3   3");
    });
    NSLog(@"textDemo3   0");
    dispatch_async(queue, ^{
        NSLog(@"textDemo3   7");
    });
    dispatch_async(queue, ^{
        NSLog(@"textDemo3   8");
    });
    dispatch_async(queue, ^{
        NSLog(@"textDemo3   9");
    });
    
    //3     1   2   0   7   8   9
    //3     1   0   2   7   8   9
    //3     0   1   2   7   8   9
}

-(void)textDemo4{
    NSLog(@"start");
    
    @autoreleasepool {
        for (int i = 0; i < 10000000; i++) {
            NSString * str = [NSString stringWithFormat:@"%d",i];
        }
    }
    
    NSLog(@"end");
}

-(void)textDemo5{
    //此方法用于页面卡死，将耗时操作放在后面，不阻塞UI交互
    [self performSelectorInBackground:@selector(textDemo4) withObject:nil];
}

-(void)maipiao{
    while (YES) {
        //模拟耗时
        
        [NSThread sleepForTimeInterval:1.0];
        //@synchronized  同步     加锁加在数据读取处   锁默认是开着的
        @synchronized (self) {
            if (self.ticketsCount > 0) {
                self.ticketsCount = self.ticketsCount - 1;
                NSLog(@"剩余%d张票",self.ticketsCount);
            }else{
                NSLog(@"票已经卖完了");
                break;
            }
        }
    }
}



-(void)同步串行队列{
    dispatch_queue_t queue = dispatch_queue_create("pjw", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"同步串行队列        %d",i);
        }
    });
}

-(void)异步串行队列{
    dispatch_queue_t queue = dispatch_queue_create("pjw", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"同步串行队列        %d",i);
        }
    });
}



-(void)异步并行队列{
    dispatch_async(dispatch_queue_create("pjw1", DISPATCH_QUEUE_CONCURRENT), ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"异步并行队列        %d",i);
        }
    });
}

-(void)同步并行队列{
    dispatch_sync(dispatch_queue_create("pjw2", DISPATCH_QUEUE_CONCURRENT), ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"同步并行队列        %d",i);
        }
    });
}

-(void)barrier{
    
}

-(void)队列组{
    
}

-(void)NSOperation设置依赖{
    
}


-(void)NSOperation设置最大并发数{
    
}


-(void)NSOperation设置队列的暂停继续取消{
    
}


@end
