//
//  ArithmeticViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/9/6.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "ArithmeticViewController.h"

@interface ArithmeticViewController ()

@end

@implementation ArithmeticViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //冒泡排序
    [self maoPao];
    
    //
    
}



-(void)maoPao{//冒泡排序
    NSMutableArray *arr=[NSMutableArray arrayWithArray:@[@"17",@"28",@"36",@"15",@"29",@"39"]];

    for (int i=0;i<arr.count;i++) {
        for (int j=0; j<arr.count-1-i; j++) {

            if ([arr[j] intValue]>[arr[j+1] intValue]) {

                int temp=[arr[j] intValue];

                arr[j]=arr[j+1];

                arr[j+1]=[NSString stringWithFormat:@"%d",temp];

            }

        }

    }

    NSLog(@"%@",arr);

}



@end
