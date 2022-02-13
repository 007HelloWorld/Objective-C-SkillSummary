//
//  AFTool.m
//  citycustomization
//
//  Created by 浩哥哥 on 2018/8/18.
//  Copyright © 2018年 GDMM. All rights reserved.
//

#import "AFTool.h"
#import <CPHelperTool/CPHelperTool.h>

//登录对象
#define kTicket                  @"ticket"


@implementation AFTool

+ (AFHTTPSessionManager *)manager {
    static AFHTTPSessionManager * instance ;
    static dispatch_once_t onceToken;

//    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        instance = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
        NSSet *acceptableContentTypes = [NSSet setWithObjects:
                                         @"application/json",
                                         @"text/html",
                                         @"text/json",
                                         @"text/javascript",
                                         @"text/plain",
                                         @"text/xml",nil];
        
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
//        instance.responseSerializer = [AFJSONResponseSerializer serializer];
    
        [instance.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    
//        NSString *areaIdStr = CUCFUDFGetValue(ORG_IDKey);
//        if (areaIdStr.length) {
//            [instance.requestSerializer setValue:areaIdStr forHTTPHeaderField:@"divide-id"];
//        }
    
        
        if (CUCFUDFGetValue(kTicket)){
            NSString *dicJson = CUCFUDFGetValue(kTicket);
            NSDictionary *dic = [NSDictionary jsonStringToDictionary:dicJson];
            NSString *tokenStr = [NSString stringWithFormat:@"Bearer %@",dic[@"token"]];
            [instance.requestSerializer setValue:tokenStr forHTTPHeaderField:@"Authorization"];
        }
        
        instance.responseSerializer.acceptableContentTypes = acceptableContentTypes;
        instance.requestSerializer.allowsCellularAccess = YES;
        instance.requestSerializer.HTTPShouldHandleCookies = YES;
        instance.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        instance.securityPolicy.allowInvalidCertificates = YES;
        [instance.securityPolicy setValidatesDomainName:NO];
        instance.requestSerializer.timeoutInterval = 30;

//    });
    
    return instance;
}

+ (AFHTTPSessionManager *)robManager {
    static AFHTTPSessionManager * instance ;
//    static dispatch_once_t onceToken;
    
    //    dispatch_once(&onceToken, ^{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    instance = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
    NSSet *acceptableContentTypes = [NSSet setWithObjects:
                                     @"application/json",
                                     @"text/html",
                                     @"text/json",
                                     @"text/javascript",
                                     @"text/plain",
                                     @"text/xml",nil];
    
//    instance.requestSerializer = [AFJSONRequestSerializer serializer];
//    instance.responseSerializer = [AFJSONResponseSerializer serializer];
    [instance.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
//    NSString *areaIdStr = CUCFUDFGetValue(ORG_IDKey);
//    if (areaIdStr.length) {
//        [instance.requestSerializer setValue:areaIdStr forHTTPHeaderField:@"divide-id"];
//    }
    
    
    if (CUCFUDFGetValue(kTicket))
    {
        NSString *dicJson = CUCFUDFGetValue(kTicket);
        NSDictionary *dic = [NSDictionary jsonStringToDictionary:dicJson];
        NSString *tokenStr = [NSString stringWithFormat:@"Bearer %@",dic[@"token"]];
        [instance.requestSerializer setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    }
    
    instance.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    instance.requestSerializer.allowsCellularAccess = YES;
    instance.requestSerializer.HTTPShouldHandleCookies = YES;
    instance.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    instance.securityPolicy.allowInvalidCertificates = YES;
    [instance.securityPolicy setValidatesDomainName:NO];
    instance.requestSerializer.timeoutInterval = 30;

    //    });
    
    return instance;
}

+ (AFHTTPSessionManager *)managerWithType:(NSString *)contentType {
    static AFHTTPSessionManager * instance ;
    static dispatch_once_t onceToken;
    
    //    dispatch_once(&onceToken, ^{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    instance = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
    NSSet *acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                     @"text/html",
                                     @"text/json",
                                     @"text/javascript",
                                     @"text/plain",
                                     @"image/jpeg",
                                     @"image/png", nil];
    
    instance.requestSerializer = [AFJSONRequestSerializer serializer];
    instance.responseSerializer = [AFJSONResponseSerializer serializer];
    [instance.requestSerializer setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
//    NSString *areaIdStr = CUCFUDFGetValue(ORG_IDKey);
//    if (areaIdStr.length) {
//        [instance.requestSerializer setValue:areaIdStr forHTTPHeaderField:@"divide-id"];
//    }
    
    
    if (CUCFUDFGetValue(kTicket))
    {
        NSString *dicJson = CUCFUDFGetValue(kTicket);
        NSDictionary *dic = [NSDictionary jsonStringToDictionary:dicJson];
        NSString *tokenStr = [NSString stringWithFormat:@"Bearer %@",dic[@"token"]];
        [instance.requestSerializer setValue:tokenStr forHTTPHeaderField:@"Authorization"];
    }
    
    instance.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    instance.requestSerializer.allowsCellularAccess = YES;
    instance.requestSerializer.HTTPShouldHandleCookies = YES;
    instance.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    instance.securityPolicy.allowInvalidCertificates = YES;
    [instance.securityPolicy setValidatesDomainName:NO];
    instance.requestSerializer.timeoutInterval = 30;

    //    });
    
    return instance;
}

@end
