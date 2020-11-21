//
//  ALiPayModel.h
//  ZhiTong
//
//  Created by 付凯 on 16/6/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaseModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"

@interface ALiPayModel : BaseModel
//商户号
@property(nonatomic, copy) NSString * partner;
//商户账号
@property(nonatomic, copy) NSString * seller;
//商品交易流水号
@property(nonatomic, copy) NSString * tradeNO;
//商品名称
@property(nonatomic, copy) NSString * productName;
//商品描述
@property(nonatomic, copy) NSString * productDescription;
//商品价格
@property(nonatomic, copy) NSString * amount;
//回调地址
@property(nonatomic, copy) NSString * notifyURL;
//写死   手机支付 支付宝用于支付服务判断
@property(nonatomic, copy) NSString * service;
//
@property(nonatomic, copy) NSString * paymentType;
//
@property(nonatomic, copy) NSString * inputCharset;
//
@property(nonatomic, copy) NSString * itBPay;
//
@property(nonatomic, copy) NSString * showUrl;
//
@property(nonatomic, copy) NSString * rsaDate;//可选
//
@property(nonatomic, copy) NSString * appID;//可选

@property(nonatomic,assign)int payMode; //0 订单支付    1 加油支付  默认0

@property(nonatomic, readonly) NSMutableDictionary * extraParams;

@property (nonatomic, copy) NSString *orderString;  // 接口返回的商品信息

- (instancetype)initWithPayMode:(int)payMode; // 油卡支付初始化方法

- (instancetype)initWithOrderString:(NSString *)orderString; // 支付宝多账户初始化方法

- (void)aliPayWithSuccessCallback:(void (^) (void))successCallback errorCallback:(void (^)(NSString *errorMsg))errorCallback;

@end

//支付宝文档 https://docs.open.alipay.com/204/105295/
