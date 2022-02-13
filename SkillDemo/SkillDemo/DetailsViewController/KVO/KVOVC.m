//
//  KVOVC.m
//  SkillDemo
//
//  Created by pjw on 2021/4/11.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "KVOVC.h"
#import "KVOModel.h"

@interface KVOVC ()

@property(nonatomic,strong)KVOModel * model;

@end

@implementation KVOVC

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
        1、KVO的基本使用
        2、KVO触发模式
        3、KVO属性依赖
        4、KVO容器观察
    */

    /*
     1、KVO的基本使用
     使用KVO分为三个步骤
     1、通过addObserver:forKeyPath:options:context:方法注册观察者，观察者可以接收keyPath属性的变化事件
     2、在观察者中实现observeValueForKeyPath:ofObject:change:context:方法，当keyPath属性发生改变后，KVO会回调这个方法来通知观察者
     3、当观察者不需要监听时，可以调用removeObserver:forKeyPath:方法将KVO移除。需要注意的是，调用removeObserver:forKeyPath:需要在观察者消失之前，否则会导致Crash。
    */
    
    /*
     addObserver的方法
     使用KVO分为三个步骤
     在注册观察者时，可以传入下列参数：
     Observe参数，观察者对象
     keyPath参数，需要观察的属性，由于是字符串形式，传错容易导致Crash，一般利用系统的发射机制
     NSStringFromSelector(@selector(keyPath))
     
     options参数是一个枚举类型
     NSKeyValueObservingOptionNew      接受新值，默认为只接受新值
     NSKeyValueObservingOptionOld      接受旧值
     NSKeyValueObservingOptionInitial  在注册时立即接受一次回调，在改变时也会发送通知
     NSKeyValueObservingOptionPrior    改变之前发一次，改变之后发一次
     
     Context参数 传入任意类型的对象，在接受消息回调的代码上可以接受到这个对象，是KVO中一种传值方式
     
     注意：在调用addObserver方法后，KVO并不会对观察者进行强引用，所以需要注意观察者的生命周期，否则会导致观察者被释放带来的Crash
    */
    
    self.model = [KVOModel new];
    [self.model addObserver:self forKeyPath:NSStringFromSelector(@selector(age)) options:(NSKeyValueObservingOptionNew) context:nil];
    [self.model addObserver:self forKeyPath:NSStringFromSelector(@selector(name)) options:(NSKeyValueObservingOptionNew) context:nil];

    /*
     2、KVO触发模式
     KVO在属性发生改变时的调用是自动的，如果想要手动控制这个调用机制，或想自己实现KVO属性的调用，则可以通过KVO提供的方法进行调用
     详情进行KVOModel实现文件
     并且需要我们自己实现willChangeValueForKey及didChangeValueForKey
    */
    [self.model addObserver:self forKeyPath:@"dog" options:(NSKeyValueObservingOptionNew) context:nil];
    
    
    /*
     KVO底层实现
     1、创建一个子类，NSKVONotyfing_person
     2、重写setName方法
     3、外界改变isa指针
    */
    
}

#pragma mark -------------------监听方法
 -(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@",change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    static int a ;
    [self.model willChangeValueForKey:@"age"];
    self.model.age = [NSString stringWithFormat:@"%d",a++];
    [self.model didChangeValueForKey:@"age"];
    
    self.model.dog.age = [NSString stringWithFormat:@"%d",a++];
    self.model.dog.level = [NSString stringWithFormat:@"%d",a++];
}



@end
