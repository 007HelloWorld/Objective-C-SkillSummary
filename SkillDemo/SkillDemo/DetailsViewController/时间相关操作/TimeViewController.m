//
//  TimeViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "TimeViewController.h"
#import "TimeModel.h"

@interface TimeViewController ()

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getTime];//获取当前月份前几个月及后几个月的时间信息
    
    
}

-(void)getTime{
    for (int i=0; i<12; i++) {
        TimeModel *monthModel = [[TimeModel alloc]init];
        //之前几个月
        NSString *preMonth = [DemoUtils getLastUnknownMonthWithDateFormat:@"yyyy-MM" num:i-6];//控制前几个月
        
        NSString *cStr = [preMonth substringFromIndex:preMonth.length-2];
        //英文 月数
        monthModel.eMonthStr = [DemoUtils englishMonth:cStr];
        //中文月数
        if([[cStr substringToIndex:1] isEqualToString:@"0"]){
            monthModel.monthStr = [cStr substringFromIndex:cStr.length-1];
        }else{
            monthModel.monthStr = cStr;
        }
        //上一个月
        NSString *preOneMonth = [DemoUtils getLastOneMonthWithDateFormat:@"yyyy-MM"];
        if ([preMonth isEqualToString:preOneMonth]) {
            //选中 状态
            monthModel.selectNumber = @(YES);
        }else{
            //选中 状态
            monthModel.selectNumber = @(NO);
        }
        //年月数
        monthModel.yearsStr = preMonth;
        [self.dataArray addObject:monthModel];
    }
    
    for (int i = 0; i < self.dataArray.count; i ++) {
        TimeModel * model = self.dataArray[i];
        NSLog(@"中文月数-----%@     英文月数-----%@     年月数-----%@",model.monthStr,model.eMonthStr,model.yearsStr);
    }

}



-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
