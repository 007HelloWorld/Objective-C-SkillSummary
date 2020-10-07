//
//  UseXIBViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/10/4.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "UseXIBViewController.h"
#import "XIBDemoViewTableViewCell.h"

@interface UseXIBViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableV;

@end

@implementation UseXIBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableV];
    
    
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XIBDemoViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XIBDemoViewTableViewCell"];
    UIImageView * icon = [cell viewWithTag:500];
    icon.backgroundColor = [UIColor orangeColor];
    UILabel * titleLabel = [cell viewWithTag:501];
    titleLabel.text = @"wawaa";
    return cell;
    
}


-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        [_tableV registerNib:[UINib nibWithNibName:@"XIBDemoViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"XIBDemoViewTableViewCell"];
    }
    return _tableV;
}



@end
