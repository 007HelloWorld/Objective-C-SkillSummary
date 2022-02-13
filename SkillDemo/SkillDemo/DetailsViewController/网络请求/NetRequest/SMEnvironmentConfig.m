//
//  SMEnvironmentConfig.m
//  SMProject
//
//  Created by lk on 2019/3/15.
//  Copyright © 2019 浩哥哥. All rights reserved.
//

#import "SMEnvironmentConfig.h"
#import <CPHelperTool/CPHelperTool.h>
#import "SMHttpTool.h"

@implementation SMEnvironmentConfig

+ (void)setHostConfig:(SMEnvironmentConfigType)environmentConfigType
{
    switch (environmentConfigType) {
        case SMEnvironmentConfigTypeOnline: {
            CPLog(@"使用了Online环境配置");
            //生产环境
            [SMHttpTool shareInstance].BASEURL = @"https://smcloud.shimaowy.com";
            [SMHttpTool shareInstance].HTMLBASEURL = @"https://smcloud.shimaowy.com/h5-mobile";
            
            break;
        }
//        case SMEnvironmentConfigTypeTest: {
//            CPLog(@"使用了Test环境配置");
//            //测试环境
//            [SMHttpTool shareInstance].BASEURL = @"https://smcloud-test.shimaowy.com";
//            [SMHttpTool shareInstance].HTMLBASEURL = @"https://smcloud-test.shimaowy.com/h5-mobile";
//
//            break;
//        }
        case SMEnvironmentConfigTypeUat: {
            CPLog(@"使用了Uat环境配置");
            //Uat环境
            [SMHttpTool shareInstance].BASEURL = @"https://smcloud-uat.shimaowy.com";
            [SMHttpTool shareInstance].HTMLBASEURL = @"https://smcloud-uat.shimaowy.com/h5-mobile";

            break;
        }
        case SMEnvironmentConfigTypeBluetooth: {
            CPLog(@"使用了蓝牙环境配置");
            //Uat环境
            [SMHttpTool shareInstance].BASEURL = @"http://172.16.0.69:9191";
            [SMHttpTool shareInstance].HTMLBASEURL = @"https://smcloud-uat.shimaowy.com/h5-mobile";

            break;
        }
            
            
            
            
//        case SMEnvironmentConfigTypeDev: {
//            CPLog(@"使用了开发环境配置");
//            //开发环境
//            [SMHttpTool shareInstance].BASEURL = @"http://172.16.0.108:80";
//            [SMHttpTool shareInstance].HTMLBASEURL = @"http://172.16.0.108:80/h5-mobile";
//
//            break;
//        }
//        case SMEnvironmentConfigTypeYC: {
//            CPLog(@"使用了压测环境配置");
//            //压测环境
//            [SMHttpTool shareInstance].BASEURL = @"http://139.224.240.238:80";
//            [SMHttpTool shareInstance].HTMLBASEURL = @"http://139.224.240.238:80/h5-mobile";
//
//            break;
//        }
//            case SMEnvironmentConfigTypeshengchan: {
//                NSLog(@"使用了shengchan环境配置");
//                //shengchan环境
//                [SMHttpTool shareInstance].BASEURL = @"https://shengchan.shimaowy.com";
//                [SMHttpTool shareInstance].HTMLBASEURL = @"https://shengchan.shimaowy.com/h5-mobile";
//            }
//                break;
//            case SMEnvironmentConfigTypeUatshengchan: {
//                           NSLog(@"使用了shengchan uat环境配置");
//                           //shengchan环境
//                           [SMHttpTool shareInstance].BASEURL = @"https://uat.shimaowy.com";
//                           [SMHttpTool shareInstance].HTMLBASEURL = @"https://uat.shimaowy.com/h5-mobile";
//                       }
//                           break;
//            case SMEnvironmentConfigTypeTestshengchan: {
//                           NSLog(@"使用了shengchan环境配置");
//                           //shengchan环境
//                           [SMHttpTool shareInstance].BASEURL = @"https://ceshi.shimaowy.com";
//                           [SMHttpTool shareInstance].HTMLBASEURL = @"https://ceshi.shimaowy.com/h5-mobile";
//                       }
//                           break;
//            case SMEnvironmentConfigTypeQianYi: {
//                NSLog(@"使用了shengchan环境配置");
//                //shengchan环境
//                [SMHttpTool shareInstance].BASEURL = @"http://106.75.139.17:8087";
//                [SMHttpTool shareInstance].HTMLBASEURL = @"http://106.75.139.17:8087/h5-mobile";
//            }
//                break;
    }
}


@end
