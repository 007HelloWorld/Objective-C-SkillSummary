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
#import "TimerViewController.h"
#import "HybridViewController.h"
#import "Multi-threadViewController.h"
#import "LocalDeliveryViewController.h"
#import "RunTimeViewController.h"
#import "ArithmeticViewController.h"
#import "DateViewController.h"
#import "CrashViewController.h"
#import "RACViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UpgradeViewController.h"
#import "UseXIBViewController.h"
#import "TripartiteLoginVC.h"
#import "PayViewController.h"
#import "CoverViewController.h"
#import "DemoTabBarViewController.h"
#import "ProgressBarViewController.h"
#import "TimeViewController.h"
#import "HistogramViewController.h"
#import "StringOperationsViewController.h"
#import "EwmViewController.h"
#import "AnimationVC.h"
#import "ScreenViewController.h"


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
    
    //添加监听
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"NOTI" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"通知的接受     %@",x.userInfo);
    }];

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
        HybridViewController * hybrid = [HybridViewController new];
        [self.navigationController pushViewController:hybrid animated:YES];
    }else if (indexPath.row == 2){
        Multi_threadViewController * thread = [Multi_threadViewController new];
        [self.navigationController pushViewController:thread animated:YES];
    }else if (indexPath.row == 3){
        
    }else if (indexPath.row == 4){
        LocalDeliveryViewController * local = [LocalDeliveryViewController new];
        [self.navigationController pushViewController:local animated:YES];
    }else if (indexPath.row == 5){
        TimerViewController * timer = [TimerViewController new];
        [self.navigationController pushViewController:timer animated:YES];
    }else if (indexPath.row == 6){
        RunTimeViewController * timer = [RunTimeViewController new];
        [self.navigationController pushViewController:timer animated:YES];
    }else if (indexPath.row == 7){
        ArithmeticViewController * arithmetic = [ArithmeticViewController new];
        [self.navigationController pushViewController:arithmetic animated:YES];
    }else if (indexPath.row == 8){
        AnimationVC * vc = [AnimationVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 9){
        RACViewController * rac = [RACViewController new];
        [self.navigationController pushViewController:rac animated:YES];
    }else if (indexPath.row == 10){
        SafetyViewController * safety = [SafetyViewController new];
        [self.navigationController pushViewController:safety animated:YES];
    }else if (indexPath.row == 11){
        DateViewController * date = [DateViewController new];
        [self.navigationController pushViewController:date animated:YES];
    }else if (indexPath.row == 12){
        CrashViewController * crash = [CrashViewController new];
        [self.navigationController pushViewController:crash animated:YES];
    }else if (indexPath.row == 13){
        UpgradeViewController * upgrade = [UpgradeViewController new];
        [self.navigationController pushViewController:upgrade animated:YES];
    }else if (indexPath.row == 14){
        UseXIBViewController * xib = [UseXIBViewController new];
        [self.navigationController pushViewController:xib animated:YES];
    }else if (indexPath.row == 15){
        TripartiteLoginVC * login = [TripartiteLoginVC new];
        [self.navigationController pushViewController:login animated:YES];
    }else if (indexPath.row == 16){
        PayViewController * pay = [PayViewController new];
        [self.navigationController pushViewController:pay animated:YES];
    }else if (indexPath.row == 17){
        CoverViewController * cover = [CoverViewController new];
        [self.navigationController pushViewController:cover animated:YES];
    }else if (indexPath.row == 18){
        DemoTabBarViewController * tab = [DemoTabBarViewController new];
        [self.navigationController pushViewController:tab animated:YES];
    }else if (indexPath.row == 19){
        ProgressBarViewController * progress = [ProgressBarViewController new];
        [self.navigationController pushViewController:progress animated:YES];
    }else if (indexPath.row == 20){
        TimeViewController * time = [TimeViewController new];
        [self.navigationController pushViewController:time animated:YES];
    }else if (indexPath.row == 21){
        HistogramViewController * histogram = [HistogramViewController new];
        [self.navigationController pushViewController:histogram animated:YES];
    }else if (indexPath.row == 22){
        StringOperationsViewController * stringOperations = [StringOperationsViewController new];
        [self.navigationController pushViewController:stringOperations animated:YES];
    }else if (indexPath.row == 23){
        EwmViewController * ewm = [EwmViewController new];
        [self.navigationController pushViewController:ewm animated:YES];
    }else if (indexPath.row == 24){
        ScreenViewController * screen = [ScreenViewController new];
        [self.navigationController pushViewController:screen animated:YES];
    }else if (indexPath.row == 25){
//        EwmViewController * ewm = [EwmViewController new];
//        [self.navigationController pushViewController:ewm animated:YES];
    }
    
    
    
    
    
    
    
}

@end
