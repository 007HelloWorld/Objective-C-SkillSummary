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

    /*
        复习沙盒
        1、沙盒目录
            a.Documents
            保存由应用程序产生的文件或数据，例如：游戏进度。涂鸦软件的绘图
            目录中的文件会自动保存到iCloud上
            不要保存从网络上下载下来的文件
            iTunes会备份
    
        2、Library/Cache
            保存临时文件，后续需要使用，例如：缓存图片，离线地图数据
            系统不会自动清理此目录
            程序员需要提供清理此目录的功能
            iTunes不会备份
     
        3、tmp
            保存临时文件，后续不需要使用
            tmp目录中的文件，系统会自动清理
            系统的磁盘空间不足，会自动清理
            系统重启，会清理该文件
            iTunes不会备份
    */
    
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
