//
//  RotateVC.m
//  SkillDemo
//
//  Created by pjw on 2021/2/19.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "RotateVC.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface RotateVC ()
@property(nonatomic,strong)UILabel * titleL;

@end

@implementation RotateVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * title = [UILabel new];
    title.frame = CGRectMake(0, SCREENHEIGHT-20, SCREENWIDTH, 20);
    title.text = @"这是一个demo";
    title.textColor = [UIColor orangeColor];
    self.titleL = title;
    [self.view addSubview:title];
    
    // 转屏通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChangeRotate:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];

}

- (void)didChangeRotate:(NSNotification*)notice {
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait
        || [[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown) {
        //竖屏

        NSLog(@"竖屏");

        self.titleL.frame = CGRectMake(0, SCREENHEIGHT-20, SCREENWIDTH, 20);
        self.titleL.textAlignment = NSTextAlignmentLeft;
    } else {
        //横屏
        self.titleL.frame = CGRectMake(0, SCREENHEIGHT-20 ,SCREENWIDTH, 20);
        self.titleL.textAlignment = NSTextAlignmentCenter;
        NSLog(@"横屏");
    }
}

@end
