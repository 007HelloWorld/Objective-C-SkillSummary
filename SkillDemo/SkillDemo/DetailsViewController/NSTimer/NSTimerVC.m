//
//  NSTimerVC.m
//  SkillDemo
//
//  Created by pjw on 2021/3/27.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "NSTimerVC.h"
#import "NSTimerSecondVC.h"
#import "LGProxy.h"

@interface NSTimerVC ()

@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,strong)id target;
@property(nonatomic,strong)LGProxy * lgProxy;



@end

@implementation NSTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
        解决NSTimer定时器不能停止的问题的三种方法
        
    */
    
    //第一种方法
//    self.timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(fire) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
    //第二种方法
//    _target = [NSObject new];
//    class_addMethod([_target class], @selector(fire), (IMP)fireImp, "v@:");
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:_target selector:@selector(fire) userInfo:nil repeats:YES];
    
    
    //第三种方法
    _lgProxy = [LGProxy alloc];
    _lgProxy.target = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:_lgProxy selector:@selector(fire) userInfo:nil repeats:YES];
    
    
}

-(void)fire{
    NSLog(@"     firefirefirefire       ");
}

#pragma mark -------------------第一种
//- (void)didMoveToParentViewController:(UIViewController *)parent{
//    if (parent == nil) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//}

#pragma mark -------------------第二种
void fireImp(id self,SEL _cmd){
    NSLog(@"fireIMP   -----    fire.....");
}

- (void)dealloc
{
    
    //第二种
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"    哇哈哈哈    ");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSTimerSecondVC * vc = [NSTimerSecondVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
