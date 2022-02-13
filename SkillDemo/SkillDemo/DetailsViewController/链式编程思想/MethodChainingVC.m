//
//  MethodChainingVC.m
//  SkillDemo
//
//  Created by pjw on 2021/4/11.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "MethodChainingVC.h"
#import "MethodChainingModel.h"

@interface MethodChainingVC ()

@end

@implementation MethodChainingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    MethodChainingModel * model = [MethodChainingModel new];
    model.eat(10).run(20);
    
}


@end
