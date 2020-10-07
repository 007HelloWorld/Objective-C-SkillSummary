//
//  TripartiteLoginVC.m
//  SkillDemo
//
//  Created by pjw on 2020/10/6.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "TripartiteLoginVC.h"
//Apple登录
#import <AuthenticationServices/AuthenticationServices.h>
#import "SignInApple.h"




@interface TripartiteLoginVC ()<ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>

//防止被释放，回调方法不会走，或者也可以把SignInApple这个类写成单例
@property(nonatomic,strong)SignInApple * signInApple;

@end

@implementation TripartiteLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 4; i ++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100 + 100 * i, 100, 60)];
        if (i == 0) {
            [btn setTitle:@"微信登录" forState:UIControlStateNormal];
        }else if (i == 1){
            [btn setTitle:@"一键登录" forState:UIControlStateNormal];
        }else if (i == 2){
            [btn setTitle:@"QQ登录" forState:UIControlStateNormal];
        }else if (i == 3){
            [btn setTitle:@"Apple登录" forState:UIControlStateNormal];
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    [self configUI];//Apple登录布局
}

-(void)btnClick:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    if (index == 0) {
        [self weiXin];
    }else if (index == 1){
        [self yiJian];
    }else if (index == 2){
        [self qq];
    }else if (index == 3){
        [self appleLogin];
    }
}

-(void)weiXin{//微信登录
    
}

-(void)yiJian{//一键登录
    
}

-(void)qq{//qq登录
    
}

-(void)appleLogin{//苹果登录
    
    /*
     1.导入系统头文件#import <AuthenticationServices/AuthenticationServices.h>，添加Sign In with Apple登录按钮，设置ASAuthorizationAppleIDButton相关布局，并添加按钮点击响应事件
     2.获取授权码
     3.验证
    */
    

    
    //1.https://www.wangquanwei.com/572.html
    
}

-(void)configUI{
    // 使用系统提供的按钮，要注意不支持系统版本的处理
//    if (@available(iOS 13.0, *)) {
//        // Sign In With Apple Button
//        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeDefault style:ASAuthorizationAppleIDButtonStyleWhite];
//        appleIDBtn.frame = CGRectMake(30, self.view.bounds.size.height - 180, self.view.bounds.size.width - 60, 100);
//        //    appleBtn.cornerRadius = 22.f;
//        [appleIDBtn addTarget:self action:@selector(didAppleIDBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:appleIDBtn];
//    }
    
    // 或者自己用UIButton实现按钮样式
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(100, 100 + 100 * 3, 100, 60);
    addBtn.backgroundColor = [UIColor orangeColor];
    [addBtn setTitle:@"通过Apple登录" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(didCustomBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

// 自己用UIButton按钮调用处理授权的方法
- (void)didCustomBtnClicked{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
    self.signInApple = [[SignInApple alloc] init];
    [self.signInApple handleAuthorizationAppleIDButtonPress];
}

// 使用系统提供的按钮调用处理授权的方法
- (void)didAppleIDBtnClicked{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
    self.signInApple = [[SignInApple alloc] init];
    [self.signInApple handleAuthorizationAppleIDButtonPress];
}

// 如果存在iCloud Keychain 凭证或者AppleID 凭证提示用户
- (void)perfomExistingAccount{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
    self.signInApple = [[SignInApple alloc] init];
    [self.signInApple perfomExistingAccountSetupFlows];
}



@end
