//
//  SkillViewModel.m
//  SkillDemo
//
//  Created by pjw on 2020/8/30.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "SkillViewModel.h"
#import "SkillModel.h"

@interface SkillViewModel ()

@property (nonatomic, copy) succ succ;/**<请求成功*/
@property (nonatomic, copy) fail fail;/**<请求成功*/
@property (nonatomic,strong) NSArray * dataArr;

@end

@implementation SkillViewModel

- (instancetype)initWithSucc:(succ)succ fail:(fail)fail {
    self = [super init];
    if (self) {
        _succ = succ;
        _fail = fail;
        
        self.succ(self.datas);
    }
    return self;
}


- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)refreshAction {
    //模拟请求
    for (int i = 0; i < self.dataArr.count; i ++) {
        SkillModel * model = [SkillModel new];
        model.name = self.dataArr[i];
        [self.datas addObject:model];
    }
    
    if (self.succ) {
        self.succ(self.datas);
    }
}

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@"本地存储",@"原生与js交互",@"多线程",@"block",@"推送",@"定时器",@"Runtime",@"算法",@"动画",@"RAC",@"加解密",@"",@"",@""];
    }
    return _dataArr;
}

@end
