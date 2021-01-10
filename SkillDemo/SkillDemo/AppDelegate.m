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
//激光推送
#import <JPUSHService.h>
//腾讯bugly
#import <Bugly/Bugly.h>



//Bugly 的AppId 生产环境
#define BuglyAppId @"ad5c529458asd"//ad5c529458

@interface AppDelegate ()<UNUserNotificationCenterDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    self.window.rootViewController = navi;

    
    [self registerNotification];
    
    //激光代码初始化
    [self setupJPushWithLunchOptions:launchOptions isProduction:YES withAppKey:@"d205157afdbb491ec203700edd"];//d205157afdbb491ec203700e

    //初始化Bugly
    [Bugly startWithAppId:BuglyAppId];

    
    return YES;
}

- (void)setupJPushWithLunchOptions:(NSDictionary *)launchOptions isProduction:(BOOL)isProduction withAppKey:(NSString *)appKey
{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|UNAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:@"AppStore"
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
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



#pragma mark ------------------------激光推送项目方法
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark -- JPushDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [self receiveNotification:userInfo];
    NSLog(@"7777777777777777777777777");
    completionHandler();  // 系统要求执行这个方法
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"33333333333333333333");
        NSLog(@"%@",userInfo);
        [JPUSHService handleRemoteNotification:userInfo];
    }
    NSLog(@"5555555555555555555");
    [self receiveNotification:userInfo];
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"666666666666666666666666");
    [self receiveNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

//跳转问题
- (void)receiveNotification:(NSDictionary *)userInfo{
    
    /*
     
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [userInfo valueForKey:@"soundMessage"];
    NSString *soundCon = [aps objectForKey:@"alert"];
    // 针对 10.0 以下的iOS系统进行处理
    if ([soundCon containsString:@"抢单"]) {
        [[KELPSpeechSynthesizer sharedSpeechSynthesizer] isSpeaking];
        [[KELPSpeechSynthesizer sharedSpeechSynthesizer] speakString:@"您有新的维修单可以抢单，请注意查收"];
    }else if ([soundCon containsString:@"投诉"]) {
        [[KELPSpeechSynthesizer sharedSpeechSynthesizer] isSpeaking];
        [[KELPSpeechSynthesizer sharedSpeechSynthesizer] speakString:@"您有一个投诉工单待响应，请及时响应"];
    }else if ([soundCon containsString:@"问询"]) {
        [[KELPSpeechSynthesizer sharedSpeechSynthesizer] isSpeaking];
        [[KELPSpeechSynthesizer sharedSpeechSynthesizer] speakString:@"您有一个问询工单待处理，请及时处理"];
    }
    */
    
    NSDictionary *dictExtra = nil;
    NSString *extra = userInfo[@"iosNotification extras key"];
    if(extra.length > 0){
        dictExtra = [NSJSONSerialization JSONObjectWithData:[extra dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    }

    if([dictExtra isKindOfClass:[NSDictionary class]] && dictExtra[@"token"]){
        [self didReceiveVideoMeetingNotification:dictExtra];
    }else{
//        AVAudioSession *session = [AVAudioSession sharedInstance];
//        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//        [session setActive:YES error:nil];
    }
    
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)didReceiveVideoMeetingNotification:(NSDictionary *)dictInfo{

//    if(self.enteringRoom)
//        return ;
//
//    self.enteringRoom = YES;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//
//        int waiting = 0;
//        while (waiting < 10 && !self.afterLaunched) {
//
//            usleep(500000);
//            waiting++;
//        }
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if(self.afterLaunched){
//
//                NSString *token = dictInfo[@"token"];
//                NSString *roomId = dictInfo[@"roomid"]?dictInfo[@"roomid"]:dictInfo[@"type"];
//
//                [self enterRoom:token roomId:roomId];
//            }else{
//                self.enteringRoom = NO;
//            }
//        });
//    });
}


- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification {
    NSLog(@"**********************");
}

- (void)jpushNotificationAuthorization:(JPAuthorizationStatus)status withInfo:(NSDictionary *)info {
    NSLog(@"**********************");
}


//登录账号的时候登录
-(void)login{
    NSString * jgUserId = @"asdasdasdad";//用户token∫
    [JPUSHService setAlias:jgUserId completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"%@",iAlias);
        if (iResCode == 0) {
            NSLog(@"************%@", jgUserId);
            NSLog(@"************添加别名成功");
        }
    } seq:1];

}


//退出账号的时候退出
- (void)loginOut:(NSNotification *)noti
{
//    CUCFUDFRemove(kTicket);
//    CUCFUDFRemove(Create_org_allId);
//    CUCFUDFRemove(Create_org_allName);
    
//    //清空地块 选择数据
//    [[UserTool sharedInstance] cleanApproveAddressData];
    
    WS(weakSelf)
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"%@",iAlias);
        if (iResCode == 0) {
            NSLog(@"************%@", iAlias);
            NSLog(@"************解绑别名成功");
        }
    } seq:1];
    
//    self.loginVC.loginSuccessBlock = ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
////            weakSelf.window.rootViewController = weakSelf.tabVC;
//            [self setAsTabbarViewController];
//        });
//    };
//    self.window.rootViewController = self.loginVC;
//    self.tabVC = nil;
}




@end
