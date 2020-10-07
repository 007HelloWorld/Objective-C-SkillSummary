//
//  UpgradeViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/10/1.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "UpgradeViewController.h"

@interface UpgradeViewController ()

@end

@implementation UpgradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //OC版本
    [self checkVersion];
    
    //swift版本
    /*
     let currentVersion = "1.2.1"
     let serverVersion = "1.11.1"
     if currentVersion.compare(serverVersion, options: .numeric) == .orderedAscending {
        print("需要更新")
      }
    */
}

- (void)checkVersion{
    
    NSString * versionStr = @"1.0.1";
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    if([currentVersion compare:versionStr options:NSNumericSearch] != NSOrderedAscending){
        return;
    }
    
    NSString *targetString = [NSString stringWithFormat:@"当前版本:%@最新版本:%@", currentVersion, versionStr];
    UIAlertView *WXinstall=[[UIAlertView alloc]initWithTitle:@"检测到版本升级" message:targetString delegate:self cancelButtonTitle:nil otherButtonTitles:@"马上升级", nil];//一般在if判断中加入
    [WXinstall show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //跳转网页 下载
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://smcloud.shimaowy.com/releases"]] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
        
    }];
}



@end
