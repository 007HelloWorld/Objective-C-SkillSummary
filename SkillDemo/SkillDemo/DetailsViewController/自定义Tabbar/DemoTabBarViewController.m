//
//  DemoTabBarViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/10/11.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "DemoTabBarViewController.h"
#import "HomePageViewController.h"
#import "MineViewController.h"

@interface DemoTabBarViewController ()

@end

@implementation DemoTabBarViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self creatSubViews];
}

- (void)creatSubViews
{
    self.selectedIndex = 0;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.opaque = YES;
    
    self.mainTabBar = [[MainTabBar alloc] init];
    [self.mainTabBar.plusItem addTarget:self action:@selector(plusAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setValue:self.mainTabBar forKey:@"tabBar"];
    
    [self setupChildVc:[HomePageViewController new] title:@"工作台" image:@"new_home_normal" selectedImage:@"new_home_selected"];
    [self setupChildVc:[MineViewController new] title:@"我的" image:@"new_mine_normal" selectedImage:@"new_mine_selected"];
    
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor], NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:10.0]} forState:UIControlStateSelected];
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

-(void)plusAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
