//
//  CoverViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "CoverViewController.h"
#import "CoverView.h"

@interface CoverViewController ()

@end

@implementation CoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CoverView * c = [[CoverView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        c.tag = 100;
        [[UIApplication sharedApplication].keyWindow addSubview:c];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CoverView * c = [self.view viewWithTag:100];
    [c removeFromSuperview];
}


@end
