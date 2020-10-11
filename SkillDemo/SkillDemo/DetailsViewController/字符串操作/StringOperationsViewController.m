//
//  StringOperationsViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "StringOperationsViewController.h"

@interface StringOperationsViewController ()

@end

@implementation StringOperationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self dieTausendstel];
    
    
}

-(void)dieTausendstel{
    NSString * str = [NSString thousandsString:[NSString stringWithFormat:@"%lf",(double)1000000]];
    NSLog(@"千分位输出            %@",str);
}


@end
