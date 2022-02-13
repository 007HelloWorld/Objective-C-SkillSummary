//
//  SMHttpTool.m
//  SMProject
//
//  Created by lk on 2019/3/15.
//  Copyright © 2019 浩哥哥. All rights reserved.
//

#import "SMHttpTool.h"
#import <AFNetworking.h>
#import <CPHelperTool/CPHelperTool.h>
#import "BaseTools.h"


#define USER_NOTICENTER [NSNotificationCenter defaultCenter]
#define KLogOut                  @"logOut"
//登录对象
#define kTicket                  @"ticket"

@implementation SMHttpTool

+ (SMHttpTool *)shareInstance
{
    static SMHttpTool *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SMHttpTool alloc]init];
    });
    return manager;
}

////GET
//- (void)getHttpAFNWithUrl:(NSString *)url sendDic:(NSDictionary *)sendDic success:(httpRequestSuccess)success faild:(httpRequestFailure)failure
//{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:sendDic];
//    CPLog(@"接口请求地址===%@",url);
//    CPLog(@"接口请求参数===%@",dict);
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    // 设置超时时间
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = 12.f;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    [manager GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//        CPLog(@"%@接口--->请求回来的参数%@", url,responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
////POST
//- (void)postHttpAFNWithUrl:(NSString *)url sendDic:(NSDictionary *)sendDic success:(httpRequestSuccess)success faild:(httpRequestFailure)failure
//{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:sendDic];
//    CPLog(@"接口请求地址===%@",url);
//    CPLog(@"接口请求参数===%@",dict);
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    // 设置超时时间
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = 12.f;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (success) {
//            success(responseObject);
//        }
//        CPLog(@"%@接口--->请求回来的参数%@", url,responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

- (void)httpSessionAutoWithUrl:(NSString *)url sendDic:(NSMutableDictionary *)sendDic httpMethod:(NSString *)httpMethod success:(httpRequestSuccess)success faild:(httpRequestFailure)failure {
    
    //传的Url 和 字典数据
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sendDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonParamsStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]]；
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    request.HTTPMethod = httpMethod;
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:sendDic options:NSJSONWritingPrettyPrinted error:nil];;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
//    NSString *areaIdStr = CUCFUDFGetValue(ORG_IDKey);
//    if (areaIdStr.length) {
//        [request setValue:areaIdStr forHTTPHeaderField:@"divide-id"];
//    }
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* _Nullable data,NSURLResponse* _Nullable response,NSError* _Nullable error)
                                      {
                                          if (error) {
                                              
                                              NSLog(@"请求失败url====%@",url);
                                              NSLog(@"jsonParamsStr====%@",jsonParamsStr);
                                              
                                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)dataTask.response;
                                              NSInteger responseStatue = response.statusCode;
                                              if (responseStatue == 401 || responseStatue == 403) {
                                                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"账号已过期，请重新登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
                                                  UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                                      [USER_NOTICENTER postNotificationName:KLogOut object:nil];
                                                  }];
                                                  [alert addAction:actionOne];
                                                  UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
                                                  if(@available(iOS 13.0, *)) {
                                                      alert.modalPresentationStyle = 0;
                                                  }
                                                  [vc presentViewController:alert animated:YES completion:nil];
                                              }
                                              
                                              if (failure) {
                                                  failure(error);
                                              }
                                          }else{
                                              NSLog(@"url====%@",url);
                                              NSLog(@"jsonParamsStr====%@",jsonParamsStr);
                                              
                                              NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                              NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
                                              if (success) {
                                                  success(resp.statusCode,dict);
                                              }
                                          }
                                      }];
    [dataTask resume];
}

//Get / POST
- (void)httpSessionWithUrl:(NSString *)url sendDic:(NSMutableDictionary *)sendDic httpMethod:(NSString *)httpMethod success:(httpRequestSuccess)success faild:(httpRequestFailure)failure
{
    //传的Url 和 字典数据
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sendDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonParamsStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    request.HTTPMethod = httpMethod;
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:sendDic options:NSJSONWritingPrettyPrinted error:nil];;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
//    NSString *areaIdStr = CUCFUDFGetValue(ORG_IDKey);
//    if (areaIdStr.length) {
//        [request setValue:areaIdStr forHTTPHeaderField:@"divide-id"];
//    }
    
    if (CUCFUDFGetValue(kTicket)){
        NSString *dicJson = CUCFUDFGetValue(kTicket);
        NSDictionary *dic = [NSDictionary jsonStringToDictionary:dicJson];
        [request setValue:[NSString stringWithFormat:@"Bearer %@",dic[@"token"]] forHTTPHeaderField:@"Authorization"];
    }
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* _Nullable data,NSURLResponse* _Nullable response,NSError* _Nullable error)
    {
        if (error) {
            
            NSLog(@"请求失败url====%@",url);
            NSLog(@"jsonParamsStr====%@",jsonParamsStr);
            
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)dataTask.response;
            NSInteger responseStatue = response.statusCode;
            if (responseStatue == 401 || responseStatue == 403) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"账号已过期，请重新登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [USER_NOTICENTER postNotificationName:KLogOut object:nil];
                }];
                [alert addAction:actionOne];
                UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
                if(@available(iOS 13.0, *)) {
                    alert.modalPresentationStyle = 0;
                }
                [vc presentViewController:alert animated:YES completion:nil];
            }
            if (failure) {
                failure(error);
            }
        }else{
            
            NSLog(@"url====%@",url);
            NSLog(@"jsonParamsStr====%@",jsonParamsStr);
            
            //展示json数据
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"responseJson===%@",str);
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
            if (success) {
                success(resp.statusCode,dict);
            }
        }
    }];
    [dataTask resume];
}

//Get / POST 直接拼接路径 不放在body里 没有请求头
- (void)httpSessionWithOutBodyWithUrl:(NSString *)url sendDic:(NSMutableDictionary *)sendDic httpMethod:(NSString *)httpMethod success:(httpRequestSuccess)success faild:(httpRequestFailure)failure {
    
    NSString *paramStr = [self getParamStrWithDictionary:sendDic];
    if ([url rangeOfString:@"?"].location != NSNotFound) {
        url = [NSString stringWithFormat:@"%@&%@",url,paramStr];
    } else {
        url = [NSString stringWithFormat:@"%@?%@",url,paramStr];
    }
    
    //传的Url 和 字典数据
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramStr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonParamsStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    request.HTTPMethod = httpMethod;
//    request.HTTPBody = [paramStr dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* _Nullable data,NSURLResponse* _Nullable response,NSError* _Nullable error) {
        if (error) {
            
            NSLog(@"请求失败url====%@",url);
            NSLog(@"jsonParamsStr====%@",jsonParamsStr);
            
            if (failure) {
                failure(error);
            }
        }else{
            NSLog(@"url====%@",url);
            NSLog(@"jsonParamsStr====%@",jsonParamsStr);
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
            if (success) {
                success(resp.statusCode,dict);
            }
        }
    }];
    [dataTask resume];
}

//Get / POST 直接拼接路径 不放在body里 有请求头
- (void)httpSessionWithBodyWithUrl:(NSString *)url sendDic:(NSMutableDictionary *)sendDic httpMethod:(NSString *)httpMethod success:(httpRequestSuccess)success faild:(httpRequestFailure)failure {
    
    NSString *paramStr = [self getParamStrWithDictionary:sendDic];
    if ([url rangeOfString:@"?"].location != NSNotFound) {
        url = [NSString stringWithFormat:@"%@&%@",url,paramStr];
    } else {
        url = [NSString stringWithFormat:@"%@?%@",url,paramStr];
    }
    
    //传的Url 和 字典数据
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramStr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonParamsStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    request.HTTPMethod = httpMethod;
    if (CUCFUDFGetValue(kTicket))
    {
        NSString *dicJson = CUCFUDFGetValue(kTicket);
        NSDictionary *dic = [NSDictionary jsonStringToDictionary:dicJson];
        [request setValue:[NSString stringWithFormat:@"Bearer %@",dic[@"token"]] forHTTPHeaderField:@"Authorization"];
    }
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
 
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData* _Nullable data,NSURLResponse* _Nullable response,NSError* _Nullable error) {
        if (error) {
            NSLog(@"请求失败url====%@",url);
            NSLog(@"jsonParamsStr====%@",jsonParamsStr);
            
            if (failure) {
                failure(error);
            }
        }else{
            NSLog(@"url====%@",url);
            NSLog(@"jsonParamsStr====%@",jsonParamsStr);
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
            if (success) {
                success(resp.statusCode,dict);
            }
        }
    }];
    [dataTask resume];
}


- (NSString *)getParamStrWithDictionary:(NSDictionary *)dict {
    
    //取出字典所有key
    NSArray *keyArray = [dict allKeys];
    
    NSMutableString *paramStr = [[NSMutableString alloc]init];
    //根据key的顺序提取相应value
    for (NSString *key in keyArray) {
        NSString *value = [dict objectForKey:key];
        if (paramStr.length > 0) {
            [paramStr appendFormat:@"&%@=%@",key,value];
        } else {
            [paramStr appendFormat:@"%@=%@",key,value];
        }
    }
    
    return paramStr;
}


//********************华丽丽的分割线*******************************
//1.登录获取token和userId
- (void)ucAuthWithSuccessed:(NSDictionary *)sendDic success:(httpRequestSuccess)success faild:(httpRequestFailure)failure
{
    NSLog(@"%@", sendDic);
    NSMutableDictionary *Mdict = [NSMutableDictionary dictionaryWithDictionary:sendDic];
    [self httpSessionWithUrl:[NSString stringWithFormat:@"%@/uc/auth", _BASEURL] sendDic:Mdict httpMethod:@"POST" success:success faild:failure];
}

//1.登录获取token和userId
- (void)ucAuthAutoWithSuccessed:(NSDictionary *)sendDic success:(httpRequestSuccess)success faild:(httpRequestFailure)failure
{
//    NSLog(@"%@", sendDic);
    NSMutableDictionary *Mdict = [NSMutableDictionary dictionaryWithDictionary:sendDic];
    [self httpSessionAutoWithUrl:[NSString stringWithFormat:@"%@/uc/auth", _BASEURL] sendDic:Mdict httpMethod:@"POST" success:success faild:failure];
}

//2.6 待办统计-计划、巡查、派工单
- (void)planWaitCountWithSuccessed:(NSDictionary *)sendDic success:(httpRequestSuccess)success faild:(httpRequestFailure)failure
{
    
//    NSMutableDictionary *Mdict = [NSMutableDictionary dictionaryWithDictionary:sendDic];
//    [self httpSessionWithUrl:[NSString stringWithFormat:@"%@/resource-workorder/res-order/plan/waitCount", _BASEURL] sendDic:[Mdict mutableCopy] httpMethod:@"GET" success:success faild:failure];
}

//4 认证
- (void)authenticationWithSuccessed:(NSDictionary *)sendDic success:(httpRequestSuccess)success faild:(httpRequestFailure)failure
{
    NSMutableDictionary *Mdict = [NSMutableDictionary dictionaryWithDictionary:sendDic];
    [self httpSessionWithOutBodyWithUrl:[NSString stringWithFormat:@"%@/apiAccessToken", _ANOTHERBASEURL] sendDic:[Mdict mutableCopy] httpMethod:@"POST" success:success faild:failure];
}

//组织列表接口 不传父id返回根节点
- (void)getOrgListWithSuccessed:(NSDictionary *)sendDic success:(httpRequestSuccess)success faild:(httpRequestFailure)failure {
    //https://smcloud-test.shimaowy.com/user-center/api/usercenter/v1/ucOrg/queryChildrenByUserId
    
    NSMutableDictionary *Mdict = [NSMutableDictionary dictionaryWithDictionary:sendDic];
    if (self.customBASEURL) {
        [self httpSessionWithUrl:[NSString stringWithFormat:@"%@user-center/api/usercenter/v1/ucOrg/queryChildrenByUserId", self.customBASEURL] sendDic:[Mdict mutableCopy] httpMethod:@"POST" success:success faild:failure];
    }else {
        [self httpSessionWithUrl:[NSString stringWithFormat:@"%@/user-center/api/usercenter/v1/ucOrg/queryChildrenByUserId", _BASEURL] sendDic:[Mdict mutableCopy] httpMethod:@"POST" success:success faild:failure];
    }
}

//************************************************************
//1.登录获取token和userId
//protected String Urllogin = "https://smcloud-test.shimaowy.com/uc/auth";
//2.6 待办统计-计划、巡查、派工单
//protected String UrlJHXCPGDNum = "https://smcloud-test.shimaowy.com/resource-workorder/res-order/plan/waitCount";

//************************************************************



//2.7 计划工单-待办
//protected String Urldbjhgd = "https://smcloud-test.shimaowy.com/resource-workorder/res-order/plan/wait-process-list";

//2.13计划工单-已办
//protected String Urlybjhgd = "https://smcloud-test.shimaowy.com/resource-workorder/res-order/plan/done";

//2.43巡查工单-待办
//protected String Urldbxcgd = "https://smcloud-test.shimaowy.com/resource-workorder/res-order/patrol/wait";

//2.44巡查工单-已办
//protected String Urlybxcgd = "https://smcloud-test.shimaowy.com/resource-workorder/res-order/patrol/done";

//2.24派工单-待办列表
//protected String Urldgjpgd = "https://smcloud-test.shimaowy.com/resource-workorder/res-order/distribute/wait";

//2.25派工单-已办列表
//protected String Urlybjpgd = "https://smcloud-test.shimaowy.com/resource-workorder/res-order/distribute/done";






//未找到
//protected String Urldikuai = "https://smcloud-test.shimaowy.com/user-center/api/usercenter/v1/ucOrg/queryChildrenByUserId";

//protected String Urlrenzheng = "https://smsf-test.shimaowy.com/apiAccessToken";
//protected String Urlsyyysjl = "https://smsf-test.shimaowy.com/api/fee/fee-center/api/getTotalRate";


@end
