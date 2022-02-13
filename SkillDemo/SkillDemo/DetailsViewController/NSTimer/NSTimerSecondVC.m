//
//  NSTimerSecondVC.m
//  SkillDemo
//
//  Created by pjw on 2021/3/27.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "NSTimerSecondVC.h"

@interface NSTimerSecondVC ()

@end

@implementation NSTimerSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
