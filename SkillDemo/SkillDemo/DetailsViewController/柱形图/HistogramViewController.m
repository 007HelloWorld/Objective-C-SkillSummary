//
//  HistogramViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "HistogramViewController.h"
#import "HistogramView.h"
#import "HistogramModel.h"


@interface HistogramViewController ()

@property(nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic, strong) PNCircleChart *finishCircle;//工单完成率 圆环

@end

@implementation HistogramViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self histogram];//柱形图
    
    [self doughnutChart];//环形图
    

}

-(void)histogram{
    //柱形图
    HistogramModel * model1 = [HistogramModel new];
    model1.overallSatisfaction = 0;
    model1.orgName = @"非洲";
    
    HistogramModel * model2 = [HistogramModel new];
    model2.overallSatisfaction = 0.50012;
    model2.orgName = @"欧洲";
    
    HistogramModel * model3 = [HistogramModel new];
    model3.overallSatisfaction = 0.90120;
    model3.orgName = @"美洲";
    
    HistogramModel * model4 = [HistogramModel new];
    model4.overallSatisfaction = 1;
    model4.orgName = @"亚洲";
    
    [self.dataArray addObject:model1];
    [self.dataArray addObject:model2];
    [self.dataArray addObject:model3];
    [self.dataArray addObject:model4];
    
    for (int i = 0; i < self.dataArray.count; i ++) {
        HistogramView * v = [[HistogramView alloc]initWithFrame:CGRectMake(20 + 50 * i, 100, 40, 200)];
        v.backgroundColor = [UIColor orangeColor];
        v.model = self.dataArray[i];
        [self.view addSubview:v];
    }
}

-(void)doughnutChart{
    [self.view addSubview:self.finishCircle];
    [self.finishCircle updateChartByCurrent:@(50)];
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(PNCircleChart*)finishCircle{
    if (!_finishCircle) {
        _finishCircle = [[PNCircleChart alloc] initWithFrame:CGRectMake(20, 400, 40, 40) total:@100.0 current:@0.0 clockwise:YES shadow:YES shadowColor:[DemoUtils colorWithHexString:@"#F1F3F7" alpha:1.0] displayCountingLabel:NO overrideLineWidth:[NSNumber numberWithFloat:5]];
        _finishCircle.countingLabel.textColor = [UIColor blackColor];
        _finishCircle.countingLabel.font = [UIFont boldSystemFontOfSize:13];
        [_finishCircle setStrokeColor:[DemoUtils colorWithHexString:@"#FF9A52" alpha:1.0]];
        [_finishCircle strokeChart];
    }
    return _finishCircle;
}


@end
