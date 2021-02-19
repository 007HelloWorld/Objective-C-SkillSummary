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
#import "FileViewController.h"
#import "CLCacheManager.h"
#import "PJWFMDBVC.h"


@interface LocalStoreViewController ()

@end

@implementation LocalStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    for (int i = 0; i < 5; i ++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100 + 100 * i, 200, 60)];
        if (i == 0) {
            [btn setTitle:@"归档" forState:UIControlStateNormal];
        }else if (i == 1){
            [btn setTitle:@"CoreData" forState:UIControlStateNormal];
        }else if (i == 2){
            [btn setTitle:@"FMDB" forState:UIControlStateNormal];
        }else if (i == 3){
            [btn setTitle:@"图片文件存储" forState:UIControlStateNormal];
        }else if (i == 4){
            [btn setTitle:@"BGFMDB复杂数据存储" forState:UIControlStateNormal];
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    
    NSDictionary *dic = [CLCacheManager objectForkey:@"pjw"];
    NSLog(@"%@",dic);
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(80, 180, 200, 20)];
    NSArray * arr = dic[@"pjw"];
    label.text = [NSString stringWithFormat:@"%ld",arr.count];
    [self.view addSubview:label];
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
        FileViewController * vc = [FileViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 4){
        PJWFMDBVC * vc = [PJWFMDBVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
