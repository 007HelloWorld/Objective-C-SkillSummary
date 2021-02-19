//
//  ConventionsVC.m
//  SkillDemo
//
//  Created by pjw on 2021/2/19.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "ConventionsVC.h"
#import "DemoTableViewCell.h"

@interface ConventionsVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation ConventionsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 600;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DemoTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell loadTitle:@"dasdasdasdasasdasdasdasdasasdasdasdasdasasdasdasdasdasasdasdasdasdasasdasdasdasdasasdasdasdasdasasdasdasdasdas"];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerNib:[UINib nibWithNibName:@"DemoTableViewCell" bundle:nil] forCellReuseIdentifier:@"DemoTableViewCell"];
    }
    return _tableView;
}

@end
