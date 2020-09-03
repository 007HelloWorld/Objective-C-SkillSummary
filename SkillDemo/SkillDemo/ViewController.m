//
//  ViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/8/30.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "ViewController.h"
#import "SkillTableViewCell.h"
#import "SkillTableDataSource.h"
#import "SkillModel.h"
#import "SkillViewModel.h"
#import "LocalStoreViewController.h"
#import "SafetyViewController.h"


@interface ViewController ()<UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;/**<*/
@property (nonatomic, strong) SkillTableDataSource * dataSource;
@property (nonatomic, strong) SkillViewModel * viewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"iOS技能树";
    
    //绑定数据
    [self bindModel];
    //加载视图
    [self setupSubViews];

}

-(void)bindModel{
    __weak typeof(self) weekSelf = self;
    
    //取到数据进行页面赋值
    self.dataSource = [[SkillTableDataSource alloc] initWithCellIdentifier:@"SkillTableViewCell" configureInfo:^(SkillTableViewCell * cell, SkillModel * model, NSIndexPath * _Nonnull indexPath) {
        cell.skillName.text = model.name;
    }];
    
    //获取到数据进行数据绑定
    self.viewModel = [[SkillViewModel alloc]initWithSucc:^(id  _Nonnull datas) {
        weekSelf.dataSource.datas = datas;
    } fail:^{
    }];
    
    //网络请求
    [self.viewModel refreshAction];
}

-(void)setupSubViews{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerClass:[SkillTableViewCell class] forCellReuseIdentifier:@"SkillTableViewCell"];
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        LocalStoreViewController * local = [LocalStoreViewController new];
        [self.navigationController pushViewController:local animated:YES];
    }else if (indexPath.row == 1){
        
    }else if (indexPath.row == 2){
        
    }else if (indexPath.row == 3){
        
    }else if (indexPath.row == 4){
        
    }else if (indexPath.row == 5){
        
    }else if (indexPath.row == 6){
        
    }else if (indexPath.row == 7){
        
    }else if (indexPath.row == 8){
        
    }else if (indexPath.row == 9){
        
    }else if (indexPath.row == 10){
        SafetyViewController * safety = [SafetyViewController new];
        [self.navigationController pushViewController:safety animated:YES];
    }

}

@end
