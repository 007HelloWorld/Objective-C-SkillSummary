//
//  HybridViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/9/5.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "HybridViewController.h"
#import <WebKit/WebKit.h>
#import "UIWebViewController.h"


@interface HybridViewController ()<WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation HybridViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    // 设置偏好设置
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    //是否支持JavaScript
    config.preferences.javaScriptEnabled = YES;
    //不通过用户交互，是否可以打开窗口
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2) configuration:config];
    [self.view addSubview:self.webView];

    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [self.webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    
    WKUserContentController *userCC = config.userContentController;
    //JS调用OC 添加处理脚本
    [userCC addScriptMessageHandler:self name:@"showMobile"];
    [userCC addScriptMessageHandler:self name:@"showName"];
    [userCC addScriptMessageHandler:self name:@"showSendMsg"];
    
    
    for (int i = 0; i < 4; i ++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100, self.view.bounds.size.height/2 + 60 * i + 40, 100, 40)];
        if (i == 0) {
            [btn setTitle:@"不带参数" forState:UIControlStateNormal];
        }else if (i == 1){
            [btn setTitle:@"一个参数" forState:UIControlStateNormal];
        }else if (i == 2){
            [btn setTitle:@"两个参数" forState:UIControlStateNormal];
        }else if (i == 3){
            [btn setTitle:@"UIWebView" forState:UIControlStateNormal];
        }
        btn.tag = 100 + i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"%@",message.body);
    
    if ([message.name isEqualToString:@"showMobile"]) {
        [self showMsg:@"没有参数"];
    }
    
    if ([message.name isEqualToString:@"showName"]) {
        NSString *info = [NSString stringWithFormat:@"%@",message.body];
        [self showMsg:info];
    }
    
    if ([message.name isEqualToString:@"showSendMsg"]) {
        NSArray *array = message.body;
        NSString *info = [NSString stringWithFormat:@"有两个参数: %@, %@ !!",array.firstObject,array.lastObject];
        [self showMsg:info];
    }
}

- (void)showMsg:(NSString *)msg {
    [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}

-(void)btnClick:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    if (index == 0) {
        [self.webView evaluateJavaScript:@"alertMobile()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            //JS 返回结果
            NSLog(@"%@ %@",response,error);
        }];
    }else if (index == 1){
        /*
         *alertName('奥特们打小怪兽')
         *alertName JS方法名
         *奥特们打小怪兽 带的参数
         */
        [self.webView evaluateJavaScript:@"alertName('奥特们打小怪兽')" completionHandler:nil];
    }else if (index == 2){
        /*
         *alertSendMsg('我是参数1','我是参数2')
         *alertSendMsg JS方法名
         *我是参数1 带的参数
         *我是参数2
         */
        [self.webView evaluateJavaScript:@"alertSendMsg('我是参数1','我是参数2')" completionHandler:nil];
    }else if (index == 3){
        UIWebViewController * web = [[UIWebViewController alloc]init];
        [self.navigationController pushViewController:web animated:YES];
    }
}

-(void)removeAllScriptMsgHandle{
    WKUserContentController *controller = self.webView.configuration.userContentController;
    [controller removeScriptMessageHandlerForName:@"showMobile"];
    [controller removeScriptMessageHandlerForName:@"showName"];
    [controller removeScriptMessageHandlerForName:@"showSendMsg"];
}

@end
