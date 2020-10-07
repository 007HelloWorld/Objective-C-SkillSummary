//
//  PayViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/10/6.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 4; i ++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100 + 100 * i, 100, 60)];
        if (i == 0) {
            [btn setTitle:@"微信支付" forState:UIControlStateNormal];
        }else if (i == 1){
            [btn setTitle:@"支付宝" forState:UIControlStateNormal];
        }else if (i == 2){
            [btn setTitle:@"银联支付" forState:UIControlStateNormal];
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
        [self wxPay];
    }else if (index == 1){
        [self zfbPay];
    }else if (index == 2){
        [self ylPay];
    }
}

-(void)wxPay{
    
}

-(void)zfbPay{
    
}

-(void)ylPay{
    
}


@end
