//
//  LocalStoreViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/8/30.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "LocalStoreViewController.h"
#import "ArchiveViewController.h"
#import "CoreDataViewController.h"
#import "FMDBViewController.h"


@interface LocalStoreViewController ()

@end

@implementation LocalStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    for (int i = 0; i < 4; i ++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100 + 100 * i, 100, 60)];
        if (i == 0) {
            [btn setTitle:@"归档" forState:UIControlStateNormal];
        }else if (i == 1){
            [btn setTitle:@"CoreData" forState:UIControlStateNormal];
        }else if (i == 2){
            [btn setTitle:@"FMDB" forState:UIControlStateNormal];
        }else if (i == 3){
            [btn setTitle:@"" forState:UIControlStateNormal];
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
        ArchiveViewController * archive = [ArchiveViewController new];
        [self.navigationController pushViewController:archive animated:YES];
    }else if (index == 1){
        CoreDataViewController * coreData = [CoreDataViewController new];
        [self.navigationController pushViewController:coreData animated:YES];
    }else if (index == 2){
        FMDBViewController * fmdb = [FMDBViewController new];
        [self.navigationController pushViewController:fmdb animated:YES];
    }else if (index == 3){
        
    }
}



@end
