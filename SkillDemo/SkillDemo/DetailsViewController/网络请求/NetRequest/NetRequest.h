//
//  NetRequest.h
//  GreenLand
//
//  Created by 浩哥哥 on 2018/12/6.
//  Copyright © 2018年 chy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFTool.h"

/** 网络请求方式 */
typedef NS_ENUM(NSInteger, netRequestType){
    /**
     *  GET方式
     */
    netRequestTypeGET = 0,
    /**
     *  POST方式
     */
    netRequestTypePOST = 1,
    /**
     *  DELETE方式
     */
    netRequestTypeDELETE = 2,
    /**
     *  Put方式
     */
    netRequestTypePUT  = 3
};


/**
 *  请求结束后执行的block
 */
typedef void(^AFReqestResultBlock)(id responseObj, NSError * err);

@interface NetRequest : NSObject

/** 是否打印request信息 */
@property(assign, nonatomic) BOOL  enableLog;

+ (id)request;

/**
 *  取消掉所有请求
 */
+ (void)cacelAllRequest;

/**
 *  开始一个http请求;
 *
 *  @param url          请求接口地址
 *  @param type         请求类型
 *  @param params       请求提交表单参数
 *  @param resultHandle 请求结束后执行的block
 */
- (void)startRequest:(NSString *)url requestType:(netRequestType) type params:(id)params resultHandle:(AFReqestResultBlock) resultHandle;


/**
 开始一个json 的 http请求;

 @param url             请求接口地址
 @param requestM        请求类型:"GET" / "POST"
 @param params          请求提交表单参数
 @param resultHandle    请求结束后执行的block
 */
- (void)startNetRequest:(NSString *)url requestM:(NSString *)requestM params:(id)params resultHandle:(AFReqestResultBlock) resultHandle;


- (void)startPatrolRequest:(NSString *)url requestM:(NSString *)requestM params:(id)params resultHandle:(AFReqestResultBlock)resultHandle;

/**
 *  进行一个上传数据动作
 *
 *  @param url          请求接口地址
 *  @param data         上传数据
 *  @param params       请求提交表单参数
 *  @param resultHandle 请求结束后执行的block
 */
- (void)startUpload:(NSString *)url uploadData:(NSData *)data params:(id)params resultHandle:(AFReqestResultBlock) resultHandle progressHandle:(AFReqestResultBlock)progressHandle;

@end

