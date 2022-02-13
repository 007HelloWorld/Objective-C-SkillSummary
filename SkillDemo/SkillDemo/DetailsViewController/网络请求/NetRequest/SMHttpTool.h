//
//  SMHttpTool.h
//  SMProject
//
//  Created by lk on 2019/3/15.
//  Copyright © 2019 浩哥哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SMHttpTool;
//网络请求成功失败的block
typedef void (^httpRequestSuccess)(NSInteger code, id responseObject);
typedef void (^httpRequestFailure)(NSError *error);

@interface SMHttpTool : NSObject
@property (nonatomic, copy) NSString *BASEURL;
@property (nonatomic, copy) NSString *customBASEURL;
@property (nonatomic, copy) NSString *ANOTHERBASEURL;
@property (nonatomic, copy) NSString *HTMLBASEURL;
@property (nonatomic,copy) NSString * PicBaseUrl;

+(SMHttpTool *)shareInstance;

- (void)httpSessionAutoWithUrl:(NSString *)url sendDic:(NSMutableDictionary *)sendDic httpMethod:(NSString *)httpMethod success:(httpRequestSuccess)success faild:(httpRequestFailure)failure;

- (void)httpSessionWithUrl:(NSString *)url sendDic:(NSMutableDictionary *)sendDic httpMethod:(NSString *)httpMethod success:(httpRequestSuccess)success faild:(httpRequestFailure)failure;

/**1.登录获取token和userId*/
- (void)ucAuthAutoWithSuccessed:(NSDictionary *)sendDic success:(httpRequestSuccess)success faild:(httpRequestFailure)failure;

/**1.登录获取token和userId*/
- (void)ucAuthWithSuccessed:(NSDictionary *)sendDic success:(httpRequestSuccess)success faild:(httpRequestFailure)failure;

/**2.6 待办统计-计划、巡查、派工单*/
- (void)planWaitCountWithSuccessed:(NSDictionary *)sendDic success:(httpRequestSuccess)success faild:(httpRequestFailure)failure;

//4 认证
- (void)authenticationWithSuccessed:(NSDictionary *)sendDic success:(httpRequestSuccess)success faild:(httpRequestFailure)failure;

//组织列表接口 不传父id返回根节点
- (void)getOrgListWithSuccessed:(NSDictionary *)sendDic success:(httpRequestSuccess)success faild:(httpRequestFailure)failure;

@end
