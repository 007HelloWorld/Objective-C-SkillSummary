//
//  ArchiveViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/8/30.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "ArchiveViewController.h"
#import "Person.h"


@interface ArchiveViewController ()

@end

@implementation ArchiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 4; i ++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100 + 100 * i, 100, 60)];
        if (i == 0) {
            [btn setTitle:@"存值" forState:UIControlStateNormal];
        }else if (i == 1){
            [btn setTitle:@"取值" forState:UIControlStateNormal];
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    if (index == 0) {
        Person * p = [[Person alloc]init];
        p.name = @"小白";
        p.age = 28;
        NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"person.archive"];

        NSString * version = [UIDevice currentDevice].systemVersion;
        if (version.doubleValue >= 11.0) {
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject:p requiringSecureCoding:YES error:nil];
            [data writeToFile:path atomically:YES];
        }else{
            [NSKeyedArchiver archiveRootObject:p toFile:path];
        }
        
    }else if (index == 1){
        NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"person.archive"];
        
        NSString * version = [UIDevice currentDevice].systemVersion;
        if (version.doubleValue >= 11.0) {
            NSData * data = [NSData dataWithContentsOfFile:path];
            NSError * error;
            Person * p = [NSKeyedUnarchiver unarchivedObjectOfClass:[Person class] fromData:data error:&error];
            NSLog(@"%@  %ld",p.name,p.age);
        }else{
            Person * p = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            NSLog(@"%@  %ld",p.name,p.age);
        }
    }
}

@end
