//
//  AnimationVC.m
//  SkillDemo
//
//  Created by pjw on 2020/11/15.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "AnimationVC.h"
#import "SVGAViewController.h"

@interface AnimationVC ()

@end

@implementation AnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 3; i++) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(100, 100 + 50 * i, 100, 40);
        if (i == 0) {
            [btn setTitle:@"svga" forState:UIControlStateNormal];
        }else if (i == 1){
            [btn setTitle:@"" forState:UIControlStateNormal];
        }else if (i == 2){
            [btn setTitle:@"" forState:UIControlStateNormal];
        }
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)gotoDetail:(UIButton *)btn{
    if (btn.tag == 100) {
        SVGAViewController * svga = [SVGAViewController new];
        [self.navigationController pushViewController:svga animated:YES];
    }else if (btn.tag == 101){
        
    }else if (btn.tag == 102){
        
    }
}



@end
