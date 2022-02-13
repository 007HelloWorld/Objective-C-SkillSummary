//
//  NetRequest.m
//  GreenLand
//
//  Created by 浩哥哥 on 2018/12/6.
//  Copyright © 2018年 chy. All rights reserved.
//

#import "NetRequest.h"
#import <AFNetworking.h>
#import <CPHelperTool/CPHelperTool.h>



//登录对象
#define kTicket                  @"ticket"
#define USER_NOTICENTER [NSNotificationCenter defaultCenter]
//退出登录
#define KLogOut                  @"logOut"

@implementation NetRequest

+ (id)request{
    return [[[self class] alloc] init];
}

+ (void)cacelAllRequest{
    AFHTTPSessionManager * manager = [AFTool manager];
    [manager.operationQueue cancelAllOperations];
}

- (void)startRequest:(NSString *)url requestType:(netRequestType)type params:(id)params resultHandle:(AFReqestResultBlock)resultHandle{
    
    AFHTTPSessionManager * manager = [AFTool manager];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonParamsStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    switch (type) {
        case netRequestTypePOST: {
        
            [manager POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"url====%@",url);
                NSLog(@"jsonParamsStr====%@",jsonParamsStr);
                
                [self handleRequestResultWithDataTask:task responseObject:responseObject error:nil resultBlock:resultHandle];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"请求失败url====%@",url);
                NSLog(@"jsonParamsStr====%@",jsonParamsStr);
                NSLog(@"error=====%@",error);
                
                [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultHandle];
            }];
            break;
        }
        case netRequestTypeGET: {
            
            [manager GET:url parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"url====%@",url);
                NSLog(@"jsonParamsStr====%@",jsonParamsStr);
                
                [self handleRequestResultWithDataTask:task responseObject:responseObject error:nil resultBlock:resultHandle];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"请求失败url====%@",url);
                NSLog(@"jsonParamsStr====%@",jsonParamsStr);
                NSLog(@"error=====%@",error);
                
                [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultHandle];
            }];
            
            break;
        }
        case netRequestTypeDELETE: {
            
            [manager DELETE:url parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"url====%@",url);
                NSLog(@"jsonParamsStr====%@",jsonParamsStr);
                
                [self handleRequestResultWithDataTask:task responseObject:responseObject error:nil resultBlock:resultHandle];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"请求失败url====%@",url);
                NSLog(@"jsonParamsStr====%@",jsonParamsStr);
                NSLog(@"error=====%@",error);
                
                [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultHandle];
            }];
            break;
        }
        case netRequestTypePUT: {
            
            [manager PUT:url parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"url====%@",url);
                NSLog(@"jsonParamsStr====%@",jsonParamsStr);
                
                [self handleRequestResultWithDataTask:task responseObject:responseObject error:nil resultBlock:resultHandle];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"请求失败url====%@",url);
                NSLog(@"jsonParamsStr====%@",jsonParamsStr);
                NSLog(@"error=====%@",error);
                
                [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultHandle];
            }];
            break;
        }
    }
}

- (void)startPatrolRequest:(NSString *)url requestM:(NSString *)requestM params:(id)params resultHandle:(AFReqestResultBlock)resultHandle {
    //传的Url 和 字典数据
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonParamsStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSURL *rurl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:rurl cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    NSError *error;
    NSString *bodyString = @"{}";
    NSData *data =[bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    [request setHTTPMethod:requestM];
    
//    NSString *areaIdStr = CUCFUDFGetValue(ORG_IDKey);
//    if (areaIdStr.length) {
//        [request setValue:areaIdStr forHTTPHeaderField:@"divide-id"];
//    }
    
    if (CUCFUDFGetValue(kTicket)){
        NSString *dicJson = CUCFUDFGetValue(kTicket);
        
        NSDictionary *dic = [NSDictionary jsonStringToDictionary:dicJson];
        NSString *tokenStr = [NSString stringWithFormat:@"Bearer %@",dic[@"token"]];
        [request setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    }
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    NSError *error = nil;
    if (params) {
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error]];
    }
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   
                                   NSLog(@"请求失败url====%@",url);
                                   NSLog(@"jsonParamsStr====%@",jsonParamsStr);
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                                   
                                   NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
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
                                   }else{
                                       
                                   }
                                   [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultHandle];
                                   
                               } else {
                                   
//                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//                                   NSLog(@"HttpResponseCode===:%ld", (long)responseCode);
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   NSLog(@"HttpResponseBody===%@",responseString);
                                   
                                   NSLog(@"url====%@",url);
                                   NSLog(@"jsonParamsStr====%@",jsonParamsStr);
                                   
                                   NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   if ([url containsString:@"/api/appcenter/v1/userSloganRef/getByUserId"]) {
                                       [self handleRequestResultWithDataTask:task responseObject:@{@"slogan":responseString} error:nil resultBlock:resultHandle];
                                   }else {
                                       NSDictionary *dicjson = (NSDictionary *)json;
                                       [self handleRequestResultWithDataTask:task responseObject:dicjson error:nil resultBlock:resultHandle];
                                   }
                                   
                               }
                           }];
    
}

- (void)startNetRequest:(NSString *)url requestM:(NSString *)requestM params:(id)params resultHandle:(AFReqestResultBlock)resultHandle {
    
    //传的Url 和 字典数据
    NSData *jsonData = nil;
    NSString *jsonParamsStr = @"";
    if (params) {
        jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        jsonParamsStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSURL *rurl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:rurl cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:requestM];
    
//    NSString *areaIdStr = CUCFUDFGetValue(ORG_IDKey);
//    if (areaIdStr.length) {
//        [request setValue:areaIdStr forHTTPHeaderField:@"divide-id"];
//    }
    
    if (CUCFUDFGetValue(kTicket)){
        NSString *dicJson = CUCFUDFGetValue(kTicket);
        NSDictionary *dic = [NSDictionary jsonStringToDictionary:dicJson];
        NSString *tokenStr = [NSString stringWithFormat:@"Bearer %@",dic[@"token"]];
        [request setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    }
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSError *error = nil;
    if (params) {
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error]];
    }
    
    
//    [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"responseString:%@",responseString);
//    }];
//    return;
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request];
    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   
                                   NSLog(@"请求失败url====%@",url);
                                   NSLog(@"jsonParamsStr====%@",jsonParamsStr);
//                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                                   
                                   NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                                   NSInteger responseStatue = response.statusCode;
//                                   if (responseStatue == 401 || responseStatue == 403 || responseStatue == 0) {
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
                                   }else{
                                       
                                   }
                                   [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultHandle];
                                   
                               } else {
                                   
//                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                                   NSLog(@"HttpResponseCode===:%ld", (long)responseCode);
//                                   NSLog(@"HttpResponseBody===%@",responseString);
                                   
                                   NSLog(@"url====%@",url);
                                   NSLog(@"jsonParamsStr====%@",jsonParamsStr);
                                   
                                   NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   if ([url containsString:@"/api/appcenter/v1/userSloganRef/getByUserId"]) {
                                       [self handleRequestResultWithDataTask:task responseObject:@{@"slogan":responseString} error:nil resultBlock:resultHandle];
                                   }else {
                                       NSDictionary *dicjson = (NSDictionary *)json;
                                       [self handleRequestResultWithDataTask:task responseObject:dicjson error:nil resultBlock:resultHandle];
                                   }
                                   
                               }
                           }];
    
}

- (void)startUpload:(NSString *)url uploadData:(NSData *)data params:(id)params resultHandle:(AFReqestResultBlock) resultHandle progressHandle:(AFReqestResultBlock)progressHandle {
    AFHTTPSessionManager * manager = [AFTool managerWithType:@"multipart/form-data"];
    
    
    [manager POST:url parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"file.jpeg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if(progressHandle) {
            progressHandle(uploadProgress,nil);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"图片上传成功Url====%@", url);
        
        [self handleRequestResultWithDataTask:task responseObject:responseObject error:nil resultBlock:resultHandle];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"图片上传失败Url====%@", url);
        
        [self handleRequestResultWithDataTask:task responseObject:nil error:error resultBlock:resultHandle];
    }];
}

- (void)handleRequestResultWithDataTask:(NSURLSessionDataTask *)task
                         responseObject:(id)responseObject
                                  error:(NSError *)error
                            resultBlock:(AFReqestResultBlock)resultBlock {
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
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
    
    if (self.enableLog&&task) {
        NSURLRequest *request = task.currentRequest;
        NSURLResponse * response = task.response;
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        
        NSLog(@"  %@ '%@': %@ ", [request HTTPMethod], [[request URL] absoluteString], [request allHTTPHeaderFields]);
        NSLog(@"response:  %@ '%@'  ",[HTTPResponse URL], [HTTPResponse allHeaderFields]);
    }
    
    NSDictionary * responseJson = responseObject;
    if (responseObject) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        responseJson = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        //展示json数据
        NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"responseJson===%@",str);
    }
    
    //do something here...
    if(resultBlock) {
        resultBlock(responseJson,error);
    }
}

@end
