//
//  FileViewController.m
//  SkillDemo
//
//  Created by pjw on 2021/1/23.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "FileViewController.h"
#import "CLCacheManager.h"

@interface FileViewController ()

@end

@implementation FileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        UIImage * image = [UIImage imageNamed:@"new_home_normal"];
        [arr addObject:image];
    }
    [CLCacheManager setArray:arr forKey:@"pjw"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSDictionary *dic = [CLCacheManager objectForkey:@"pjw"];
    NSLog(@"%@",dic);
    
    BOOL success = [CLCacheManager removeForKey:@"pjw"];
    if (success) {
        NSLog(@"asdasdaad");
    }
}


@end
