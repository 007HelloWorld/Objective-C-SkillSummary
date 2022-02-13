//
//  CircularReferenceVC.m
//  SkillDemo
//
//  Created by pjw on 2021/3/25.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "CircularReferenceVC.h"

@interface CircularReferenceVC ()

 

@end

@implementation CircularReferenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
        内存消耗，消耗的是RAM/ROM
        内存模型    GC      ARC     MRC
        堆       栈       静态区
        堆是系统管理的
     
        函数变量是在函数执行完之后回收的(strongSelf)
        block内部使用了一次weakSelf，是为了循环引用的问题存在
        在block内部，再次使用strongSelf，是为了延长weakSelf的生命周期，在需要耗时的地方，如果当时视图消失了，调用了析构函数，那么block里面的方法就不能执行，所以需要使用strongSelf，
     __weak typeof(self) weakSelf = self;
     __strong typeof(self) strongSelf = weakSelf;
     
     
     
    */
    

    

    

}





@end
