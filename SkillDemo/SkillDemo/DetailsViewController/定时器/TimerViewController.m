//
//  TimerViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/9/3.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "TimerViewController.h"
#import "TGCDTimer.h"

@interface TimerViewController ()
@property(nonatomic,strong)TGCDTimer *gTimer;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    //        NSLog(@"===调用定时器===");
    //        [TGCDTimer scheduledTimerWithTimeInterval:2 repeat:NO queue:dispatch_get_global_queue(0, 0) block:^{
    //            NSLog(@"===定时器回调===");
    //        }];
    //
    TGCDTimer *gTimer = [[TGCDTimer alloc] initWithTimeInterval:2 repeat:YES queue:dispatch_get_global_queue(0, 0) block:^{
        NSLog(@"===定时器回调===");
    }];
    self.gTimer = gTimer;
    //
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSLog(@"===定时器暂停===");
    //            [gTimer stop];
    //        });
        
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSLog(@"===定时器重新开始===");
    //            [gTimer restart];
    //        });
            
    //        dispatch_queue_t cQueue = dispatch_queue_create("cq", DISPATCH_QUEUE_CONCURRENT);
    //        for (int i = 0; i < 10; i++) {
    //            dispatch_async(cQueue, ^{
    //                [TGCDTimer scheduledTimerWithTimeInterval:2 repeat:YES queue:dispatch_get_global_queue(0, 0) block:^{
    //                    NSLog(@"==%d==定时器回调===", i);
    //                }];
    //            });
    //        }

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.gTimer stop];
}


@end
