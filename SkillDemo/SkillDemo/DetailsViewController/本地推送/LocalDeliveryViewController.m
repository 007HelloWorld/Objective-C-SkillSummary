//
//  LocalDeliveryViewController.m
//  SkillDemo
//
//  Created by pjw on 2020/9/6.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "LocalDeliveryViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface LocalDeliveryViewController ()

@end

@implementation LocalDeliveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //判断推送权限是否打开，没打开，跳转到设置页面
    [self checkCurrentNotificationStatus];
    
    [self addNotification];
}

- (void)addNotification {
    // 创建一个通知内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.badge = @1;
    content.title = @"title";
    content.subtitle = @"subtitle";
    content.body = @"body";
    content.sound = [UNNotificationSound defaultSound];
    content.categoryIdentifier = @"category";
    
    // 通知触发器
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:false];
    // 通知请求
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"noti" content:content trigger:trigger];
    //添加通知
    [UNUserNotificationCenter.currentNotificationCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
        NSLog(@"error:%@",error);
    }];
    
    
    // 添加通知的一些操作
    UNNotificationAction *openAction = [UNNotificationAction actionWithIdentifier:@"open" title:@"打开" options:UNNotificationActionOptionForeground];
    UNNotificationAction *closeAction = [UNNotificationAction actionWithIdentifier:@"close" title:@"关闭" options:UNNotificationActionOptionDestructive];
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"category" actions:@[openAction, closeAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        
    NSSet *sets = [NSSet setWithObject:category];
    [UNUserNotificationCenter.currentNotificationCenter setNotificationCategories:sets];
}


- (void)removeNotifiation {
    // 移除 待处理的通知
    [UNUserNotificationCenter.currentNotificationCenter removePendingNotificationRequestsWithIdentifiers:@[@"noti"]];
    // 移除 已经处理的通知
    [UNUserNotificationCenter.currentNotificationCenter removeDeliveredNotificationsWithIdentifiers:@[@"noti"]];
    
    // 移除所有的通知
    [UNUserNotificationCenter.currentNotificationCenter removeAllDeliveredNotifications];
    [UNUserNotificationCenter.currentNotificationCenter removeAllPendingNotificationRequests];
}


//检查手机是否开启推送权限功能
-(void)checkCurrentNotificationStatus{
    if (@available(iOS 10, *)) {//手机系统是ios10.0及以上系统版本
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                [self showAlrtToSetting];// 没权限
            }
        }];
    }else if (@available(iOS 8, *)){//手机系统是ios8.0及以上系统版本
        UIUserNotificationSettings * setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (setting.types == UIUserNotificationTypeNone) {
            [self showAlrtToSetting];// 没权限
        }
    }else{
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (type == UIUserNotificationTypeNone){
            [self showAlrtToSetting];// 没权限
        }
    }
}


#pragma mark 没权限的弹窗
-(void)showAlrtToSetting{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"您还没有允许****权限" message:@"去设置一下吧" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    
    UIAlertAction * setAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
            }
        });
    }];
    [alert addAction:cancelAction];
    [alert addAction:setAction];
    [self presentViewController:alert animated:YES completion:nil];
}





@end
