//
//  JPushVC.m
//  SkillDemo
//
//  Created by pjw on 2021/1/10.
//  Copyright © 2021 pjw. All rights reserved.
//

#import "JPushVC.h"
//JPush
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface JPushVC ()

@end

@implementation JPushVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //退出登录时调用的方法
    [self loginOut];

}

-(void)loginOut{
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"%@",iAlias);
        if (iResCode == 0) {
            NSLog(@"************%@", iAlias);
            NSLog(@"************解绑别名成功");
        }
    } seq:1];
}


@end
