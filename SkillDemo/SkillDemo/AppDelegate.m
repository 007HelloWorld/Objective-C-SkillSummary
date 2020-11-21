//
//  AppDelegate.m
//  SkillDemo
//
//  Created by pjw on 2020/8/30.
//  Copyright © 2020 pjw. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

//银联支付所需库文件
#import <CommonCrypto/CommonDigest.h>
/*! 阿里支付 */
#import <AlipaySDK/AlipaySDK.h>
//银联支付
#import "UPPaymentControl.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    self.window.rootViewController = navi;

    
    [self registerNotification];
    
    return YES;
}

- (void)registerNotification {
    UNAuthorizationOptions options = UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge;
    UNUserNotificationCenter.currentNotificationCenter.delegate = self;
    [UNUserNotificationCenter.currentNotificationCenter requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 允许授权
        } else {
            // 不允许授权
        }
    }];
    
    
    // 获取用户对通知的设置
    // 通过settings.authorizationStatus 来处理用户没有打开通知授权的情况
    [UNUserNotificationCenter.currentNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        NSLog(@"%@",settings);
    }];
}

// 在前台时 收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge);
}


// 点击通知，从后台进入前台
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSString *identifier =  response.actionIdentifier;
    
    if ([identifier isEqualToString:@"open"]) {
        NSLog(@"打开操作");
    } else if ([identifier isEqualToString:@"close"]) {
        NSLog(@"关闭操作");
    }
    completionHandler();
}





#pragma mark ---------------银联支付
- (NSString *) readPublicKey:(NSString *) keyName
{
    if (keyName == nil || [keyName isEqualToString:@""]) return nil;

    NSMutableArray *filenameChunks = [[keyName componentsSeparatedByString:@"."] mutableCopy];
    NSString *extension = filenameChunks[[filenameChunks count] - 1];
    [filenameChunks removeLastObject]; // remove the extension
    NSString *filename = [filenameChunks componentsJoinedByString:@"."]; // reconstruct the filename with no extension

    NSString *keyPath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];

    NSString *keyStr = [NSString stringWithContentsOfFile:keyPath encoding:NSUTF8StringEncoding error:nil];

    return keyStr;
}

-(BOOL) verify:(NSString *) resultStr {

    //此处的verify，商户需送去商户后台做验签
    return NO;
}




#pragma mark -- 支付回调相关
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options

{
//        BOOL result = [UMSocialSnsService handleOpenURL:url];
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
//    if (result == FALSE) {
        //新浪微博
//        NSString *urlAbsoluteString =[url absoluteString];
//        NSString *sinaPrefix = [NSString stringWithFormat:@"wb%@", SinaAPP_ID];
//        if ([urlAbsoluteString hasPrefix:sinaPrefix]) {
//            return [WeiboSDK handleOpenURL:url delegate:self];
//        }
//        NSLog(@"%@", urlAbsoluteString);

        if ([url.host isEqualToString:@"uppayresult"]) {//银联

            [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUPPayStatusChanged object:code userInfo:data];

            }];
            return YES;
        }
        if ([url.host isEqualToString:@"safepay"]) {//支付宝
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                //NotificationAliPayStatusChanged
                NSLog(@"%@",resultDic);

//                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationAliPayStatusChanged object:resultDic userInfo:nil];
            }];
            return YES;

        }
        else if([url.host isEqualToString:@"pay"]){//微信支付

            [WXApi handleOpenURL:url delegate:self];
        }
        return YES;
//    }
//    return result;
}

////微信支付回调
//- (void) onResp:(BaseResp*)resp{
//
//    if([resp isKindOfClass:[SendMessageToWXResp class]]){}
//
//    if([resp isKindOfClass:[PayResp class]]){
//        //支付返回结果，实际支付结果需要去微信服务器端查询
//        //        strTitle = [NSString stringWithFormat:@"支付结果"];
//        NSNumber *result;
//        result = [NSNumber numberWithInt:resp.errCode];
//        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWXPayStatusChanged object:result];
//    }
//}



@end
