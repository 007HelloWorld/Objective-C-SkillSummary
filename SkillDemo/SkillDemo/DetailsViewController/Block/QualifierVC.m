//
//  BlockViewController.m
//  Image
//
//  Created by pjw on 2021/3/9.
//

#import "QualifierVC.h"

@interface QualifierVC ()



@end

@implementation QualifierVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    //1、block为什么要用copy
    //执行copy操作是将栈block拷贝到堆block中，是将其生命周期延迟，栈block的出了它的生命周期，就会被销毁，会出现程序崩溃问题
    
    //2、delegate为什么用weak修饰
    //vc --> 类对象  -->   delegate  -->   将vc(self)给代理，就造成了一个闭环的循环引用了

    //3、字符串为什么用copy
    //用strong修饰可变字符串时，是将其内存地址给全局的可变字符串，当其他地方修改了这个字符串，那么用strong修饰的这个字符串，值也会被修改
    //用copy修饰可变字符串时,是将临时字符串拷贝一份赋值给了这个可变字符串，是赋值了一个对象，其他地方修改的时候，不会影响这个值
    
    //4、weak和assign的区别
    //用weak和assign修饰的对象，其引用计数都没有加1
    //weak修饰的对象，引用计数为0时，会对象所指向的内存地址为变成null，消息发送给null时，程序不会崩溃
    //用assign修饰的对象，引用计数为0时，对象所指向的内存地址会空，消息发送给空指针时，程序就会崩溃
    [self weakAndAssign];
    
    
    
    /*
        nonatomic和atomic的区别
        1、atomic为默认属性，多线程安全，这个属性是为了保证程序在多线程情况下，编译器自动生成一些互斥加锁代码，避免该变量的读写不同步问题，对性能的消耗很大
        2、nonatomic禁止多线程，变量保护，提高性能。如果该对象无需考虑多线程的情况，建议加入此属性，这样会让编译器少产生一些互斥加锁代码，可以在一定程度上提高效率
     
        readwrite和readonly的区别
        readonly表示这个属性是只读的，就是只生产getter方法，不会生成setter方法
        readwrite表示可读写，生产getter和setter方法
     
        weak和strong的区别
        默认情况下，一个指针都会使用strong属性，表明这是一个强引用。这意味着，只要引用存在，对象就不能被销毁
        weak是弱引用，使用weak修饰主要是为了解决循环引用的问题
        1、在修饰代理属性的时候使用weak
        2、通过连线方式创建控件时使用weak
        3、在block中，为了避免循环引用，使用weak修饰self，__weak typeof(self) weakSelf = self;
     
        copy和strong的区别
        当源字符串是NSString时，由于字符串是不可变的，不论strong还是copy属性，都是指向源对象，copy操作只是做了次浅拷贝
        当源字符串是NSMutableString时，strong属性只是增加了源字符串的引用计数，而copy属性则是对源字符串做了次深拷贝，产生了一个新的对象，且copy属性对象指向这个新的对象。另外需要注意的是，这个copy的属性对象的类型始终是NSString，而不是NSMutableString，因此是不可变的。这里strong属性只是单纯增加对象的引用计数，而copy操作则进行了一次深拷贝，所以性能上有所差异，取值的时候，可变字符串添加字符的时候，最后两者获取的值也不一样
        
        assign和weak的区别
        assign适合于基本数据类型，weak适合用于NSObject对象，并且是弱引用。当assign用来修饰对象时容易造成野指针，对象一般会分配在堆上的某块内存，如果在后续的内存分配中，刚好分到这块地址，程序就会崩溃
        之所以assign可以用来修饰基本数据类型，是因为基础数据类型一般分配在栈上，栈的内存会由系统自动处理，不会造成野指针
        weak修饰的对象在被释放以后，指针地址会被置为nil，所以现在一般弱引用就是用weak。
     
        block变量定义时用copy
        block的循环引用并不是strong导致的，在ARC环境下，系统底层也会做一次copy操作使block从栈区复制一块内存空间到堆里，所以strong和copy在对block修饰上没有本质区别，只不过copy操作的效率更高而已，一般用copy来修饰block
     
    */
    
    
}


-(void)block{
    //全局block   __NSGlobalBlock__
    void (^demo)() = ^{
        NSLog(@"aaaa");
    };
    NSLog(@"%@",demo);
    
    //栈block    __NSStackBlock__
    int number = 5;
    void (^demo1)() = ^{
        NSLog(@"aaa %d",number);
    };
    NSLog(@"%@",demo1);
    
    //堆block    __MallocBlock__
    void (^demo2)() = ^{
        NSLog(@"aaa %d",number);
    };
    NSLog(@"%@",[demo2 copy]);
}

-(void)weakAndAssign{
//    self.weakPerson = [Person new];
//    self.weakPerson.name = @"pjw";
//    NSLog(@"%@",self.weakPerson.name);
//
//    self.assignPerson = [Person new];
//    self.assignPerson.name = @"2020";
//    NSLog(@"%@",self.assignPerson.name);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.demo) {
        self.demo(@"pjw");
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
