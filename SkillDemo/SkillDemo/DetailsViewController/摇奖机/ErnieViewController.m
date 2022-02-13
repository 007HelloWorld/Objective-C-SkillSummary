//
//  ErnieViewController.m
//  SkillDemo
//
//  Created by pjw on 2021/3/13.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "ErnieViewController.h"

@interface ErnieViewController ()
@property (weak, nonatomic) IBOutlet UILabel *first;
@property (weak, nonatomic) IBOutlet UILabel *second;
@property (weak, nonatomic) IBOutlet UILabel *three;

@property(nonatomic,strong)NSOperationQueue * queue;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ErnieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (IBAction)btnClick:(UIButton *)sender {
    //当队列中有操作的时候，不添加操作      当队列中没有可操作的线程时，往里面添加任务
    if (self.queue.operationCount == 0) {
        //异步执行，添加操作
        [self.queue addOperationWithBlock:^{
            [self random];
        }];
        [self.btn setTitle:@"暂停" forState:UIControlStateNormal];
        self.queue.suspended = NO;                                     //已经开始随机，那么此时队列就是继续状态
    }else{
        //正在执行的时候，暂停
        //先把当前的操作执行完毕，暂停后继续操作
        self.queue.suspended = YES;
        [self.btn setTitle:@"继续" forState:UIControlStateNormal];
    }
}

-(void)random{
    while (!self.queue.isSuspended) {
        [NSThread sleepForTimeInterval:0.05];
        //生成随机数  【0，10） 0-9
        int num1 = arc4random_uniform(10);
        int num2 = arc4random_uniform(10);
        int num3 = arc4random_uniform(10);

        //回到主线程上更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.first.text = [NSString stringWithFormat:@"%d",num1];
            self.second.text = [NSString stringWithFormat:@"%d",num2];
            self.three.text = [NSString stringWithFormat:@"%d",num3];
        }];
    }
}

-(NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}


@end
