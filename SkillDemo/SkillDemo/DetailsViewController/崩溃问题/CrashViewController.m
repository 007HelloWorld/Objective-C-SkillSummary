//
//  CrashViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/9/26.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "CrashViewController.h"
//#import "NSArray+PJW.h"

@interface CrashViewController ()

@end

@implementation CrashViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    NSArray * arr = @[@"1",@"2",@"3"];
    NSLog(@"%@",[arr objectAtIndex:4]);
    
    
}



@end
