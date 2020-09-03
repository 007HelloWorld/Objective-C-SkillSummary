//
//  AppDelegate.m
//  SkillDemo
//
//  Created by pjw on 2020/8/30.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    self.window.rootViewController = navi;

    return YES;
}





@end
